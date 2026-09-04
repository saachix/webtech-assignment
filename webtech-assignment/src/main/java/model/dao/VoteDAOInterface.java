package dao;

public interface VoteDAOInterface {

    boolean hasUserVoted(int collabId, int voterId);

    boolean addVote(int collabId, int voterId);

    int getVoteCount(int collabId);
}
