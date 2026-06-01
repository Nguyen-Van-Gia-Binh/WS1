package dto;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Customer - Khách hàng DTO
 */
public class Customer implements Serializable {
    private int cusId;
    private String fullname;
    private String password;
    private Timestamp createdAt;
    private String phoneNumber;
    private String role;
    private String currentTierId; // MEMBER, SILVER, GOLD, PLATINUM
    private int pointsBalance;
    private double totalSpent;
    private int totalWashes;

    public Customer() {
    }

    public Customer(int cusId, String fullname, String password, Timestamp createdAt, String phoneNumber, String role, String currentTierId, int pointsBalance, double totalSpent, int totalWashes) {
        this.cusId = cusId;
        this.fullname = fullname;
        this.password = password;
        this.createdAt = createdAt;
        this.phoneNumber = phoneNumber;
        this.role = role;
        this.currentTierId = currentTierId;
        this.pointsBalance = pointsBalance;
        this.totalSpent = totalSpent;
        this.totalWashes = totalWashes;
    }

    public int getCusId() {
        return cusId;
    }

    public void setCusId(int cusId) {
        this.cusId = cusId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getCurrentTierId() {
        return currentTierId;
    }

    public void setCurrentTierId(String currentTierId) {
        this.currentTierId = currentTierId;
    }

    public int getPointsBalance() {
        return pointsBalance;
    }

    public void setPointsBalance(int pointsBalance) {
        this.pointsBalance = pointsBalance;
    }

    public double getTotalSpent() {
        return totalSpent;
    }

    public void setTotalSpent(double totalSpent) {
        this.totalSpent = totalSpent;
    }

    public int getTotalWashes() {
        return totalWashes;
    }

    public void setTotalWashes(int totalWashes) {
        this.totalWashes = totalWashes;
    }
}
