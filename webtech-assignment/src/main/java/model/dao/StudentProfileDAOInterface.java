package model.dao;

import model.StudentProfile;

public interface StudentProfileDAOInterface {

    /**
     * Returns the profile for the given student, or null if none exists yet.
     */
    StudentProfile getProfileByStudentId(int studentId);

    /**
     * Creates a new profile row. Returns true on success.
     */
    boolean createProfile(StudentProfile profile);

    /**
     * Updates an existing profile row. Returns true on success.
     */
    boolean updateProfile(StudentProfile profile);

    /**
     * Convenience method: inserts if no profile exists, updates otherwise.
     * Returns true on success.
     */
    boolean saveProfile(StudentProfile profile);
}
