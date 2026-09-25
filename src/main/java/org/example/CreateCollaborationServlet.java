package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Collaboration;
import model.dao.CollaborationDAO;

import java.io.IOException;

@WebServlet("/create-collaboration")
public class CreateCollaborationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        jakarta.servlet.http.HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInStudent") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/create-collaboration.jsp")
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
        int creatorId = loggedInStudent.getStudentId();

        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String description = request.getParameter("description");

        Collaboration collaboration = new Collaboration(
                0,
                creatorId,
                title,
                category,
                description,
                "Open"
        );

        CollaborationDAO dao = new CollaborationDAO();

        boolean success = dao.createCollaboration(collaboration);

        if (success) {
            response.sendRedirect(
                    request.getContextPath() + "/collaborations"
            );
        } else {
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Failed to create collaboration."
            );
        }
    }
}