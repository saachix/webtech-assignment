package dao;

import model.Application;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO implements ApplicationDAOInterface {

    @Override
    public boolean apply(Application application) {
        String sql = "INSERT INTO application (collabId, applicantId, pitchText) VALUES (?, ?, ?)";

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

        String sql = "SELECT * FROM application WHERE collabId = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, collabId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                applications.add(new Application(
                    rs.getInt("applicationId"),
                    rs.getInt("collabId"),
                    rs.getInt("applicantId"),
                    rs.getString("pitchText")
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

        String sql = "SELECT * FROM application WHERE applicantId = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, applicantId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                applications.add(new Application(
                    rs.getInt("applicationId"),
                    rs.getInt("collabId"),
                    rs.getInt("applicantId"),
                    rs.getString("pitchText")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }
}
