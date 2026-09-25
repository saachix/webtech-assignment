package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Application;
import model.dao.ApplicationDAO;

import java.io.IOException;

@WebServlet("/apply")
public class ApplyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        jakarta.servlet.http.HttpSession session = request.getSession(false);
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

        request.setAttribute("collabId", Integer.parseInt(collabIdParameter));

        request.getRequestDispatcher("/apply.jsp")
                .forward(request, response);
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
        int applicantId = loggedInStudent.getStudentId();

        int collabId = Integer.parseInt(
                request.getParameter("collabId")
        );

        String pitchText = request.getParameter("pitchText");

        Application application = new Application(
                0,
                collabId,
                applicantId,
                pitchText
        );

        ApplicationDAO applicationDAO = new ApplicationDAO();

        boolean success = applicationDAO.apply(application);

        if (success) {
            response.sendRedirect(
                    request.getContextPath() + "/collaborations"
            );
        } else {
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Failed to submit application."
            );
        }
    }
}