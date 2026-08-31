package dao;

import model.Collaboration;
import java.util.List;

public interface CollaborationDAO {

    void addCollaboration(Collaboration collaboration);

    List<Collaboration> getAllCollaborations();

    Collaboration getCollaborationById(int collabId);

    void updateCollaboration(Collaboration collaboration);

    void deleteCollaboration(int collabId);
}
