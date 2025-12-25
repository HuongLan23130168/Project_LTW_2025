package com.example.project_ltw_25.dao;

import com.example.project_ltw_25.model.Product;

import java.util.*;

public class ProductDao {

    private static final Map<Integer, Product> productMap = new HashMap<>();
    private static boolean loaded = false;

    private void loadFromDB() {
        if (loaded) {
            System.out.println(">>> MAP already loaded");
            return;
        }

        System.out.println(">>> Loading products from DB");

        List<Product> list = DBDAO.get().withHandle(h ->
                h.createQuery("""
                                SELECT
                                    p.id,
                                    p.product_name        AS productName,
                                
                                    c.category_name       AS categoryName,
                                    t.type_name           AS productTypeName,
                                
                                    MIN(v.price)          AS price,
                                    MIN(v.image_url)      AS imageUrl
                                
                                FROM products p
                                JOIN categories c ON p.category_id = c.id
                                LEFT JOIN product_types t ON p.product_type_id = t.id
                                LEFT JOIN product_variants v ON v.product_id = p.id
                                
                                GROUP BY
                                    p.id, p.product_name,
                                    c.category_name, t.type_name;
                                    """)
                        .mapToBean(Product.class)
                        .list()
        );

        System.out.println(">>> DB RETURNED: " + list.size());

        for (Product p : list) {
            productMap.put(p.getId(), p);
        }

        loaded = true;
    }

    public List<Product> getListProduct() {
        loadFromDB();
        return new ArrayList<>(productMap.values());
    }

    public Product getProduct(int id) {
        loadFromDB();
        return productMap.get(id);
    }

    public List<Product> filterProducts(String priceRange, String[] categories, String[] colors, String sort) {
        StringBuilder sql = new StringBuilder("""
        SELECT
            p.id,
            p.product_name AS productName,
            c.category_name AS categoryName,
            t.type_name AS productTypeName,
            MIN(v.price) AS price,
            MIN(v.image_url) AS imageUrl
        FROM products p
        JOIN categories c ON p.category_id = c.id
        LEFT JOIN product_types t ON p.product_type_id = t.id
        LEFT JOIN product_variants v ON v.product_id = p.id
        WHERE 1=1
    """);

        if (categories != null && categories.length > 0) {
            sql.append(" AND c.category_code IN (<categories>)");
        }

        if (colors != null && colors.length > 0) {
            sql.append(" AND v.color IN (<colors>)");
        }

        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "1" -> sql.append(" AND v.price < 500000");
                case "2" -> sql.append(" AND v.price BETWEEN 500000 AND 1000000");
                case "3" -> sql.append(" AND v.price BETWEEN 1000000 AND 3000000");
                case "4" -> sql.append(" AND v.price > 3000000");
            }
        }

        sql.append("""
        GROUP BY
            p.id, p.product_name,
            c.category_name, t.type_name
    """);

        if ("price-asc".equals(sort)) {
            sql.append(" ORDER BY price ASC");
        } else if ("price-desc".equals(sort)) {
            sql.append(" ORDER BY price DESC");
        }

        return DBDAO.get().withHandle(h -> {
            var query = h.createQuery(sql.toString());

            if (categories != null)
                query.bindList("categories", Arrays.asList(categories));

            if (colors != null)
                query.bindList("colors", Arrays.asList(colors));

            return query.mapToBean(Product.class).list();
        });
    }
}
