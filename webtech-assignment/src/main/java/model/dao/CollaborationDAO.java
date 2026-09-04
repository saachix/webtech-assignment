package model.dao;

import model.Collaboration;
import org.example.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CollaborationDAO implements CollaborationDAOInterface {

    @Override
    public boolean createCollaboration(Collaboration collaboration) {

        String sql = "INSERT INTO collaborations " +
                "(creator_id, title, category, description, status) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collaboration.getCreatorId());
            ps.setString(2, collaboration.getTitle());
            ps.setString(3, collaboration.getCategory());
            ps.setString(4, collaboration.getDescription());
            ps.setString(5, collaboration.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<Collaboration> getAllOpenCollaborations() {

        List<Collaboration> collaborations = new ArrayList<>();

        String sql = "SELECT * FROM collaborations WHERE status = 'Open'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                collaborations.add(new Collaboration(
                        rs.getInt("collab_id"),
                        rs.getInt("creator_id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("status")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return collaborations;
    }

    @Override
    public List<Collaboration> getCollaborationsByCategory(String category) {

        List<Collaboration> collaborations = new ArrayList<>();

        String sql = "SELECT * FROM collaborations " +
                "WHERE category = ? AND status = 'Open'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, category);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                collaborations.add(new Collaboration(
                        rs.getInt("collab_id"),
                        rs.getInt("creator_id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("status")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return collaborations;
    }

    @Override
    public Collaboration getCollaborationById(int collabId) {

        String sql = "SELECT * FROM collaborations WHERE collab_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collabId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Collaboration(
                        rs.getInt("collab_id"),
                        rs.getInt("creator_id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("status")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Collaboration> getCollaborationsByCreator(int creatorId) {

        List<Collaboration> collaborations = new ArrayList<>();

        String sql = "SELECT * FROM collaborations WHERE creator_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, creatorId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                collaborations.add(new Collaboration(
                        rs.getInt("collab_id"),
                        rs.getInt("creator_id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("status")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return collaborations;
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

    @Override
    public int getApplicationCount(int collabId) {

        String sql = "SELECT COUNT(*) FROM applications WHERE collab_id = ?";

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