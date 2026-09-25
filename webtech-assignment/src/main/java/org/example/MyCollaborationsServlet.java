package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Collaboration;
import model.Student;
import model.dao.CollaborationDAO;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/my-collaborations")
public class MyCollaborationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        jakarta.servlet.http.HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInStudent") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Student loggedInStudent = (Student) session.getAttribute("loggedInStudent");
        int creatorId = loggedInStudent.getStudentId();

        CollaborationDAO collaborationDAO = new CollaborationDAO();
        List<Collaboration> collaborations = collaborationDAO.getCollaborationsByCreator(creatorId);

        Map<Integer, Integer> applicationCounts = new HashMap<>();
        for (Collaboration collaboration : collaborations) {
            applicationCounts.put(
                    collaboration.getCollabId(),
                    collaborationDAO.getApplicationCount(collaboration.getCollabId())
            );
        }

        request.setAttribute("collaborations", collaborations);
        request.setAttribute("applicationCounts", applicationCounts);

        request.getRequestDispatcher("/my-collaborations.jsp")
                .forward(request, response);
    }
}
