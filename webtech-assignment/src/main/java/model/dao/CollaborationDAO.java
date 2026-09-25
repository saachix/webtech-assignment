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

    @Override
    public List<Collaboration> searchCollaborations(String keyword,
                                                    String category,
                                                    String sortBy) {

        List<Collaboration> collaborations = new ArrayList<>();

        boolean hasKeyword  = keyword  != null && !keyword.trim().isEmpty();
        boolean hasCategory = category != null && !category.trim().isEmpty();
        boolean sortByVotes = "votes".equalsIgnoreCase(sortBy);

        // Build query dynamically — base always restricts to Open collaborations
        StringBuilder sql = new StringBuilder(
                "SELECT c.collab_id, c.creator_id, c.title, c.category, " +
                "       c.description, c.status ");

        if (sortByVotes) {
            // JOIN votes so we can ORDER BY vote count
            sql.append(", COUNT(v.vote_id) AS vote_count ")
               .append("FROM collaborations c ")
               .append("LEFT JOIN votes v ON c.collab_id = v.collab_id ");
        } else {
            sql.append("FROM collaborations c ");
        }

        sql.append("WHERE c.status = 'Open' ");

        if (hasCategory) {
            sql.append("AND c.category = ? ");
        }

        if (hasKeyword) {
            sql.append("AND (c.title LIKE ? OR c.description LIKE ?) ");
        }

        if (sortByVotes) {
            sql.append("GROUP BY c.collab_id, c.creator_id, c.title, " +
                       "         c.category, c.description, c.status ");
            sql.append("ORDER BY vote_count DESC ");
        } else {
            // Latest first — highest collab_id = most recently inserted
            sql.append("ORDER BY c.collab_id DESC ");
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            if (hasCategory) {
                ps.setString(paramIndex++, category.trim());
            }

            if (hasKeyword) {
                String pattern = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, pattern);
                ps.setString(paramIndex++, pattern);
            }

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
}