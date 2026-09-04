package model.dao;

import model.Student;

import java.util.List;

public interface StudentDAOInterface {

    Student getStudentById(int studentId);

    List<Student> getAllStudents();

    Student login(String email, String password);
}