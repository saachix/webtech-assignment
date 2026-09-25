package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Student;
import model.dao.StudentDAO;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        StudentDAO studentDAO = new StudentDAO();
        
        if (studentDAO.getStudentByEmail(email) != null) {
            request.setAttribute("errorMessage", "Email is already registered.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        Student newStudent = new Student(0, name, email, password);
        boolean success = studentDAO.register(newStudent);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/login?message=registered");
        } else {
            request.setAttribute("errorMessage", "Failed to register. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
