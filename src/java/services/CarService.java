package services;

import dao.CarDAO;
import dto.Car;
import java.sql.Date;
import java.util.List;

/**
 * CarService - Lớp dịch vụ xử lý nghiệp vụ cho Xe (License Plates)
 */
public class CarService {
    private final CarDAO carDAO = new CarDAO();

    /**
     * Lấy danh sách xe của một khách hàng.
     */
    public List<Car> getCarsByCustomerId(int customerId) throws Exception {
        return carDAO.getAllCars(customerId);
    }

    /**
     * Đăng ký xe mới cho khách hàng.
     * Thực hiện kiểm tra định dạng biển số xe.
     */
    public void registerNewCar(int customerId, String licensePlate, String brand, String model, String color) throws Exception {
        if (licensePlate == null || licensePlate.trim().isEmpty()) {
            throw new Exception("Biển số xe không được để trống!");
        }

        String plateFormatted = licensePlate.trim().toUpperCase();

        // Regex định dạng biển số xe Việt Nam (server-side)
        String regex = "^\\d{2}[A-Z]\\d-\\d{4,5}$"
                     + "|^\\d{2}[A-Z]\\d-\\d{3}\\.\\d{2}$"
                     + "|^\\d{2}[A-Z]-\\d{4,5}$"
                     + "|^\\d{2}[A-Z]-\\d{3}\\.\\d{2}$";

        if (!plateFormatted.matches(regex)) {
            throw new Exception("Biển số xe không đúng định dạng Việt Nam! Ví dụ hợp lệ: 30A1-1234 hoặc 51F1-999.99");
        }

        Car car = new Car(
            customerId,
            plateFormatted,
            brand != null ? brand.trim() : "",
            model != null ? model.trim() : "",
            color != null ? color.trim() : "",
            new Date(System.currentTimeMillis())
        );

        int result = carDAO.addCar(car);
        if (result <= 0) {
            throw new Exception("Đăng ký xe thất bại. Biển số " + plateFormatted + " có thể đã được đăng ký trước đó!");
        }
    }

    /**
     * BÀI TẬP / NGHIỆP VỤ SỬA XE (VALIDATION VÀ CẬP NHẬT XE):
     * 1. Kiểm tra rỗng: Nếu licensePlate null hoặc rỗng -> ném Exception "Biển số xe không được để trống!".
     * 2. Chuẩn hóa biển số: Bỏ khoảng trắng dư thừa (trim()) và chuyển thành chữ HOA (toUpperCase()).
     * 3. Kiểm tra định dạng (Regex): So sánh biển số với mẫu biển số xe Việt Nam. Nếu sai, ném Exception báo sai định dạng.
     * 4. Khởi tạo đối tượng Car: Đầy đủ các tham số (plateId, customerId, biển số đã chuẩn hóa, hãng xe, dòng xe, màu xe, ngày hiện tại).
     * 5. Gọi DAO và Bắt lỗi trùng biển số (Unique Constraint):
     *    - Chạy carDAO.updateCar(car). Nếu kết quả <= 0 -> ném Exception báo cập nhật thất bại.
     *    - Khối catch Exception: Nếu e.getMessage() chứa từ khóa báo trùng như "UQ_", "UNIQUE", "duplicate", "trùng" 
     *      -> ném ngoại lệ mới thân thiện: "Cập nhật xe thất bại. Biển số [biển_số] đã được đăng ký cho xe khác!".
     */
    public void updateCar(int customerId, int plateId, String licensePlate, String brand, String model, String color) throws Exception {
        if (licensePlate == null || licensePlate.trim().isEmpty()) {
            throw new Exception("Biển số xe không được để trống!");
        }

        String plateFormatted = licensePlate.trim().toUpperCase();

        // Regex định dạng biển số xe Việt Nam (server-side)
        String regex = "^\\d{2}[A-Z]\\d-\\d{4,5}$"
                     + "|^\\d{2}[A-Z]\\d-\\d{3}\\.\\d{2}$"
                     + "|^\\d{2}[A-Z]-\\d{4,5}$"
                     + "|^\\d{2}[A-Z]-\\d{3}\\.\\d{2}$";

        if (!plateFormatted.matches(regex)) {
            throw new Exception("Biển số xe không đúng định dạng Việt Nam! Ví dụ hợp lệ: 30A1-1234 hoặc 51F1-999.99");
        }

        Car car = new Car(
            plateId,
            customerId,
            plateFormatted,
            brand != null ? brand.trim() : "",
            model != null ? model.trim() : "",
            color != null ? color.trim() : "",
            new Date(System.currentTimeMillis())
        );

        try {
            int result = carDAO.updateCar(car);
            if (result <= 0) {
                throw new Exception("Cập nhật xe thất bại. Xe có thể không tồn tại hoặc bạn không có quyền chỉnh sửa!");
            }
        } catch (Exception e) {
            String msg = e.getMessage();
            if (msg != null && (msg.contains("UQ_") || msg.contains("UNIQUE") || msg.contains("duplicate") || msg.contains("trùng"))) {
                throw new Exception("Cập nhật xe thất bại. Biển số " + plateFormatted + " đã được đăng ký cho xe khác!");
            }
            throw e;
        }
    }

    /**
     * BÀI TẬP / NGHIỆP VỤ XÓA XE (XỬ LÝ RÀNG BUỘC KHÓA NGOẠI):
     * 1. Gọi DAO xóa xe: Chạy carDAO.deleteCar(plateId, customerId) (truyền cả customerId để đảm bảo tính an toàn, tránh xóa chéo xe).
     * 2. Kiểm tra kết quả: Nếu kết quả trả về <= 0 -> ném Exception báo xe không tồn tại hoặc không thuộc quyền sở hữu.
     * 3. Khối catch Exception bắt lỗi ràng buộc khóa ngoại (Foreign Key Constraint):
     *    - Nếu xóa xe đang có lịch rửa xe liên kết, DB sẽ chặn lại và quăng lỗi ràng buộc khóa ngoại.
     *    - Nếu e.getMessage() chứa các từ khóa khóa ngoại như "REFERENCE", "constraint", "foreign key", "FK_", "conflicted"
     *      -> ném ngoại lệ mới thân thiện: "Không thể xóa xe này vì đang có lịch đặt rửa xe liên kết với xe. Vui lòng hủy lịch đặt trước khi xóa!".
     */
    public void deleteCar(int customerId, int plateId) throws Exception {
        try {
            int result = carDAO.deleteCar(plateId, customerId);
            if (result <= 0) {
                throw new Exception("Xóa xe thất bại. Xe có thể không tồn tại hoặc bạn không có quyền xóa!");
            }
        } catch (Exception e) {
            String msg = e.getMessage();
            if (msg != null && (msg.contains("REFERENCE") || msg.contains("constraint") || msg.contains("foreign key") || msg.contains("FK_") || msg.contains("conflicted"))) {
                throw new Exception("Không thể xóa xe này vì đang có lịch đặt rửa xe liên kết với xe. Vui lòng hủy lịch đặt trước khi xóa!");
            }
            throw e;
        }
    }
}

