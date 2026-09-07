package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.dao.StudentDAO;
import model.dao.VoteDAO;

import java.io.IOException;

@WebServlet("/vote")
public class VoteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int collabId = Integer.parseInt(
                request.getParameter("collabId")
        );

        int voterId = Integer.parseInt(
                request.getParameter("voterId")
        );

        StudentDAO studentDAO = new StudentDAO();
        VoteDAO voteDAO = new VoteDAO();

        // Check whether the student exists
        if (studentDAO.getStudentById(voterId) == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/collaborations?message=invalid-student"
            );

            return;
        }

        // Check whether this student has already voted
        if (voteDAO.hasUserVoted(collabId, voterId)) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/collaborations?message=already-voted"
            );

            return;
        }

        // Add the vote
        boolean success = voteDAO.addVote(collabId, voterId);

        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/collaborations?message=vote-success"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/collaborations?message=vote-error"
            );
        }
    }
}