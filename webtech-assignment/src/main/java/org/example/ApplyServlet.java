package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Application;
import model.Student;
import model.dao.ApplicationDAO;

import java.io.IOException;

@WebServlet("/apply")
public class ApplyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInStudent") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String collabIdParameter = request.getParameter("collabId");

        if (collabIdParameter == null) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Collaboration ID is required."
            );
            return;
        }

        request.setAttribute(
                "collabId",
                Integer.parseInt(collabIdParameter)
        );

        request.getRequestDispatcher("/apply.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInStudent") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Student loggedInStudent =
                (Student) session.getAttribute("loggedInStudent");

        int applicantId = loggedInStudent.getStudentId();

        int collabId = Integer.parseInt(
                request.getParameter("collabId")
        );

        String pitchText = request.getParameter("pitchText");

        ApplicationDAO applicationDAO = new ApplicationDAO();

        // Prevent creator from applying to their own collaboration
        if (applicationDAO.isCreatorOfCollaboration(collabId, applicantId)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/collaborations?message=self-application"
            );

            return;
        }

        // Prevent duplicate applications
        if (applicationDAO.hasApplied(collabId, applicantId)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/collaborations?message=already-applied"
            );

            return;
        }

        Application application = new Application(
                0,
                collabId,
                applicantId,
                pitchText
        );

        boolean success = applicationDAO.apply(application);

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/collaborations?message=application-success"
            );

        } else {

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Failed to submit application."
            );
        }
    }
}