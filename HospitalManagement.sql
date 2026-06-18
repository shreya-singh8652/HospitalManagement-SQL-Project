CREATE DATABASE HospitalManagementSystem;

USE HospitalManagementSystem;

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50),
    experience_years INT
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50) NOT NULL,
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50)
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    
    FOREIGN KEY (patient_id)
    REFERENCES Patients(patient_id),

    FOREIGN KEY (doctor_id)
    REFERENCES Doctors(doctor_id)
);

CREATE TABLE Bills (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10,2),
    bill_date DATE,

    FOREIGN KEY (patient_id)
    REFERENCES Patients(patient_id)
);

SHOW TABLES;

INSERT INTO Doctors VALUES
(101,'Raj Sharma','Cardiology',12),
(102,'Neha Patel','Neurology',10),
(103,'Amit Khan','Orthopedic',8),
(104,'Priya Verma','Dermatology',6),
(105,'Rohit Mehta','Pediatrics',9),
(106,'Sneha Iyer','Gynecology',11),
(107,'Vikram Singh','ENT',7),
(108,'Anjali Gupta','Ophthalmology',5);

SELECT * FROM Doctors;

INSERT INTO Patients VALUES
(201,'Rahul Sharma',25,'Male','Mumbai'),
(202,'Priya Singh',30,'Female','Pune'),
(203,'Aman Verma',40,'Male','Navi Mumbai'),
(204,'Sneha Gupta',22,'Female','Thane'),
(205,'Rohit Jain',35,'Male','Mumbai'),
(206,'Anjali Patel',28,'Female','Panvel'),
(207,'Karan Mehta',45,'Male','Kalyan'),
(208,'Pooja Nair',32,'Female','Dombivli'),
(209,'Arjun Kapoor',27,'Male','Mumbai'),
(210,'Neha Shah',38,'Female','Pune'),
(211,'Vikas Yadav',29,'Male','Thane'),
(212,'Simran Kaur',24,'Female','Navi Mumbai');

SELECT * FROM Patients;

INSERT INTO Appointments VALUES
(301,201,101,'2026-06-01'),
(302,202,102,'2026-06-02'),
(303,203,103,'2026-06-03'),
(304,204,104,'2026-06-04'),
(305,205,105,'2026-06-05'),
(306,206,106,'2026-06-06'),
(307,207,107,'2026-06-07'),
(308,208,108,'2026-06-08'),
(309,209,101,'2026-06-09'),
(310,210,102,'2026-06-10'),
(311,211,103,'2026-06-11'),
(312,212,104,'2026-06-12'),
(313,201,105,'2026-06-13'),
(314,202,106,'2026-06-14'),
(315,203,107,'2026-06-15'),
(316,204,108,'2026-06-16'),
(317,205,101,'2026-06-17'),
(318,206,102,'2026-06-18'),
(319,207,103,'2026-06-19'),
(320,208,104,'2026-06-20');

SELECT * FROM Appointments;

SELECT COUNT(*) AS Total_Appointments
FROM Appointments;

INSERT INTO Bills VALUES
(401,201,5000.00,'2026-06-01'),
(402,202,7000.00,'2026-06-02'),
(403,203,4500.00,'2026-06-03'),
(404,204,3000.00,'2026-06-04'),
(405,205,8000.00,'2026-06-05'),
(406,206,6500.00,'2026-06-06'),
(407,207,9000.00,'2026-06-07'),
(408,208,3500.00,'2026-06-08'),
(409,209,7500.00,'2026-06-09'),
(410,210,4000.00,'2026-06-10'),
(411,211,5500.00,'2026-06-11'),
(412,212,6000.00,'2026-06-12'),
(413,201,2500.00,'2026-06-13'),
(414,202,4200.00,'2026-06-14'),
(415,205,3800.00,'2026-06-15');

SELECT * FROM Bills;

SELECT COUNT(*) AS Total_Bills
FROM Bills;

SELECT SUM(amount) AS Total_Revenue
FROM Bills;

