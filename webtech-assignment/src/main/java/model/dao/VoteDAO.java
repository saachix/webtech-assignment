package model.dao;

import org.example.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class VoteDAO implements VoteDAOInterface {

    @Override
    public boolean hasUserVoted(int collabId, int voterId) {
        String sql = "SELECT * FROM votes WHERE collab_id = ? AND voter_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collabId);
            ps.setInt(2, voterId);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean addVote(int collabId, int voterId) {

        if (hasUserVoted(collabId, voterId)) {
            return false;
        }

        String sql = "INSERT INTO votes (collab_id, voter_id) VALUES (?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collabId);
            ps.setInt(2, voterId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public int getVoteCount(int collabId) {
        String sql = "SELECT COUNT(*) FROM votes WHERE collab_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collabId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}