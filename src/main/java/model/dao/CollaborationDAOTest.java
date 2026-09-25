package model.dao;

import model.Collaboration;

import java.util.List;

public class CollaborationDAOTest {

    public static void main(String[] args) {

        CollaborationDAO dao = new CollaborationDAO();

        List<Collaboration> collaborations =
                dao.getAllOpenCollaborations();

        System.out.println("OPEN COLLABORATIONS:");

        for (Collaboration collaboration : collaborations) {
            System.out.println(
                    collaboration.getCollabId() + " - " +
                            collaboration.getTitle() + " - " +
                            collaboration.getCategory()
            );
        }
    }
}