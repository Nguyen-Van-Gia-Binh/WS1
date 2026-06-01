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
}
