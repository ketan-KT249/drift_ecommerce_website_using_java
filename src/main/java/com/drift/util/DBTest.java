package com.drift.util;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        Connection connection = DBConnection.getConnection();

        if (connection != null) {
            System.out.println("DRIFT DATABASE CONNECTED!");
        } else {
            System.out.println("DATABASE CONNECTION FAILED!");
        }
    }
}