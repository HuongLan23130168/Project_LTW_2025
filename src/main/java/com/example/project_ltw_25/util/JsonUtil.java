package com.example.project_ltw_25.util;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class JsonUtil {
    public static String get(String json, String key) {
        JsonObject obj = JsonParser.parseString(json).getAsJsonObject();
        return obj.get(key).getAsString();
    }
}
