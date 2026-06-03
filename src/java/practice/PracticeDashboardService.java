package practice;

import dao.CarDAO;
import dao.TierDAO;
import dto.Car;
import dto.Customer;
import dto.DashboardData;
import dto.Tier;
import java.util.List;

/**
 * FILE THỰC HÀNH ÔN TẬP NGHIỆP VỤ DASHBOARD LOYALTY
 * 
 * Nhiệm vụ của bạn: Hoàn thành phương thức getDashboardData để tính toán 
 * thông tin thăng hạng thành viên và hiển thị tiến trình của khách hàng.
 */
public class PracticeDashboardService {
    private final CarDAO carDAO = new CarDAO();
    private final TierDAO tierDAO = new TierDAO();

    /**
     * BÀI TẬP: Lấy dữ liệu và tính toán toàn bộ thông tin loyalty cho khách hàng đăng nhập.
     * Các bước cần thực hiện trong TODO dưới đây:
     * 1. Lấy danh sách xe của khách hàng từ carDAO.
     * 2. Xác định hạng hiện tại (từ us.getCurrentTierId() - mặc định là "MEMBER" nếu rỗng).
     * 3. Lấy toàn bộ danh sách Hạng (Tiers) từ tierDAO.getAllTiers() (danh sách đã được sắp xếp tăng dần theo lượt rửa tối thiểu).
     * 4. Tìm đối tượng Hạng hiện tại (currentTier) và tìm đối tượng Hạng kế tiếp (nextTierObj).
     *    - Gợi ý: Duyệt danh sách tiers, nếu thấy tier nào trùng ID với hạng hiện tại -> đó là currentTier. 
     *      Nếu chưa phải hạng cuối cùng, thì phần tử tiếp theo chính là nextTierObj.
     * 5. Tính toán tiến trình % đạt được hạng kế tiếp:
     *    - Công thức % theo lượt rửa: (currentWashes / nextTierObj.getMinWashes()) * 100
     *    - Công thức % theo chi tiêu: (currentSpent / nextTierObj.getMinSpent()) * 100
     *    - Đề bài yêu cầu lấy tiến trình lớn hơn trong hai cái để kích thích khách hàng: maxProgress = Math.max(washProgress, spentProgress)
     *    - Giới hạn tiến trình tối đa không quá 100% bằng Math.min(100.0, ...).
     * 6. Tính số lượt rửa còn thiếu (remainingWashes) và số tiền chi tiêu còn thiếu (remainingSpent).
     * 7. Tạo dòng thông báo tiến trình động (progressText) dựa vào hạng tiếp theo (SILVER, GOLD, PLATINUM).
     * 8. THƯỞNG ĐẶC BIỆT: Nếu khách hàng đã đạt hạng cao nhất (PLATINUM) (tức là nextTierObj == null):
     *    - Tính tiến trình hướng tới đổi quà (Nano): Cần 300 điểm thưởng.
     *    - maxProgress = (pointsBalance / 300.0) * 100 (tối đa 100.0).
     *    - progressText = mô tả số điểm hiện tại / 300 và quà tặng nhận được.
     */
    public DashboardData getDashboardData(Customer us) throws Exception {
        if (us == null) {
            throw new Exception("Không có thông tin người dùng đăng nhập!");
        }

        // TODO: THỰC HÀNH TÍNH TOÁN DỮ LIỆU ĐỘNG Ở ĐÂY
        // Dưới đây là khung sườn hướng dẫn chi tiết để bạn tự viết code:

        // 1. Lấy danh sách xe liên kết
        // List<Car> carList = ...
        
        // 2. Xác định hạng hiện tại và lấy danh sách Hạng từ DB
        // String currentTierId = us.getCurrentTierId();
        // ...
        
        // 3. Tìm currentTier và nextTierObj
        // ...
        
        // 4. Tính toán tiến trình % và số lượng còn thiếu
        // int currentWashes = us.getTotalWashes();
        // double currentSpent = us.getTotalSpent();
        // int pointsBalance = us.getPointsBalance();
        // ...
        
        // 5. Chuẩn bị định dạng chuỗi hiển thị tiền tệ VNĐ và giá trị quy đổi điểm
        // String pointsValueVnd = ... (1 điểm = 100 VNĐ)
        // String spentFormatted = ... (Định dạng dấu phẩy phân tách nghìn)

        // 6. Trả về đối tượng DashboardData đầy đủ tham số
        
        return null; // Thay đổi bằng việc return new DashboardData(...) phù hợp
    }
}
