package model.dao;

import model.Application;
import org.example.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO implements ApplicationDAOInterface {

    @Override
    public boolean apply(Application application) {

        String sql = "INSERT INTO applications " +
                "(collab_id, applicant_id, pitch_text) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, application.getCollabId());
            ps.setInt(2, application.getApplicantId());
            ps.setString(3, application.getPitchText());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean hasApplied(int collabId, int applicantId) {

        String sql = "SELECT COUNT(*) FROM applications " +
                "WHERE collab_id = ? AND applicant_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collabId);
            ps.setInt(2, applicantId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean isCreatorOfCollaboration(int collabId, int studentId) {

        String sql = "SELECT COUNT(*) FROM collaborations " +
                "WHERE collab_id = ? AND creator_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collabId);
            ps.setInt(2, studentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<Application> getApplicationsByCollaboration(int collabId) {

        List<Application> applications = new ArrayList<>();

        String sql = "SELECT * FROM applications WHERE collab_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collabId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                applications.add(mapApplication(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }

    @Override
    public List<Application> getApplicationsByApplicant(int applicantId) {

        List<Application> applications = new ArrayList<>();

        String sql = "SELECT * FROM applications WHERE applicant_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, applicantId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                applications.add(mapApplication(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }

    @Override
    public Application getApplicationById(int applicationId) {

        String sql = "SELECT * FROM applications WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, applicationId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapApplication(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateApplicationStatus(int applicationId, String status) {

        if (!isAllowedStatus(status)) {
            return false;
        }

        String sql = "UPDATE applications SET status = ? " +
                "WHERE application_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, applicationId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private Application mapApplication(ResultSet rs) throws Exception {

        String status = rs.getString("status");

        if (status == null || status.isBlank()) {
            status = "Pending";
        }

        return new Application(
                rs.getInt("application_id"),
                rs.getInt("collab_id"),
                rs.getInt("applicant_id"),
                rs.getString("pitch_text"),
                status
        );
    }

    private boolean isAllowedStatus(String status) {

        return "Pending".equals(status)
                || "Accepted".equals(status)
                || "Rejected".equals(status);
    }
}