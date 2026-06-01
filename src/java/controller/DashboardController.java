package controller;

import dao.CarDAO;
import dao.TierDAO;
import dto.Car;
import dto.Customer;
import dto.Tier;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * DashboardController - Tính toán tất cả dữ liệu Tier, Points, Next Reward
 * từ cơ sở dữ liệu động rồi truyền sang JSP để hiển thị.
 */
@WebServlet(name = "DashboardController", urlPatterns = {"/DashboardController"})
public class DashboardController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // 1. Kiểm tra đăng nhập
            Customer us = (Customer) request.getSession().getAttribute("USER");
            if (us == null) {
                response.sendRedirect("login_page.jsp");
                return;
            }

            // 2. Lấy danh sách xe liên kết
            CarDAO carDAO = new CarDAO();
            List<Car> carList = carDAO.getAllCars(us.getCusId());
            request.setAttribute("LISTCARS", carList);

            // 3. Truy vấn thông tin Tier động từ DB (Không fix cứng)
            String currentTierId = us.getCurrentTierId();
            if (currentTierId == null || currentTierId.isEmpty()) {
                currentTierId = "MEMBER";
            }

            TierDAO tierDAO = new TierDAO();
            List<Tier> tierList = tierDAO.getAllTiers();
            
            Tier currentTier = null;
            Tier nextTierObj = null;

            for (int i = 0; i < tierList.size(); i++) {
                Tier t = tierList.get(i);
                if (t.getTierId().equalsIgnoreCase(currentTierId)) {
                    currentTier = t;
                    if (i < tierList.size() - 1) {
                        nextTierObj = tierList.get(i + 1);
                    }
                    break;
                }
            }

            // Phòng hờ nếu DB rỗng hoặc không tìm thấy
            if (currentTier == null) {
                currentTier = new Tier("MEMBER", "Thành Viên", 0, 0, 1.0, 7);
            }

            String tierDisplayName = currentTier.getTierName();
            double multiplier      = currentTier.getMultiplier();
            int bookingDays        = currentTier.getBookingDays();
            
            String nextTier;
            String nextTierDisplay;

            // 4. Tính tiến trình Next Reward
            int currentWashes    = us.getTotalWashes();
            double currentSpent  = us.getTotalSpent();
            int pointsBalance    = us.getPointsBalance();

            double maxProgress;
            String progressText;

            if (nextTierObj != null) {
                nextTier        = nextTierObj.getTierId();
                nextTierDisplay = nextTierObj.getTierName();
                
                double washProgress  = Math.min(100.0, ((double) currentWashes / nextTierObj.getMinWashes()) * 100.0);
                double spentProgress = Math.min(100.0, (currentSpent / nextTierObj.getMinSpent()) * 100.0);
                maxProgress = Math.max(washProgress, spentProgress);

                int remainingWashes    = Math.max(0, nextTierObj.getMinWashes() - currentWashes);
                double remainingSpent  = Math.max(0.0, nextTierObj.getMinSpent() - currentSpent);

                // Text mô tả quyền lợi hạng kế theo SRS
                String benefitText;
                switch (nextTier) {
                    case "SILVER":
                        benefitText = "nhận ưu đãi nhân <strong>1.1x</strong> điểm thưởng";
                        break;
                    case "GOLD":
                        benefitText = "nhận ngay đặc quyền đặt lịch trước <strong>12 ngày</strong> và nâng cấp dịch vụ miễn phí";
                        break;
                    default: // PLATINUM
                        benefitText = "nhận ngay ưu đãi cao nhất: đặt lịch trước <strong>14 ngày</strong> và tặng 01 lần rửa xe miễn phí";
                        break;
                }

                progressText = "Bạn chỉ còn cách hạng <strong>" + nextTierDisplay + "</strong> "
                             + "<strong>" + remainingWashes + " lượt rửa</strong> hoặc "
                             + "<strong>" + String.format("%,.0f", remainingSpent) + " VNĐ</strong> chi tiêu để " + benefitText + "!";
            } else {
                nextTier        = "NONE";
                nextTierDisplay = "—";
                
                // PLATINUM – hướng đến đổi quà Nano
                maxProgress = Math.min(100.0, ((double) pointsBalance / 300.0) * 100.0);
                progressText = "Bạn đang sở hữu <strong>" + pointsBalance + "/300 điểm</strong> để đổi ngay "
                             + "<strong>01 lần Phủ Wax/Nano miễn phí</strong> trị giá 30.000 VNĐ!";
            }

            // 5. Set tất cả attributes cho JSP
            request.setAttribute("TIER_ID",           currentTierId);
            request.setAttribute("TIER_DISPLAY",      tierDisplayName);
            request.setAttribute("MULTIPLIER",        multiplier);
            request.setAttribute("BOOKING_DAYS",      bookingDays);
            request.setAttribute("NEXT_TIER",         nextTier);
            request.setAttribute("NEXT_TIER_DISPLAY", nextTierDisplay);
            request.setAttribute("CURRENT_WASHES",    currentWashes);
            request.setAttribute("CURRENT_SPENT",     currentSpent);
            request.setAttribute("POINTS_BALANCE",    pointsBalance);
            request.setAttribute("MAX_PROGRESS",      maxProgress);
            request.setAttribute("PROGRESS_TEXT",     progressText);
            request.setAttribute("POINTS_VALUE_VND",  String.format("%,d", pointsBalance * 100));
            request.setAttribute("SPENT_FORMATTED",   String.format("%,.0f", currentSpent));

            // 6. Forward sang JSP
            request.getRequestDispatcher("customerDashboard_page.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error at DashboardController: " + e.toString());
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
