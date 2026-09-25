package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Student;
import model.dao.StudentDAO;

import java.io.IOException;
import java.util.List;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        StudentDAO studentDAO = new StudentDAO();

        List<Student> students = studentDAO.getAllStudents();

        var out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Students</title>");
        out.println("</head>");

        out.println("<body>");

        out.println("<h1>Students</h1>");

        for (Student student : students) {
            out.println("<p>");
            out.println(student.getStudentId() + " - ");
            out.println(student.getName() + " - ");
            out.println(student.getEmail());
            out.println("</p>");
        }

        out.println("</body>");
        out.println("</html>");
    }
}