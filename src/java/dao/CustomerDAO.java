package dao;

import dbutils.DBUtils;
import dto.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

/**
 * CustomerDAO - Lớp truy xuất dữ liệu cho bảng Users (Khách hàng)
 */
public class CustomerDAO {
    
    // Thêm khách hàng mới vào bảng Users
    public int createCustomer(Customer c){
        int result = 0;
        String sql = "INSERT INTO Users (PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes, CreatedAt) \n"
                   + "VALUES(?,?,?,'CUSTOMER','MEMBER',0,0,0,GETDATE())";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, c.getPhoneNumber());
            stm.setString(2, c.getPassword());
            stm.setString(3, c.getFullname());
            result = stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // Lấy khách hàng theo Số điện thoại
    public Customer getCustomerByPhone(String phone){
        Customer result = null;
        String sql = "SELECT UserId, PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes, CreatedAt \n"
                   + "FROM Users \n"
                   + "WHERE PhoneNumber = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, phone);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                   int cusid = rs.getInt("UserId");
                   String name = rs.getString("FullName");
                   String password = rs.getString("Password");
                   String currentTierId = rs.getString("CurrentTierId");
                   Timestamp createDate = rs.getTimestamp("CreatedAt");
                   String phoneVal = rs.getString("PhoneNumber");
                   String role = rs.getString("Role");
                   int points = rs.getInt("PointsBalance");
                   double spent = rs.getDouble("TotalSpent");
                   int washes = rs.getInt("TotalWashes");
                   result = new Customer(cusid, name, password, createDate, phoneVal, role, currentTierId, points, spent, washes);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // Xác thực người dùng bằng Số điện thoại và Mật khẩu
    public Customer getCustomerByPhoneAndPassword(String phone, String password){
        Customer result = null;
        String sql = "SELECT UserId, PhoneNumber, Password, FullName, Role, CurrentTierId, PointsBalance, TotalSpent, TotalWashes, CreatedAt \n"
                   + "FROM Users \n"
                   + "WHERE PhoneNumber = ? AND Password = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, phone);
            stm.setString(2, password);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                   int cusid = rs.getInt("UserId");
                   String name = rs.getString("FullName");
                   String passwordVal = rs.getString("Password");
                   String currentTierId = rs.getString("CurrentTierId");
                   Timestamp createDate = rs.getTimestamp("CreatedAt");
                   String phoneVal = rs.getString("PhoneNumber");
                   String role = rs.getString("Role");
                   int points = rs.getInt("PointsBalance");
                   double spent = rs.getDouble("TotalSpent");
                   int washes = rs.getInt("TotalWashes");
                   result = new Customer(cusid, name, passwordVal, createDate, phoneVal, role, currentTierId, points, spent, washes);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
