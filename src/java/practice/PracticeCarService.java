package practice;

import dao.CarDAO;
import dto.Car;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * FILE THỰC HÀNH ÔN TẬP TẦNG SERVICE & VALIDATION LOGIC
 * 
 * Nhiệm vụ của bạn: Viết logic nghiệp vụ kiểm tra thông tin đầu vào (validation)
 * trước khi gọi tầng DAO để ghi xuống Database.
 */
public class PracticeCarService {
    private final CarDAO carDAO = new CarDAO();

    /**
     * BÀI TẬP: Đăng ký xe mới cho khách hàng.
     * Yêu cầu nghiệp vụ (Business Rule):
     * 1. Biển số xe không được để trống.
     * 2. Phải chuẩn hóa biển số xe bằng cách bỏ khoảng trắng thừa đầu đuôi và chuyển thành chữ HOA.
     * 3. Biển số xe phải đúng định dạng Việt Nam (sử dụng biểu thức chính quy - Regular Expression).
     *    Biểu thức chính quy mẫu: 
     *    String regex = "^\\d{2}[A-Z]\\d-\\d{4,5}$"
     *                 + "|^\\d{2}[A-Z]\\d-\\d{3}\\.\\d{2}$"
     *                 + "|^\\d{2}[A-Z]-\\d{4,5}$"
     *                 + "|^\\d{2}[A-Z]-\\d{3}\\.\\d{2}$";
     * 4. Nếu không hợp lệ, ném ra ngoại lệ `new Exception("Thông điệp báo lỗi cụ thể")`.
     * 5. Nếu hợp lệ, tạo mới đối tượng Car và gọi `carDAO.addCar(car)`.
     */
    public void registerNewCar(int customerId, String licensePlate, String brand, String model, String color) throws Exception {
        
        // TODO: VIẾT CODE VALIDATION VÀ GỌI DAO Ở ĐÂY
        // Gợi ý từng bước cho vấn đáp:
        // 1. Kiểm tra licensePlate có null hoặc trống hay không. Nếu có, ném Exception.
        // 2. Trim() và toUpperCase() biển số xe để chuẩn hóa.
        // 3. Sử dụng regex đã cho ở trên, so khớp bằng hàm: plateFormatted.matches(regex)
        // 4. Nếu không khớp regex, ném Exception thông báo định dạng không đúng.
        // 5. Nếu khớp, tạo đối tượng Car (truyền các tham số: customerId, plateFormatted, brand, model, color, date hiện tại).
        // 6. Gọi carDAO.addCar(car) và kiểm tra kết quả trả về. Nếu kết quả <= 0, ném Exception báo đăng ký thất bại.
        if (licensePlate == null || licensePlate.trim().isEmpty()) {
            throw new Exception("Biển số xe không được để trống!");
        }
        
        String plateFormatted = licensePlate.trim().toUpperCase();
        
        String regex = "^\\d{2}[A-Z]\\d-\\d{4,5}$"
                     + "|^\\d{2}[A-Z]\\d-\\d{3}\\.\\d{2}$"
                     + "|^\\d{2}[A-Z]-\\d{4,5}$"
                     + "|^\\d{2}[A-Z]-\\d{3}\\.\\d{2}$";
                     
        if (!plateFormatted.matches(regex)) {
            throw new Exception("Biển số xe không đúng định dạng Việt Nam! Ví dụ hợp lệ: 30A1-1234 hoặc 51F1-999.99");
        }
        
        Car car = new Car(customerId, plateFormatted, brand, model, color, new java.sql.Date(System.currentTimeMillis()));
        int result = carDAO.addCar(car);
        if (result == 0) {
            throw new Exception("Đăng ký xe thất bại. Biển số có thể đã được đăng ký trước đó!");
        }
    }

    /**
     * BÀI TẬP 2: Cập nhật thông tin xe của khách hàng (Edit Car - Nghiệp vụ).
     * Yêu cầu nghiệp vụ:
     * 1. Kiểm tra biển số xe không được để trống.
     * 2. Chuẩn hóa biển số xe (cắt khoảng trắng dư và chuyển chữ hoa).
     * 3. Kiểm tra Regex biển số xe Việt Nam.
     * 4. Khởi tạo đối tượng Car mới (truyền: plateId, customerId, plateFormatted, brand, model, color, date hiện tại).
     * 5. Gọi carDAO.updateCar(car). Nếu kết quả trả về <= 0, ném Exception báo thất bại.
     * 6. Sử dụng try-catch để bắt lỗi từ Database: Nếu câu thông báo lỗi (e.getMessage()) chứa các từ khóa 
     *    như "UQ_", "UNIQUE", "duplicate" -> ném ngoại lệ mới báo: "Biển số ... đã được đăng ký cho xe khác!"
     */
    public void updateCar(int customerId, int plateId, String licensePlate, String brand, String model, String color) throws Exception {
        // TODO: THỰC HÀNH VIẾT CODE CỦA BẠN Ở ĐÂY
        // Gợi ý các bước:
        // 1. Kiểm tra đầu vào licensePlate
        // 2. Chuyển đổi toUpperCase() và kiểm tra matches(regex)
        // 3. Viết khối try-catch để gọi carDAO.updateCar(...) và ném thông điệp lỗi phù hợp
    }

    /**
     * BÀI TẬP 3: Xóa xe của khách hàng (Delete Car - Nghiệp vụ).
     * Yêu cầu nghiệp vụ:
     * 1. Gọi carDAO.deleteCar(plateId, customerId).
     * 2. Nếu kết quả trả về <= 0, ném Exception thông báo: "Xóa xe thất bại. Xe không tồn tại hoặc không thuộc quyền sở hữu!"
     * 3. Sử dụng try-catch để bắt lỗi ràng buộc cơ sở dữ liệu: Nếu e.getMessage() chứa các từ khóa khóa ngoại 
     *    như "REFERENCE", "constraint", "foreign key", "FK_" -> ném ngoại lệ mới báo: 
     *    "Không thể xóa xe này vì đang có lịch đặt rửa xe liên kết với xe. Vui lòng hủy lịch đặt trước khi xóa!"
     */
    public void deleteCar(int customerId, int plateId) throws Exception {
        // TODO: THỰC HÀNH VIẾT CODE CỦA BẠN Ở ĐÂY
        // Gợi ý:
        // 1. Dùng try-catch bao bọc lệnh gọi carDAO.deleteCar(plateId, customerId)
        // 2. Bắt lỗi Exception e, kiểm tra e.getMessage() để quăng ngoại lệ thân thiện theo yêu cầu
    }
}

