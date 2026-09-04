package org.example;

public class DBTest {

    public static void main(String[] args) {

        try {
            DBConnection.getConnection();
            System.out.println("DATABASE CONNECTION SUCCESSFUL!");

        } catch (Exception e) {
            System.out.println("DATABASE CONNECTION FAILED!");
            e.printStackTrace();
        }
    }
}