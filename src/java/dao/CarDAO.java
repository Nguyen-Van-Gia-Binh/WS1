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
      String sql = "SELECT PlateId, UserId, PlateNumber, Brand, Model, Color, CreatedAt \n"
                 + "FROM LicensePlates \n"
                 + "WHERE UserId = ?";
      try (Connection cn = DBUtils.getConnection();
           PreparedStatement st = cn.prepareStatement(sql)) {
          st.setInt(1, custid);
          try (ResultSet table = st.executeQuery()) {
              while (table.next()) {
                 int plateId = table.getInt("PlateId");
                 String plateNum = table.getString("PlateNumber");
                 String brandVal = table.getString("Brand");
                 String modelVal = table.getString("Model");
                 String colorVal = table.getString("Color");
                 Date createdAt = table.getDate("CreatedAt");
                 
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
        String sql = "INSERT INTO LicensePlates (UserId, PlateNumber, Brand, Model, Color, CreatedAt) VALUES (?, ?, ?, ?, ?, GETDATE())";
        try (Connection cn = DBUtils.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            
            st.setInt(1, car.getCustid());
            st.setString(2, car.getLicensePlate());
            st.setString(3, car.getBrand());
            st.setString(4, car.getModel());
            st.setString(5, car.getColor());
            
            result = st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // Cập nhật thông tin xe
    public int updateCar(Car car) throws Exception {
        int result = 0;
        String sql = "UPDATE LicensePlates SET PlateNumber = ?, Brand = ?, Model = ?, Color = ? WHERE PlateId = ? AND UserId = ?";
        try (Connection cn = DBUtils.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            st.setString(1, car.getLicensePlate());
            st.setString(2, car.getBrand());
            st.setString(3, car.getModel());
            st.setString(4, car.getColor());
            st.setInt(5, car.getId());
            st.setInt(6, car.getCustid());
            
            result = st.executeUpdate();
        }
        return result;
    }

    // Xóa xe dựa trên PlateId và UserId
    public int deleteCar(int plateId, int userId) throws Exception {
        int result = 0;
        String sql = "DELETE FROM LicensePlates WHERE PlateId = ? AND UserId = ?";
        try (Connection cn = DBUtils.getConnection();
             PreparedStatement st = cn.prepareStatement(sql)) {
            st.setInt(1, plateId);
            st.setInt(2, userId);
            
            result = st.executeUpdate();
        }
        return result;
    }
}

