package model.dao;

import model.Application;

import java.util.List;

public interface ApplicationDAOInterface {

    boolean apply(Application application);

    boolean hasApplied(int collabId, int applicantId);

    boolean isCreatorOfCollaboration(int collabId, int studentId);

    List<Application> getApplicationsByCollaboration(int collabId);

    List<Application> getApplicationsByApplicant(int applicantId);

    Application getApplicationById(int applicationId);

    boolean updateApplicationStatus(int applicationId, String status);
}