SELECT COUNT(*) AS Total_Patients
FROM Patients;

SELECT AVG(age) AS Average_Age
FROM Patients;

SELECT MAX(amount) AS Highest_Bill
FROM Bills;

SELECT MIN(amount) AS Lowest_Bill
FROM Bills;

SELECT *
FROM Patients
WHERE city = 'Mumbai';

SELECT *
FROM Bills
WHERE amount > 6000;

SELECT *
FROM Doctors
ORDER BY experience_years DESC;

SELECT patient_name, city
FROM Patients
WHERE gender = 'Female';

SELECT
    p.patient_name,
    d.doctor_name
FROM Patients p
INNER JOIN Appointments a
    ON p.patient_id = a.patient_id
INNER JOIN Doctors d
    ON a.doctor_id = d.doctor_id;
    
    SELECT
    p.patient_name,
    d.doctor_name,
    d.specialization
FROM Patients p
INNER JOIN Appointments a
    ON p.patient_id = a.patient_id
INNER JOIN Doctors d
    ON a.doctor_id = d.doctor_id;
    
    SELECT
    a.appointment_id,
    p.patient_name,
    d.doctor_name,
    a.appointment_date
FROM Appointments a
INNER JOIN Patients p
    ON a.patient_id = p.patient_id
INNER JOIN Doctors d
    ON a.doctor_id = d.doctor_id;
    
    SELECT
    p.patient_name,
    d.doctor_name,
    d.specialization,
    a.appointment_date
FROM Patients p
INNER JOIN Appointments a
    ON p.patient_id = a.patient_id
INNER JOIN Doctors d
    ON a.doctor_id = d.doctor_id
ORDER BY a.appointment_date;

SELECT
    p.patient_name,
    d.specialization
FROM Patients p
INNER JOIN Appointments a
    ON p.patient_id = a.patient_id
INNER JOIN Doctors d
    ON a.doctor_id = d.doctor_id
WHERE d.specialization = 'Cardiology';

SELECT
    doctor_id,
    COUNT(*) AS total_appointments
FROM Appointments
GROUP BY doctor_id;

SELECT
    d.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
JOIN Appointments a
    ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name;

SELECT
    doctor_id,
    COUNT(*) AS total_appointments
FROM Appointments
GROUP BY doctor_id
HAVING COUNT(*) > 2;

SELECT
    SUM(amount) AS total_revenue
FROM Bills;

SELECT
    AVG(amount) AS average_bill
FROM Bills;

SELECT
    patient_id,
    SUM(amount) AS total_bill
FROM Bills
GROUP BY patient_id;

SELECT
    patient_id,
    SUM(amount) AS total_bill
FROM Bills
GROUP BY patient_id
ORDER BY total_bill DESC
LIMIT 1;

SELECT
    p.patient_name,
    SUM(b.amount) AS total_bill
FROM Patients p
JOIN Bills b
    ON p.patient_id = b.patient_id
GROUP BY p.patient_name
ORDER BY total_bill DESC;

SELECT *
FROM Bills
WHERE amount >
(
    SELECT AVG(amount)
    FROM Bills
);

SELECT patient_name
FROM Patients
WHERE patient_id IN
(
    SELECT patient_id
    FROM Bills
    WHERE amount >
    (
        SELECT AVG(amount)
        FROM Bills
    )
);

SELECT doctor_id,
       COUNT(*) AS total_appointments
FROM Appointments
GROUP BY doctor_id
HAVING COUNT(*) =
(
    SELECT MAX(total_count)
    FROM
    (
        SELECT COUNT(*) AS total_count
        FROM Appointments
        GROUP BY doctor_id
    ) AS temp
);

CREATE VIEW Patient_Bill_Report AS
SELECT
    p.patient_name,
    b.amount,
    b.bill_date
FROM Patients p
JOIN Bills b
ON p.patient_id = b.patient_id;

SELECT * FROM Patient_Bill_Report;


SHOW TABLES;