package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL;
    private static final String USER;
    private static final String PASSWORD;

    static {
        String railwayHost = System.getenv("MYSQLHOST");

        if (railwayHost != null && !railwayHost.isBlank()) {

            // Railway environment
            String port = System.getenv("MYSQLPORT");
            String database = System.getenv("MYSQLDATABASE");

            URL = "jdbc:mysql://" + railwayHost + ":" + port + "/" + database
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            USER = System.getenv("MYSQLUSER");
            PASSWORD = System.getenv("MYSQLPASSWORD");

        } else {

            // Local XAMPP environment
            URL = "jdbc:mysql://localhost:3306/student_creator_hub";
            USER = "root";
            PASSWORD = "";
        }
    }

    public static Connection getConnection() throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found!", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}