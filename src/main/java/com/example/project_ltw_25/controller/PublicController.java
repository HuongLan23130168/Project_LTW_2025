package com.example.project_ltw_25.controller;

import com.example.project_ltw_25.model.Product;
import com.example.project_ltw_25.services.ProductService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "PublicController", value = "/products")
public class PublicController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idRaw = request.getParameter("id");
        if (idRaw == null) {
            response.sendRedirect(request.getContextPath() + "/list-product");
            return;
        }

        int id = Integer.parseInt(idRaw);

        ProductService service = new ProductService();
        Product p = service.getProduct(id);

        request.setAttribute("p", p);
        request.getRequestDispatcher("/frontend/detail.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}