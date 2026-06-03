package practice;

import dbutils.DBUtils;
import dto.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

/**
 * FILE THỰC HÀNH ÔN TẬP JDBC & DAO
 *
 * Nhiệm vụ của bạn: Điền code vào các phương thức dưới đây dựa trên gợi ý. Sau
 * khi viết xong, hãy gửi cho AI kiểm tra và giải thích.
 */
public class PracticeDAO {

    /**
     * BÀI TẬP 1: Thêm mới một khách hàng vào cơ sở dữ liệu. Bảng: Users Các cột
     * cần chèn: PhoneNumber, Password, FullName, Role, CurrentTierId,
     * PointsBalance, TotalSpent, TotalWashes, CreatedAt SQL mẫu: INSERT INTO
     * Users (PhoneNumber, Password, FullName, Role, CurrentTierId,
     * PointsBalance, TotalSpent, TotalWashes, CreatedAt) VALUES(?, ?, ?,
     * 'CUSTOMER', 'MEMBER', 0, 0, 0, GETDATE())
     */
    public int createCustomer(Customer c) {
        int result = 0;
        String sql = "INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes, CreatedAt) "
                + "VALUES(?, ?, ?, 'CUSTOMER', 'MEMBER', 0, 0, 0, GETDATE())";

        // TODO: VIẾT CODE Ở ĐÂY
        // Gợi ý từng bước cho vấn đáp:
        // 1. Dùng cấu trúc try-with-resources để tự động đóng Connection và PreparedStatement
        // 2. Lấy connection từ DBUtils.getConnection()
        // 3. Chuẩn bị câu lệnh SQL bằng conn.prepareStatement(sql)
        // 4. Set các tham số (?, ?, ?) truyền vào: tham số 1 là Số điện thoại, 2 là Mật khẩu, 3 là Họ tên.
        // 5. Thực thi câu lệnh ghi dữ liệu bằng executeUpdate() và gán vào biến result.
        // 6. Bắt ngoại lệ (catch Exception) và in ra lỗi.
        try ( Connection con = DBUtils.getConnection();  PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, c.getPhoneNumber());
            st.setString(2, c.getPassword());
            st.setString(3, c.getFullname());
            result = st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    /**
     * BÀI TẬP 2: Xác thực khách hàng bằng số điện thoại và mật khẩu (Đăng nhập)
     * SQL mẫu: SELECT UserId, PhoneNumber, Password, FullName, Role,
     * CurrentTierId, PointsBalance, TotalSpent, TotalWashes, CreatedAt FROM
     * Users WHERE PhoneNumber = ? AND Password = ?
     */
    public Customer getCustomerByPhoneAndPassword(String phone, String password) {
        if (phone == null || password == null) {
            return null;
        }
        String sql = "SELECT UserId, PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes, CreatedAt "
                 + "FROM Users "
                 + "WHERE PhoneNumber = ? AND Password = ?";

        // Sửa lỗi: Đặt ResultSet vào try-with-resources để tự động đóng tài nguyên.
        // Sửa lỗi: Tên cột truy vấn trong Database là 'UserId', 'FullName', ... chứ không phải 'cusId', 'fullname'.
        try (Connection con = DBUtils.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, phone);
            st.setString(2, password);
            
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int custId = rs.getInt("UserId"); // Đúng tên cột UserId
                    String fullname = rs.getString("FullName"); // Đúng tên cột FullName
                    String passwordVal = rs.getString("Password");
                    Timestamp createdAt = rs.getTimestamp("CreatedAt");
                    String phoneVal = rs.getString("PhoneNumber");
                    String role = rs.getString("Role");
                    String currentTierId = rs.getString("CurrentTierId");
                    int pointsBalance = rs.getInt("PointsBalance");
                    double totalSpent = rs.getDouble("TotalSpent");
                    int totalWashes = rs.getInt("TotalWashes");
                    
                    return new Customer(custId, fullname, passwordVal, createdAt, phoneVal, role, currentTierId, pointsBalance, totalSpent, totalWashes);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * BÀI TẬP 3: Cập nhật thông tin xe của khách hàng.
     * Nhiệm vụ: Viết lệnh SQL UPDATE để sửa đổi biển số xe, hãng xe, dòng xe, màu xe.
     * Điều kiện WHERE: Phải khớp cả PlateId (ID xe) và UserId (ID khách hàng) để bảo mật.
     * SQL mẫu: UPDATE LicensePlates SET PlateNumber = ?, Brand = ?, Model = ?, Color = ? WHERE PlateId = ? AND UserId = ?
     */
    public int updateCar(dto.Car car) throws Exception {
        int result = 0;
        String sql = "UPDATE LicensePlates SET PlateNumber = ?, Brand = ?, Model = ?, Color = ? WHERE PlateId = ? AND UserId = ?";
        
        // TODO: THỰC HÀNH VIẾT CODE JDBC Ở ĐÂY:
        // 1. Dùng try-with-resources để mở Connection từ DBUtils và PreparedStatement
        // 2. Set các tham số (?, ?, ?, ?, ?, ?) tương ứng với các giá trị:
        //    - st.setString(1, car.getLicensePlate());
        //    - ...
        //    - st.setInt(5, car.getId());
        //    - st.setInt(6, car.getCustid());
        // 3. Chạy lệnh st.executeUpdate() và lưu kết quả vào biến result
        
        return result;
    }

    /**
     * BÀI TẬP 4: Xóa xe của khách hàng khỏi hệ thống.
     * Nhiệm vụ: Viết lệnh SQL DELETE để xóa dòng xe tương ứng.
     * Điều kiện WHERE: Khớp cả PlateId và UserId.
     * SQL mẫu: DELETE FROM LicensePlates WHERE PlateId = ? AND UserId = ?
     */
    public int deleteCar(int plateId, int userId) throws Exception {
        int result = 0;
        String sql = "DELETE FROM LicensePlates WHERE PlateId = ? AND UserId = ?";
        
        // TODO: THỰC HÀNH VIẾT CODE JDBC Ở ĐÂY:
        // 1. Dùng try-with-resources kết nối DB
        // 2. Set tham số: tham số 1 là plateId, tham số 2 là userId
        // 3. Thực thi st.executeUpdate() và lưu vào result
        
        return result;
    }
}

