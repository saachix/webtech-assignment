package dao;

import model.Student;

public interface StudentDAOInterface {

    Student getStudentById(int studentId);

    Student login(String email, String password);
}
