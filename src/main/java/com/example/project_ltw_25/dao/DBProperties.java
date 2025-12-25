package com.example.project_ltw_25.dao;

import java.io.InputStream;
import java.util.Properties;

public class DBProperties {
    public static String host;
    public static String port;
    public static String username;
    public static String pass;
    public static String dbname;

    static {
        try {
            Properties props = new Properties();
            InputStream is = DBProperties.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties");

            props.load(is);

            host = props.getProperty("db.host");
            port = props.getProperty("db.port");
            username = props.getProperty("db.username");
            pass = props.getProperty("db.pass");
            dbname = props.getProperty("db.name");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
