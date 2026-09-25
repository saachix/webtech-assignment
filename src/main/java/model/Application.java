package model;

public class Application {

    private int applicationId;
    private int collabId;
    private int applicantId;
    private String pitchText;
    private String status;

    public Application() {
    }

    public Application(int applicationId, int collabId, int applicantId, String pitchText) {
        this(applicationId, collabId, applicantId, pitchText, "Pending");
    }

    public Application(int applicationId, int collabId, int applicantId, String pitchText, String status) {
        this.applicationId = applicationId;
        this.collabId = collabId;
        this.applicantId = applicantId;
        this.pitchText = pitchText;
        this.status = status;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
