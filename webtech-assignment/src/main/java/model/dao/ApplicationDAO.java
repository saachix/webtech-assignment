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
    public List<Application> getApplicationsByCollaboration(int collabId) {
        List<Application> applications = new ArrayList<>();

        String sql = "SELECT * FROM applications WHERE collab_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collabId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                applications.add(new Application(
                        rs.getInt("application_id"),
                        rs.getInt("collab_id"),
                        rs.getInt("applicant_id"),
                        rs.getString("pitch_text")
                ));
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
                applications.add(new Application(
                        rs.getInt("application_id"),
                        rs.getInt("collab_id"),
                        rs.getInt("applicant_id"),
                        rs.getString("pitch_text")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }
}