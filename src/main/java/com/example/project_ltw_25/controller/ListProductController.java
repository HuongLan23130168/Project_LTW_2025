package com.example.project_ltw_25.controller;

import com.example.project_ltw_25.dao.ProductDao;
import com.example.project_ltw_25.model.Product;
import com.example.project_ltw_25.services.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListProductController", value = "/list-product")
public class ListProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String priceRange = request.getParameter("priceRange");
        String[] categories = request.getParameterValues("category");
        String[] colors = request.getParameterValues("color");
        String sort = request.getParameter("sort");

        ProductDao dao = new ProductDao();
        List<Product> products = dao.filterProducts(
                priceRange, categories, colors, sort
        );


        request.setAttribute("products", products);
        request.getRequestDispatcher("/frontend/living.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}