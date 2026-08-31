package dao;

import model.Collaboration;
import java.util.List;

public interface CollaborationDAOInterface {

    boolean createCollaboration(Collaboration collaboration);

    List<Collaboration> getAllOpenCollaborations();

    List<Collaboration> getCollaborationsByCategory(String category);

    Collaboration getCollaborationById(int collabId);

    List<Collaboration> getCollaborationsByCreator(int creatorId);

    int getVoteCount(int collabId);

    int getApplicationCount(int collabId);
}
