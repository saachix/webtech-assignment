package model;

public class Collaboration {

    private int collabId;
    private int creatorId;
    private String title;
    private String category;
    private String description;
    private String status;

    public Collaboration() {
    }

    public Collaboration(int collabId, int creatorId, String title,
                          String category, String description, String status) {
        this.collabId = collabId;
        this.creatorId = creatorId;
        this.title = title;
        this.category = category;
        this.description = description;
        this.status = status;
    }

    public int getCollabId() {
        return collabId;
    }

    public void setCollabId(int collabId) {
        this.collabId = collabId;
    }

    public int getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(int creatorId) {
        this.creatorId = creatorId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
