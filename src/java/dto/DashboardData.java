package dto;

import java.io.Serializable;
import java.util.List;

/**
 * DashboardData - DTO chứa toàn bộ dữ liệu đã được tính toán sẵn cho trang Dashboard
 */
public class DashboardData implements Serializable {
    private String tierId;
    private String tierDisplayName;
    private double multiplier;
    private int bookingDays;
    private String nextTier;
    private String nextTierDisplay;
    private int currentWashes;
    private double currentSpent;
    private int pointsBalance;
    private double maxProgress;
    private String progressText;
    private String pointsValueVnd;
    private String spentFormatted;
    private List<Car> carList;

    public DashboardData() {
    }

    public DashboardData(String tierId, String tierDisplayName, double multiplier, int bookingDays, 
                         String nextTier, String nextTierDisplay, int currentWashes, double currentSpent, 
                         int pointsBalance, double maxProgress, String progressText, String pointsValueVnd, 
                         String spentFormatted, List<Car> carList) {
        this.tierId = tierId;
        this.tierDisplayName = tierDisplayName;
        this.multiplier = multiplier;
        this.bookingDays = bookingDays;
        this.nextTier = nextTier;
        this.nextTierDisplay = nextTierDisplay;
        this.currentWashes = currentWashes;
        this.currentSpent = currentSpent;
        this.pointsBalance = pointsBalance;
        this.maxProgress = maxProgress;
        this.progressText = progressText;
        this.pointsValueVnd = pointsValueVnd;
        this.spentFormatted = spentFormatted;
        this.carList = carList;
    }

    public String getTierId() {
        return tierId;
    }

    public void setTierId(String tierId) {
        this.tierId = tierId;
    }

    public String getTierDisplayName() {
        return tierDisplayName;
    }

    public void setTierDisplayName(String tierDisplayName) {
        this.tierDisplayName = tierDisplayName;
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

    public String getNextTier() {
        return nextTier;
    }

    public void setNextTier(String nextTier) {
        this.nextTier = nextTier;
    }

    public String getNextTierDisplay() {
        return nextTierDisplay;
    }

    public void setNextTierDisplay(String nextTierDisplay) {
        this.nextTierDisplay = nextTierDisplay;
    }

    public int getCurrentWashes() {
        return currentWashes;
    }

    public void setCurrentWashes(int currentWashes) {
        this.currentWashes = currentWashes;
    }

    public double getCurrentSpent() {
        return currentSpent;
    }

    public void setCurrentSpent(double currentSpent) {
        this.currentSpent = currentSpent;
    }

    public int getPointsBalance() {
        return pointsBalance;
    }

    public void setPointsBalance(int pointsBalance) {
        this.pointsBalance = pointsBalance;
    }

    public double getMaxProgress() {
        return maxProgress;
    }

    public void setMaxProgress(double maxProgress) {
        this.maxProgress = maxProgress;
    }

    public String getProgressText() {
        return progressText;
    }

    public void setProgressText(String progressText) {
        this.progressText = progressText;
    }

    public String getPointsValueVnd() {
        return pointsValueVnd;
    }

    public void setPointsValueVnd(String pointsValueVnd) {
        this.pointsValueVnd = pointsValueVnd;
    }

    public String getSpentFormatted() {
        return spentFormatted;
    }

    public void setSpentFormatted(String spentFormatted) {
        this.spentFormatted = spentFormatted;
    }

    public List<Car> getCarList() {
        return carList;
    }

    public void setCarList(List<Car> carList) {
        this.carList = carList;
    }
}
