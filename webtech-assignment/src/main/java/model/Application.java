package model;

public class Application {

    private int applicationId;
    private int collabId;
    private int applicantId;
    private String pitchText;

    public Application() {
    }

    public Application(int applicationId, int collabId, int applicantId, String pitchText) {
        this.applicationId = applicationId;
        this.collabId = collabId;
        this.applicantId = applicantId;
        this.pitchText = pitchText;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public int getCollabId() {
        return collabId;
    }

    public void setCollabId(int collabId) {
        this.collabId = collabId;
    }

    public int getApplicantId() {
        return applicantId;
    }

    public void setApplicantId(int applicantId) {
        this.applicantId = applicantId;
    }

    public String getPitchText() {
        return pitchText;
    }

    public void setPitchText(String pitchText) {
        this.pitchText = pitchText;
    }
}
