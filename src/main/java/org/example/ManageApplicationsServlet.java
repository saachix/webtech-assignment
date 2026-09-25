package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Application;
import model.Collaboration;
import model.Student;
import model.dao.ApplicationDAO;
import model.dao.CollaborationDAO;
import model.dao.StudentDAO;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/collaboration-applications")
public class ManageApplicationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Student loggedInStudent = requireLoggedInStudent(request, response);
        if (loggedInStudent == null) {
            return;
        }

        Integer collabId = parsePositiveInt(request.getParameter("collabId"));
        if (collabId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Collaboration ID is required.");
            return;
        }

        CollaborationDAO collaborationDAO = new CollaborationDAO();
        Collaboration collaboration = collaborationDAO.getCollaborationById(collabId);

        if (collaboration == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Collaboration not found.");
            return;
        }

        if (!isCreator(loggedInStudent, collaboration)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Only the creator of this collaboration can view applications.");
            return;
        }

        ApplicationDAO applicationDAO = new ApplicationDAO();
        StudentDAO studentDAO = new StudentDAO();

        List<Application> applications = applicationDAO.getApplicationsByCollaboration(collabId);
        Map<Integer, Student> applicants = new HashMap<>();

        for (Application application : applications) {
            int applicantId = application.getApplicantId();
            if (!applicants.containsKey(applicantId)) {
                applicants.put(applicantId, studentDAO.getStudentById(applicantId));
            }
        }

        request.setAttribute("collaboration", collaboration);
        request.setAttribute("applications", applications);
        request.setAttribute("applicants", applicants);

        request.getRequestDispatcher("/collaboration-applications.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Student loggedInStudent = requireLoggedInStudent(request, response);
        if (loggedInStudent == null) {
            return;
        }

        Integer applicationId = parsePositiveInt(request.getParameter("applicationId"));
        String status = request.getParameter("status");

        if (applicationId == null || status == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Application ID and status are required.");
            return;
        }

        if (!"Accepted".equals(status) && !"Rejected".equals(status)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid application status.");
            return;
        }

        ApplicationDAO applicationDAO = new ApplicationDAO();
        Application application = applicationDAO.getApplicationById(applicationId);

        if (application == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Application not found.");
            return;
        }

        CollaborationDAO collaborationDAO = new CollaborationDAO();
        Collaboration collaboration = collaborationDAO.getCollaborationById(application.getCollabId());

        if (collaboration == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Collaboration not found.");
            return;
        }

        if (!isCreator(loggedInStudent, collaboration)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Only the creator of this collaboration can manage applications.");
            return;
        }

        if (loggedInStudent.getStudentId() == application.getApplicantId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Applicants cannot accept or reject their own applications.");
            return;
        }

        boolean updated = applicationDAO.updateApplicationStatus(applicationId, status);
        if (!updated) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Failed to update application status.");
            return;
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/collaboration-applications?collabId="
                        + application.getCollabId()
        );
    }

    private Student requireLoggedInStudent(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        jakarta.servlet.http.HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInStudent") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return null;
        }

        return (Student) session.getAttribute("loggedInStudent");
    }

    private boolean isCreator(Student loggedInStudent, Collaboration collaboration) {
        return loggedInStudent.getStudentId() == collaboration.getCreatorId();
    }

    private Integer parsePositiveInt(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }

        try {
            int parsed = Integer.parseInt(value.trim());
            if (parsed <= 0) {
                return null;
            }
            return parsed;
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
