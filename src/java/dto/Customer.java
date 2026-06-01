package dto;

import java.io.Serializable;
import java.sql.Date;

/**
 * Customer - Khách hàng DTO
 */
public class Customer implements Serializable {
    private int cusId;
    private String fullname;
    private String email;
    private String password;
    private Date createdAt;
    private boolean status;
    private String phoneNumber;
    private String currentTierId; // MEMBER, SILVER, GOLD, PLATINUM
    private int pointsBalance;
    private double totalSpent;
    private int totalWashes;

    public Customer() {
    }

    public Customer(int cusId, String fullname, String email, String password, Date createdAt, boolean status) {
        this.cusId = cusId;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
        this.status = status;
        this.currentTierId = "MEMBER"; // Default to MEMBER tier
    }

    public Customer(int cusId, String fullname, String email, String password, Date createdAt, boolean status, String phoneNumber, String currentTierId, int pointsBalance, double totalSpent, int totalWashes) {
        this.cusId = cusId;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.createdAt = createdAt;
        this.status = status;
        this.phoneNumber = phoneNumber;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
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
