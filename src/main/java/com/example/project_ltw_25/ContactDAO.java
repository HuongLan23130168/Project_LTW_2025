package com.example.demoweb1.dao;

import com.example.demoweb1.util.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "ContactDAO ", value = "/ContactDAO ")
public class ContactDAO extends HttpServlet {

        public static void save(String name, String email, String message) {
            try {
                Connection conn = DBConnection.getConnection();

                String sql = "INSERT INTO contact(name, email, message) VALUES (?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, message);

                ps.executeUpdate();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }