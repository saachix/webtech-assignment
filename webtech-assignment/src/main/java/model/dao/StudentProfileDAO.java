package model.dao;

import model.StudentProfile;
import org.example.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StudentProfileDAO implements StudentProfileDAOInterface {

    @Override
    public StudentProfile getProfileByStudentId(int studentId) {

        String sql = "SELECT * FROM student_profiles WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new StudentProfile(
                        rs.getInt("profile_id"),
                        rs.getInt("student_id"),
                        rs.getString("bio"),
                        rs.getString("skills"),
                        rs.getString("portfolio_link")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean createProfile(StudentProfile profile) {

        String sql = "INSERT INTO student_profiles " +
                     "(student_id, bio, skills, portfolio_link) " +
                     "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1,    profile.getStudentId());
            ps.setString(2, profile.getBio());
            ps.setString(3, profile.getSkills());
            ps.setString(4, profile.getPortfolioLink());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateProfile(StudentProfile profile) {

        String sql = "UPDATE student_profiles " +
                     "SET bio = ?, skills = ?, portfolio_link = ? " +
                     "WHERE student_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, profile.getBio());
            ps.setString(2, profile.getSkills());
            ps.setString(3, profile.getPortfolioLink());
            ps.setInt(4,    profile.getStudentId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean saveProfile(StudentProfile profile) {

        StudentProfile existing = getProfileByStudentId(profile.getStudentId());

        if (existing == null) {
            return createProfile(profile);
        } else {
            return updateProfile(profile);
        }
    }
}
