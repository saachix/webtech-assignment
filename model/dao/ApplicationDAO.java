package dao;

import model.Application;
import java.util.List;

public interface ApplicationDAO {

    void addApplication(Application application);

    List<Application> getApplicationsByCollabId(int collabId);

    Application getApplicationById(int applicationId);

    void updateApplication(Application application);

    void deleteApplication(int applicationId);
}
