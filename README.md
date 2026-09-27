# Clinic Healthcare System

## Project Description

Clinic Healthcare System is a Database Management System mini project developed to manage basic clinic operations such as doctors, patients, and appointments.

The system uses a relational database to store doctor and patient information and manage appointments between them. SQL queries, primary keys, foreign keys, joins, aggregate functions, and triggers are used in the project.

## Features

- Store doctor information
- Store patient information
- Manage appointments
- Connect doctors and patients through appointments
- View doctor and patient details
- Display appointments with doctor and patient names
- Find upcoming appointments
- Count appointments for each doctor
- Find patients visiting doctors from a particular speciality
- Use a trigger to update appointment counts

## Database Tables

### Doctor
- DoctorID
- Name
- Speciality

### Patient
- PatientID
- Name
- Contact

### Appointment
- AppointmentID
- DoctorID
- PatientID
- Date
- Time

### DoctorStats
- DoctorID
- AppointmentCount

## Technologies and Concepts Used

- SQL
- Relational Database
- Database Management System
- Primary Keys
- Foreign Keys
- SQL Joins
- Aggregate Functions
- GROUP BY
- ORDER BY
- SQL Trigger
- Referential Integrity

## SQL Queries Included

1. Display all appointments
2. Display all patients
3. Display all doctors
4. Show patient names and contacts
5. List appointments with doctor and patient names
6. Find upcoming appointments
7. Count appointments for each doctor
8. Find patients who have appointments with Pediatrics doctors
9. Update doctor appointment counts using a trigger

## How to Run

1. Open an SQL database tool.
2. Open `clinic_healthcare.sql`.
3. Run the SQL script.
4. The database `HOSPITAL001` will be created.
5. The required tables and sample data will be created.
6. The included queries can then be executed.

## Project File

```text
Clinic-Healthcare-System/
│
├── clinic_healthcare.sql
├── README.md
└── .gitignore
