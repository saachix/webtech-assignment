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

        // Read filter/search/sort parameters from the query string.
        // All parameters are optional — empty/null values mean "no filter".
        String keyword  = request.getParameter("keyword");
        String category = request.getParameter("category");
        String sortBy   = request.getParameter("sortBy");

        // Normalize blanks to null so JSP can do simple null checks
        if (keyword  != null && keyword.trim().isEmpty())  keyword  = null;
        if (category != null && category.trim().isEmpty()) category = null;
        if (sortBy   != null && sortBy.trim().isEmpty())   sortBy   = null;

        // Always route through the unified search method.
        // When all params are null it returns all open collaborations ordered
        // latest-first — equivalent to the old getAllOpenCollaborations() call.
        List<Collaboration> collaborations =
                collaborationDAO.searchCollaborations(keyword, category, sortBy);

        // Pass the list and the current filter state back to the JSP
        request.setAttribute("collaborations", collaborations);
        request.setAttribute("keyword",  keyword  != null ? keyword  : "");
        request.setAttribute("category", category != null ? category : "");
        request.setAttribute("sortBy",   sortBy   != null ? sortBy   : "latest");

        request.getRequestDispatcher("/collaborations.jsp")
                .forward(request, response);
    }
}