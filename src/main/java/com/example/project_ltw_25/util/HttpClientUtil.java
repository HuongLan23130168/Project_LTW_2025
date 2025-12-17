package com.example.project_ltw_25.util;

import org.apache.hc.client5.http.fluent.Request;
import org.apache.hc.core5.http.ContentType;
import java.io.IOException;

public class HttpClientUtil {

    public static String get(String url) throws IOException {
        return Request.get(url)
                .execute()
                .returnContent()
                .asString();
    }

    public static String post(String url, String body) throws IOException {
        return Request.post(url)
                .addHeader("Content-Type", "application/x-www-form-urlencoded")
                .bodyString(body, ContentType.APPLICATION_FORM_URLENCODED)
                .execute()
                .returnContent()
                .asString();
    }
}
