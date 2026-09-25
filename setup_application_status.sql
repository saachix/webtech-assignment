-- =========================================================
-- Campus Collab - Application status column
-- =========================================================
-- Run this manually against MariaDB/MySQL.
-- Do not drop or rewrite the applications table.
-- Existing rows receive status = 'Pending' via the DEFAULT.

USE student_creator_hub;

ALTER TABLE applications
    ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'Pending';
