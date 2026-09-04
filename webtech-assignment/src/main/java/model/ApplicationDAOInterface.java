package dao;

import model.Application;
import java.util.List;

public interface ApplicationDAOInterface {

    boolean apply(Application application);

    List<Application> getApplicationsByCollaboration(int collabId);

    List<Application> getApplicationsByApplicant(int applicantId);
}
