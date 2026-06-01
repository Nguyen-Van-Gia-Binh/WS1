package dto;

import java.io.Serializable;

/**
 * Tier - Đối tượng hạng thành viên liên kết cơ sở dữ liệu
 */
public class Tier implements Serializable {
    private String tierId;
    private String tierName;
    private int minWashes;
    private double minSpent;
    private double multiplier;
    private int bookingDays;

    public Tier() {
    }

    public Tier(String tierId, String tierName, int minWashes, double minSpent, double multiplier, int bookingDays) {
        this.tierId = tierId;
        this.tierName = tierName;
        this.minWashes = minWashes;
        this.minSpent = minSpent;
        this.multiplier = multiplier;
        this.bookingDays = bookingDays;
    }

    public String getTierId() {
        return tierId;
    }

    public void setTierId(String tierId) {
        this.tierId = tierId;
    }

    public String getTierName() {
        return tierName;
    }

    public void setTierName(String tierName) {
        this.tierName = tierName;
    }

    public int getMinWashes() {
        return minWashes;
    }

    public void setMinWashes(int minWashes) {
        this.minWashes = minWashes;
    }

    public double getMinSpent() {
        return minSpent;
    }

    public void setMinSpent(double minSpent) {
        this.minSpent = minSpent;
    }

    public double getMultiplier() {
        return multiplier;
    }

    public void setMultiplier(double multiplier) {
        this.multiplier = multiplier;
    }

    public int getBookingDays() {
        return bookingDays;
    }

    public void setBookingDays(int bookingDays) {
        this.bookingDays = bookingDays;
    }
}
