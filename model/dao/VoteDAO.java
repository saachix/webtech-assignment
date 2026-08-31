package dao;

import model.Vote;
import java.util.List;

public interface VoteDAO {

    void addVote(Vote vote);

    List<Vote> getVotesByCollabId(int collabId);

    boolean hasUserVoted(int collabId, int voterId);
}
