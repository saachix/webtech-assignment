package model.dao;

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

    /**
     * Flexible search used by the Browse page.
     *
     * @param keyword  search term matched against title and description
     *                 (pass null or blank to skip keyword filtering)
     * @param category exact category name to filter by
     *                 (pass null or blank to skip category filtering)
     * @param sortBy   "votes" to sort by vote count descending,
     *                 anything else (or null) returns latest-first (by collab_id desc)
     */
    List<Collaboration> searchCollaborations(String keyword,
                                             String category,
                                             String sortBy);
}