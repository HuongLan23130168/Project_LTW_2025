package com.example.project_ltw_25.model;

import java.io.Serializable;

public class Product implements Serializable {
    private int id;
    private String productCode;
    private String productName;
    private String description;

    private String categoryName;
    private String productTypeName;

    private double price;
    private String imageUrl;

    public Product() {
    }

    public Product(int id, String productCode, String productName, String description, String categoryName, String productTypeName, double price, String imageUrl) {
        this.id = id;
        this.productCode = productCode;
        this.productName = productName;
        this.description = description;
        this.categoryName = categoryName;
        this.productTypeName = productTypeName;
        this.price = price;
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getProductTypeName() {
        return productTypeName;
    }

    public void setProductTypeName(String productTypeName) {
        this.productTypeName = productTypeName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
