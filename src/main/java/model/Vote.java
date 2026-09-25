package model;

public class Vote {

    private int voteId;
    private int collabId;
    private int voterId;

    public Vote() {
    }

    public Vote(int voteId, int collabId, int voterId) {
        this.voteId = voteId;
        this.collabId = collabId;
        this.voterId = voterId;
    }

    public int getVoteId() {
        return voteId;
    }

    public void setVoteId(int voteId) {
        this.voteId = voteId;
    }

    public int getCollabId() {
        return collabId;
    }

    public void setCollabId(int collabId) {
        this.collabId = collabId;
    }

    public int getVoterId() {
        return voterId;
    }

    public void setVoterId(int voterId) {
        this.voterId = voterId;
    }
}
