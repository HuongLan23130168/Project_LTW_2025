package com.example.demoweb1.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import com.example.demoweb1.dao.ContactDAO;
//import jdk.internal.org.jline.reader.History;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            request.setCharacterEncoding("UTF-8");

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String message = request.getParameter("message");

            ContactDAO.save(name, email, message);

            // quay lại contact.jsp + báo thành công
            response.sendRedirect(
                    request.getContextPath() + "/frontend/contact.jsp?success=true"
            );
        }
    }
