package services;

import dao.CarDAO;
import dao.TierDAO;
import dto.Car;
import dto.Customer;
import dto.DashboardData;
import dto.Tier;
import java.util.List;

/**
 * DashboardService - Lớp dịch vụ xử lý nghiệp vụ tính toán loyalty và thăng hạng thành viên.
 */
public class DashboardService {
    private final CarDAO carDAO = new CarDAO();
    private final TierDAO tierDAO = new TierDAO();

    /**
     * Tính toán toàn bộ thông tin loyalty và lấy danh sách xe của khách hàng.
     */
    public DashboardData getDashboardData(Customer us) throws Exception {
        if (us == null) {
            throw new Exception("Không có thông tin người dùng đăng nhập!");
        }

        // 1. Lấy danh sách xe liên kết
        List<Car> carList = carDAO.getAllCars(us.getCusId());

        // 2. Truy vấn thông tin Tier động từ DB (Không fix cứng)
        String currentTierId = us.getCurrentTierId();
        if (currentTierId == null || currentTierId.isEmpty()) {
            currentTierId = "MEMBER";
        }

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

        // 3. Tính tiến trình Next Reward
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

        String pointsValueVnd = String.format("%,d", pointsBalance * 100);
        String spentFormatted = String.format("%,.0f", currentSpent);

        return new DashboardData(
            currentTierId,
            tierDisplayName,
            multiplier,
            bookingDays,
            nextTier,
            nextTierDisplay,
            currentWashes,
            currentSpent,
            pointsBalance,
            maxProgress,
            progressText,
            pointsValueVnd,
            spentFormatted,
            carList
        );
    }
}
