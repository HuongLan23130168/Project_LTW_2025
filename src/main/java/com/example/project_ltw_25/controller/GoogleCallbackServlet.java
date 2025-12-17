package com.example.project_ltw_25.controller;

import com.example.project_ltw_25.util.HttpClientUtil;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "GoogleCallbackServlet", value = "/google-callback")
public class GoogleCallbackServlet extends HttpServlet {
    private static final String CLIENT_ID =
            System.getenv("GOOGLE_CLIENT_ID");
    private static final String CLIENT_SECRET =
            System.getenv("GOOGLE_CLIENT_SECRET");
    private static final String REDIRECT_URI =
            System.getenv("GOOGLE_REDIRECT_URI");


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("===== GOOGLE CALLBACK DEBUG =====");
        System.out.println("code = " + request.getParameter("code"));
        System.out.println("CLIENT_ID = " + CLIENT_ID);
        System.out.println("CLIENT_SECRET = " + CLIENT_SECRET);
        System.out.println("REDIRECT_URI = " + REDIRECT_URI);

        String code = request.getParameter("code");

        if (code == null) {
            response.sendRedirect(request.getContextPath() + "/frontend/login.jsp");
            return;
        }

        // Đổi code → access token
        String tokenUrl = "https://oauth2.googleapis.com/token";

        String body =
                "code=" + URLEncoder.encode(code, StandardCharsets.UTF_8) +
                        "&client_id=" + CLIENT_ID +
                        "&client_secret=" + CLIENT_SECRET +
                        "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8) +
                        "&grant_type=authorization_code";

        System.out.println("===== GOOGLE OAUTH DEBUG =====");
        System.out.println("CLIENT_ID = " + CLIENT_ID);
        System.out.println("CLIENT_SECRET = " + CLIENT_SECRET);
        System.out.println("REDIRECT_URI = " + REDIRECT_URI);
        System.out.println("CODE = " + code);
        System.out.println("BODY = " + body);

        String tokenResponse = HttpClientUtil.post(tokenUrl, body);

        // Parse access_token
        JsonObject tokenJson = JsonParser.parseString(tokenResponse).getAsJsonObject();

        String accessToken = tokenJson.get("access_token").getAsString();

        // Lấy info user
        String userInfoUrl = "https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + accessToken;

        String userInfoResponse = HttpClientUtil.get(userInfoUrl);

        JsonObject userJson = JsonParser.parseString(userInfoResponse).getAsJsonObject();

        String email = userJson.get("email").getAsString();
        String name = userJson.get("name").getAsString();

        // Tạo session
        HttpSession session = request.getSession();
        session.setAttribute("userEmail", email);
        session.setAttribute("userName", name);

        // Redirect sang home.jsp
        response.sendRedirect(request.getContextPath() + "/frontend/home.jsp");
    }
}