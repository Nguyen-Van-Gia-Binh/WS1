package dao;

import dbutils.DBUtils;
import dto.Tier;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * TierDAO - Lớp truy xuất cơ sở dữ liệu cho bảng Tiers
 */
public class TierDAO {
    
    // Lấy toàn bộ danh sách hạng thành viên sắp xếp theo số lượt rửa tối thiểu tăng dần
    public List<Tier> getAllTiers() {
        List<Tier> list = new ArrayList<>();
        String sql = "SELECT TierId, TierName, MinWashes, MinSpent, Multiplier, BookingDays FROM Tiers ORDER BY MinWashes ASC";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stm = conn.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                list.add(new Tier(
                    rs.getString("TierId"),
                    rs.getString("TierName"),
                    rs.getInt("MinWashes"),
                    rs.getDouble("MinSpent"),
                    rs.getDouble("Multiplier"),
                    rs.getInt("BookingDays")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
