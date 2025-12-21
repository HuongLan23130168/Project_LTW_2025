package com.example.demoweb1.util;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet(name = "DBConnection", value = "/DBConnection")
public class DBConnection extends HttpServlet {


    private static final String URL = "jdbc:mysql://localhost:3306/ten_database";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}