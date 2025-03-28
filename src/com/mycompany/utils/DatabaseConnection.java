package com.mycompany.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/your_database";
    private static final String USER = "your_username";
    private static final String PASSWORD = "your_password";
    private static Connection connection = null;

    static {
        try {
            // Load the JDBC driver
            // Replace with the appropriate class name from jcbd.jar
            Class.forName("com.mysql.cj.jdbc.Driver");  // This depends on your jar file and the DB type

            // Establish the connection
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database Connected Successfully!");

        } catch (ClassNotFoundException e) {
            System.out.println("❌ JDBC Driver Not Found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ Database Connection Failed!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        return connection;
    }
}
