package dto;

import java.sql.Date;

/**
 * Car - Biển số xe liên kết DTO
 */
public class Car {
  private int id;
  private  int custid;
  private String licensePlate;
  private String brand;
  private String model;
  private String color;
  private Date createdDate;

    public Car() {
    }

    public Car(int id, int custid, String licensePlate, String brand, String model, String color, Date createdDate) {
        this.id = id;
        this.custid = custid;
        this.licensePlate = licensePlate;
        this.brand = brand;
        this.model = model;
        this.color = color;
        this.createdDate = createdDate;
    }

    public Car(int custid, String licensePlate, String brand, String model, String color, Date createdDate) {
        this.custid = custid;
        this.licensePlate = licensePlate;
        this.brand = brand;
        this.model = model;
        this.color = color;
        this.createdDate = createdDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustid() {
        return custid;
    }

    public void setCustid(int custid) {
        this.custid = custid;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
    
  
}
