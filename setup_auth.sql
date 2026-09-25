-- =========================================================
-- Campus Collab - Authentication Database Setup
-- =========================================================

USE student_creator_hub;

-- Add password column to existing Students table.
-- Keep it nullable during the migration so existing
-- records are not invalidated.
ALTER TABLE students
    ADD COLUMN password VARCHAR(255) NULL;

-- Set the initial password for the existing test accounts.
--
-- Password for all three accounts:
-- password123
--
-- SHA-256 + Base64 hash:
-- 75K3eLr+dx6JJFuJ7LwIpEpOFmwGZZkRiB84PURz6U8=

UPDATE students
SET password = '75K3eLr+dx6JJFuJ7LwIpEpOFmwGZZkRiB84PURz6U8='
WHERE email IN (
                'rahul@gmail.com',
                'aryan@gmail.com',
                'ananya@gmail.com'
    )
  AND password IS NULL;