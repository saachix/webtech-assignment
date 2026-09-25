package model;

/**
 * Represents a student's optional portfolio/skills profile.
 * Stored in the student_profiles table (1-to-1 with students).
 */
public class StudentProfile {

    private int profileId;
    private int studentId;
    private String bio;
    private String skills;
    private String portfolioLink;

    public StudentProfile() {
    }

    public StudentProfile(int profileId, int studentId,
                          String bio, String skills, String portfolioLink) {
        this.profileId     = profileId;
        this.studentId     = studentId;
        this.bio           = bio;
        this.skills        = skills;
        this.portfolioLink = portfolioLink;
    }

    public int getProfileId() {
        return profileId;
    }

    public void setProfileId(int profileId) {
        this.profileId = profileId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getPortfolioLink() {
        return portfolioLink;
    }

    public void setPortfolioLink(String portfolioLink) {
        this.portfolioLink = portfolioLink;
    }
}
