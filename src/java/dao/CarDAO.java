package dao;

import dbutils.DBUtils;
import dto.Car;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author user
 */
public class CarDAO {
    
    // Lấy tất cả các xe của một khách hàng dựa vào UserId
    public List<Car> getAllCars(int custid){
      List<Car> result = new ArrayList<>();
      String sql = "SELECT PlateId, UserId, PlateNumber, VehicleModel, CreatedAt \n"
                 + "FROM LicensePlates \n"
                 + "WHERE UserId = ?";
      try (Connection cn = DBUtils.getConnection();
           PreparedStatement st = cn.prepareStatement(sql)) {
          st.setInt(1, custid);
          try (ResultSet table = st.executeQuery()) {
              while (table.next()) {
                 int plateId = table.getInt("PlateId");
                 String plateNum = table.getString("PlateNumber");
                 String vehicleModel = table.getString("VehicleModel");
                 Date createdAt = table.getDate("CreatedAt");
                 
                 // Phân tách trường VehicleModel thành Brand, Model, Color trong DTO
                 String brandVal = vehicleModel;
                 String modelVal = "";
                 String colorVal = "";
                 
                 if (vehicleModel != null) {
                     if (vehicleModel.contains(" - ")) {
                         String[] parts = vehicleModel.split(" - ");
                         brandVal = parts[0];
                         if (parts.length > 1) {
                             String rest = parts[1];
                             if (rest.contains(" (") && rest.contains(")")) {
                                 modelVal = rest.substring(0, rest.indexOf(" ("));
                                 colorVal = rest.substring(rest.indexOf(" (") + 2, rest.indexOf(")"));
                             } else {
                                 modelVal = rest;
                             }
                         }
                     }
                 }
                 
                 Car c = new Car(plateId, custid, plateNum, brandVal, modelVal, colorVal, createdAt);
                 result.add(c);
              }
          }
      } catch (Exception e) {
          e.printStackTrace();
      }
      return result;
    }

    // Thêm mới xe vào bảng LicensePlates
    public int addCar(Car car) {
        int result = 0;
        String sql = "INSERT INTO LicensePlates (UserId, PlateNumber, VehicleModel, CreatedAt) VALUES (?, ?, ?, GETDATE())";
        try (Connection cn = DBUtils.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setInt(1, car.getCustid());
            st.setString(2, car.getLicensePlate());
            
            // Gộp Brand, Model và Color vào làm một chuỗi VehicleModel để lưu trong DB
            String vehicleModel = car.getBrand() + " - " + car.getModel() + " (" + car.getColor() + ")";
            st.setString(3, vehicleModel);
            
            result = st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
