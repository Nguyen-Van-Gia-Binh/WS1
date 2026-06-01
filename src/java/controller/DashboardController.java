package controller;

import dto.Customer;
import dto.DashboardData;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.DashboardService;

/**
 * DashboardController - Nhận yêu cầu và điều hướng sang trang Dashboard bằng cách 
 * gọi DashboardService để tính toán tất cả dữ liệu loyalty động.
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
                response.sendRedirect("MainController?action=Login");
                return;
            }

            // 2. Gọi DashboardService để tính toán dữ liệu
            DashboardService dashboardService = new DashboardService();
            DashboardData data = dashboardService.getDashboardData(us);

            // 3. Đặt các thuộc tính request từ đối tượng dữ liệu trả về
            request.setAttribute("LISTCARS",           data.getCarList());
            request.setAttribute("TIER_ID",           data.getTierId());
            request.setAttribute("TIER_DISPLAY",      data.getTierDisplayName());
            request.setAttribute("MULTIPLIER",        data.getMultiplier());
            request.setAttribute("BOOKING_DAYS",      data.getBookingDays());
            request.setAttribute("NEXT_TIER",         data.getNextTier());
            request.setAttribute("NEXT_TIER_DISPLAY", data.getNextTierDisplay());
            request.setAttribute("CURRENT_WASHES",    data.getCurrentWashes());
            request.setAttribute("CURRENT_SPENT",     data.getCurrentSpent());
            request.setAttribute("POINTS_BALANCE",    data.getPointsBalance());
            request.setAttribute("MAX_PROGRESS",      data.getMaxProgress());
            request.setAttribute("PROGRESS_TEXT",     data.getProgressText());
            request.setAttribute("POINTS_VALUE_VND",  data.getPointsValueVnd());
            request.setAttribute("SPENT_FORMATTED",   data.getSpentFormatted());

            // 4. Chuyển tiếp sang View
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

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
