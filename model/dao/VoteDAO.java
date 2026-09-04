package dao;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class VoteDAO implements VoteDAOInterface {

    @Override
    public boolean hasUserVoted(int collabId, int voterId) {
        String sql = "SELECT * FROM vote WHERE collabId = ? AND voterId = ?";

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

        String sql = "INSERT INTO vote (collabId, voterId) VALUES (?, ?)";

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
        String sql = "SELECT COUNT(*) FROM vote WHERE collabId = ?";

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
