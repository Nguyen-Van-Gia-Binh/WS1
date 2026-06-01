package dao;

import dbutils.DBUtils;
import dto.Customer;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
                   Date createDate = rs.getDate("CreatedAt");
                   String phoneVal = rs.getString("PhoneNumber");
                   int points = rs.getInt("PointsBalance");
                   double spent = rs.getDouble("TotalSpent");
                   int washes = rs.getInt("TotalWashes");
                   // Ánh xạ Email = "" và Status = true vì bảng Users mới không chứa 2 cột này
                   result = new Customer(cusid, name, "", password, createDate, true, phoneVal, currentTierId, points, spent, washes);
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
                   Date createDate = rs.getDate("CreatedAt");
                   String phoneVal = rs.getString("PhoneNumber");
                   int points = rs.getInt("PointsBalance");
                   double spent = rs.getDouble("TotalSpent");
                   int washes = rs.getInt("TotalWashes");
                   // Ánh xạ Email = "" và Status = true
                   result = new Customer(cusid, name, "", passwordVal, createDate, true, phoneVal, currentTierId, points, spent, washes);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
