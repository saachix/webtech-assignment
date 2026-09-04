package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Collaboration;
import model.dao.CollaborationDAO;

import java.io.IOException;
import java.util.List;

@WebServlet("/collaborations")
public class CollaborationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CollaborationDAO collaborationDAO = new CollaborationDAO();

        List<Collaboration> collaborations =
                collaborationDAO.getAllOpenCollaborations();

        request.setAttribute("collaborations", collaborations);

        request.getRequestDispatcher("/collaborations.jsp")
                .forward(request, response);
    }
}