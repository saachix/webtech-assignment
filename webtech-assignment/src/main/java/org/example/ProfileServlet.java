package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Student;
import model.StudentProfile;
import model.dao.StudentDAO;
import model.dao.StudentProfileDAO;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    /**
     * GET /profile?studentId=X
     *   → view the student's profile page (profile.jsp)
     *
     * GET /profile?studentId=X&edit=true
     *   → open the edit/create profile form (edit-profile.jsp)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        jakarta.servlet.http.HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInStudent") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        model.Student loggedInStudent = (model.Student) session.getAttribute("loggedInStudent");

        String studentIdParam = request.getParameter("studentId");
        int targetStudentId = loggedInStudent.getStudentId();
        boolean isOwnProfile = true;

        if (studentIdParam != null && !studentIdParam.trim().isEmpty()) {
            try {
                int paramId = Integer.parseInt(studentIdParam.trim());
                if (paramId != loggedInStudent.getStudentId()) {
                    targetStudentId = paramId;
                    isOwnProfile = false;
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Student ID.");
                return;
            }
        }

        StudentDAO studentDAO = new StudentDAO();
        Student student = studentDAO.getStudentById(targetStudentId);

        if (student == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Student not found.");
            return;
        }

        StudentProfileDAO profileDAO = new StudentProfileDAO();
        StudentProfile profile = profileDAO.getProfileByStudentId(targetStudentId);

        request.setAttribute("student", student);
        request.setAttribute("profile", profile);
        request.setAttribute("isOwnProfile", isOwnProfile);

        String edit = request.getParameter("edit");
        if ("true".equals(edit) && isOwnProfile) {
            request.getRequestDispatcher("/edit-profile.jsp")
                    .forward(request, response);
        } else {
            request.getRequestDispatcher("/profile.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        jakarta.servlet.http.HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInStudent") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        model.Student loggedInStudent = (model.Student) session.getAttribute("loggedInStudent");
        int studentId = loggedInStudent.getStudentId();

        String bio           = request.getParameter("bio");
        String skills        = request.getParameter("skills");
        String portfolioLink = request.getParameter("portfolioLink");

        if (bio           == null) bio           = "";
        if (skills        == null) skills        = "";
        if (portfolioLink == null) portfolioLink = "";

        StudentProfile profile = new StudentProfile(
                0, studentId, bio.trim(), skills.trim(), portfolioLink.trim()
        );

        StudentProfileDAO profileDAO = new StudentProfileDAO();
        boolean success = profileDAO.saveProfile(profile);

        if (success) {
            response.sendRedirect(
                    request.getContextPath()
                            + "/profile"
                            + "?message=saved"
            );
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Failed to save profile. Please try again.");
        }
    }
}
