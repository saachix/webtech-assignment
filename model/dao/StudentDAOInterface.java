package dao;

import model.Student;
import java.util.List;

public interface StudentDAO {

    void addStudent(Student student);

    Student getStudentById(int studentId);

    List<Student> getAllStudents();
}
