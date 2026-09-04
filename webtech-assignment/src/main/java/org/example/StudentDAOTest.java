package org.example;

import model.Student;
import model.dao.StudentDAO;

public class StudentDAOTest {

    public static void main(String[] args) {

        StudentDAO dao = new StudentDAO();

        Student student = dao.getStudentById(1);

        if (student != null) {
            System.out.println("STUDENT FOUND!");
            System.out.println("ID: " + student.getStudentId());
            System.out.println("Name: " + student.getName());
            System.out.println("Email: " + student.getEmail());
        } else {
            System.out.println("STUDENT NOT FOUND!");
        }
    }
}