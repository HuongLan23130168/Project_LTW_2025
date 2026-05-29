package com.example.project_ltw_25.services;

import com.example.project_ltw_25.dao.ProductDao;
import com.example.project_ltw_25.model.Product;

import java.util.List;

public class ProductService {

    private final ProductDao dao = new ProductDao();

    public List<Product> getListProduct() {
        return dao.getListProduct();
    }

    public Product getProduct(int id) {
        return dao.getProduct(id);
    }
}
