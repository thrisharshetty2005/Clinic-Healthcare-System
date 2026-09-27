-- Clinic Healthcare System
-- Database Management System Mini Project
-- Source: Project report provided for this project

CREATE DATABASE IF NOT EXISTS HOSPITAL001;
USE HOSPITAL001;

-- -----------------------------------------------------
-- Table: Doctor
-- -----------------------------------------------------
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Speciality VARCHAR(100)
);

-- -----------------------------------------------------
-- Table: Patient
-- -----------------------------------------------------
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact VARCHAR(15)
);

-- -----------------------------------------------------
-- Table: Appointment
-- -----------------------------------------------------
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    DoctorID INT,
    PatientID INT,
    Date DATE,
    Time TIME,
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- -----------------------------------------------------
-- Sample Doctor Data
-- -----------------------------------------------------
INSERT INTO Doctor VALUES (3, 'Dr. Aryan Kapoor', 'Orthopedics');
INSERT INTO Doctor VALUES (4, 'Dr. Meera Nair', 'Dermatology');
INSERT INTO Doctor VALUES (5, 'Dr. Rakesh Iyer', 'General Medicine');
INSERT INTO Doctor VALUES (6, 'Dr. Ayesha Khan', 'ENT');
INSERT INTO Doctor VALUES (7, 'Dr. Manish Verma', 'Pediatrics');

-- -----------------------------------------------------
-- Sample Patient Data
-- -----------------------------------------------------
INSERT INTO Patient VALUES (103, 'Kavya Rao', '9898765432');
INSERT INTO Patient VALUES (104, 'Arjun Shetty', '9888123456');
INSERT INTO Patient VALUES (105, 'Sneha Kulkarni', '9812345678');
INSERT INTO Patient VALUES (106, 'Rohit Sharma', '9822221111');
INSERT INTO Patient VALUES (107, 'Sana Ahmed', '9833332222');

-- -----------------------------------------------------
-- Sample Appointment Data
-- -----------------------------------------------------
INSERT INTO Appointment VALUES (1003, 3, 103, '2025-04-12', '09:00:00');
INSERT INTO Appointment VALUES (1004, 4, 104, '2025-04-13', '11:15:00');
INSERT INTO Appointment VALUES (1005, 5, 105, '2025-04-14', '13:45:00');
INSERT INTO Appointment VALUES (1006, 6, 106, '2025-04-15', '15:30:00');
INSERT INTO Appointment VALUES (1007, 7, 107, '2025-04-16', '10:00:00');

-- -----------------------------------------------------
-- Basic Queries
-- -----------------------------------------------------
SELECT * FROM Appointment;
SELECT * FROM Patient;
SELECT * FROM Doctor;

-- 1. Show patient names and contacts
SELECT Name, Contact
FROM Patient;

-- 2. List all appointments with doctor and patient names
SELECT
    A.AppointmentID,
    D.Name AS Doctor,
    P.Name AS Patient,
    A.Date,
    A.Time
FROM Appointment A
JOIN Doctor D ON A.DoctorID = D.DoctorID
JOIN Patient P ON A.PatientID = P.PatientID;

-- 3. Find all upcoming appointments after '2025-04-12',
--    sorted by date and time
SELECT
    A.AppointmentID,
    D.Name AS DoctorName,
    P.Name AS PatientName,
    A.Date,
    A.Time
FROM Appointment A
JOIN Doctor D ON A.DoctorID = D.DoctorID
JOIN Patient P ON A.PatientID = P.PatientID
WHERE A.Date > '2025-04-12'
ORDER BY A.Date, A.Time;

-- 4. Count how many appointments each doctor has
SELECT
    D.Name AS DoctorName,
    COUNT(A.AppointmentID) AS TotalAppointments
FROM Doctor D
LEFT JOIN Appointment A ON D.DoctorID = A.DoctorID
GROUP BY D.Name
ORDER BY TotalAppointments DESC;

-- 5. Get patients who have appointments with doctors
--    specializing in 'Pediatrics'
SELECT DISTINCT
    P.PatientID,
    P.Name AS PatientName,
    D.Speciality
FROM Patient P
JOIN Appointment A ON P.PatientID = A.PatientID
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE D.Speciality = 'Pediatrics';

-- -----------------------------------------------------
-- DoctorStats Trigger
-- -----------------------------------------------------

-- Create DoctorStats table
CREATE TABLE DoctorStats (
    DoctorID INT PRIMARY KEY,
    AppointmentCount INT DEFAULT 0
);

-- Add all existing DoctorIDs
INSERT INTO DoctorStats (DoctorID)
SELECT DoctorID FROM Doctor;

-- Trigger to update appointment count after a new appointment
-- NOTE: The trigger syntax below is retained from the project
-- report and is intended for SQL Server-style syntax.
CREATE TRIGGER CountAppointments
ON Appointment
AFTER INSERT
AS
BEGIN
    UPDATE DoctorStats
    SET AppointmentCount = AppointmentCount + 1
    FROM DoctorStats ds
    JOIN inserted i ON ds.DoctorID = i.DoctorID;
END;

-- Test the trigger
INSERT INTO Appointment
VALUES (1009, 3, 104, '2025-04-20', '12:00:00');

SELECT * FROM DoctorStats;
