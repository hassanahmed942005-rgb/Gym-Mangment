
CREATE DATABASE GYMF;
USE GYMF;
CREATE TABLE Members( 
    member_id INT PRIMARY KEY IDENTITY(1,1),
    member_name VARCHAR(100), 
    age INT, 
    gender VARCHAR(10), 
    membership_type VARCHAR(50),
    is_active TINYINT
);

CREATE TABLE Trainers (
    trainer_id INT PRIMARY KEY IDENTITY(1,1),
    trainer_name VARCHAR(100)
);

CREATE TABLE Classes (
    class_id INT PRIMARY KEY IDENTITY(1,1),
    class_name VARCHAR(100),
    trainer_id INT,
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id)
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY IDENTITY(1,1),
    member_id INT,
    class_id INT,
    schedule_time DATETIME,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    member_id INT,
    amount DECIMAL(10,2),
    payment_date DATETIME,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);



INSERT INTO Members (member_name, age, gender, membership_type, is_active) VALUES
('Ahmed Ali', 25, 'Male', 'Monthly', 1),
('Sara Mohamed', 30, 'Female', 'Annual', 1),
('Omar Khaled', 22, 'Male', 'Quarterly', 0),
('Nour Hany', 28, 'Female', 'Monthly', 1),
('Hassan Adel', 35, 'Male', 'Annual', 1),
('Mai Tarek', 26, 'Female', 'Monthly', 1),
('Khaled Samir', 40, 'Male', 'Annual', 1),
('Fatma Hussein', 27, 'Female', 'Quarterly', 0),
('Mohamed Salah', 29, 'Male', 'Monthly', 1),
('Laila Omar', 31, 'Female', 'Annual', 1),
('Youssef Karim', 24, 'Male', 'Monthly', 1),
('Dina Ahmed', 33, 'Female', 'Quarterly', 1),
('Tamer Saad', 36, 'Male', 'Annual', 0),
('Hoda Nabil', 29, 'Female', 'Monthly', 1),
('Adel Fathy', 34, 'Male', 'Annual', 1),
('Salma Adel', 23, 'Female', 'Quarterly', 1),
('Mostafa Zaki', 38, 'Male', 'Monthly', 1),
('Aya Essam', 21, 'Female', 'Monthly', 0),
('Karim Hossam', 32, 'Male', 'Annual', 1),
('Rana Khaled', 27, 'Female', 'Quarterly', 1);

INSERT INTO Trainers (trainer_name) VALUES
('Coach Ali'),
('Coach Mona'),
('Coach Youssef'),
('Coach Samir'),
('Coach Aya');

INSERT INTO Classes (class_name, trainer_id) VALUES
('Yoga', 2),
('CrossFit', 1),
('Zumba', 3),
('Pilates', 4),
('Boxing', 5),
('Spinning', 1);

INSERT INTO Attendance (member_id, class_id, schedule_time) VALUES
(1, 2, '2025-01-05 18:00:00'),
(2, 1, '2025-01-06 19:00:00'),
(3, 3, '2025-01-07 20:00:00'),
(4, 1, '2025-02-01 18:00:00'),
(5, 2, '2025-02-02 17:00:00'),
(6, 4, '2025-02-05 18:00:00'),
(7, 5, '2025-02-06 19:00:00'),
(8, 6, '2025-02-07 20:00:00'),
(9, 2, '2025-02-08 18:00:00'),
(10, 3, '2025-02-09 17:00:00'),
(11, 1, '2025-02-10 18:00:00'),
(12, 4, '2025-02-11 19:00:00'),
(13, 5, '2025-02-12 20:00:00'),
(14, 6, '2025-02-13 18:00:00'),
(15, 2, '2025-02-14 17:00:00'),
(16, 3, '2025-02-15 18:00:00'),
(17, 1, '2025-02-16 19:00:00'),
(18, 4, '2025-02-17 20:00:00'),
(19, 5, '2025-02-18 18:00:00'),
(20, 6, '2025-02-19 17:00:00');

INSERT INTO Payments (member_id, amount, payment_date) VALUES
(1, 500.00, '2025-01-01'),
(2, 5000.00, '2025-01-02'),
(3, 1200.00, '2025-01-03'),
(4, 500.00, '2025-02-01'),
(5, 5000.00, '2025-02-01'),
(6, 600.00, '2025-02-05'),
(7, 5500.00, '2025-02-06'),
(8, 1500.00, '2025-02-07'),
(9, 500.00, '2025-02-08'),
(10, 5200.00, '2025-02-09'),
(11, 700.00, '2025-02-10'),
(12, 1300.00, '2025-02-11'),
(13, 4800.00, '2025-02-12'),
(14, 400.00, '2025-02-13'),
(15, 4900.00, '2025-02-14'),
(16, 1500.00, '2025-02-15'),
(17, 550.00, '2025-02-16'),
(18, 600.00, '2025-02-17'),
(19, 5700.00, '2025-02-18'),
(20, 1200.00, '2025-02-19');


-- 1. Total monthly revenue
SELECT FORMAT(payment_date, 'yyyy-MM') AS month,
       SUM(amount) AS total_revenue
FROM Payments
GROUP BY FORMAT(payment_date, 'yyyy-MM')
ORDER BY month;

-- 2. Active vs inactive members
SELECT is_active, COUNT(member_id) AS total_members
FROM Members
GROUP BY is_active;

-- 3. Distribution of members by membership type
SELECT membership_type, COUNT(member_id) AS members_count
FROM Members
GROUP BY membership_type;

-- 4. Average age by membership type
SELECT membership_type, AVG(age) AS avg_age
FROM Members
GROUP BY membership_type;

-- 5. Members distribution by gender
SELECT gender, COUNT(member_id) AS total_members
FROM Members
GROUP BY gender;

-- 6. Top 5 trainers by attendance
SELECT TOP 5 t.trainer_name, COUNT(a.attendance_id) AS total_attendance
FROM Attendance a
JOIN Classes c ON a.class_id = c.class_id
JOIN Trainers t ON c.trainer_id = t.trainer_id
GROUP BY t.trainer_name
ORDER BY total_attendance DESC;

-- 7. Attendance by weekday
SELECT DATENAME(WEEKDAY, schedule_time) AS weekday,
       COUNT(attendance_id) AS total_attendance
FROM Attendance
GROUP BY DATENAME(WEEKDAY, schedule_time)
ORDER BY 
    CASE DATENAME(WEEKDAY, schedule_time)
        WHEN 'Sunday' THEN 1
        WHEN 'Monday' THEN 2
        WHEN 'Tuesday' THEN 3
        WHEN 'Wednesday' THEN 4
        WHEN 'Thursday' THEN 5
        WHEN 'Friday' THEN 6
        WHEN 'Saturday' THEN 7
    END;

-- 8. Most popular classes
SELECT c.class_name, COUNT(a.attendance_id) AS total_attendance
FROM Attendance a
JOIN Classes c ON a.class_id = c.class_id
GROUP BY c.class_name
ORDER BY total_attendance DESC;

-- 9. Average payment per member
SELECT m.member_id, m.member_name, AVG(p.amount) AS avg_payment
FROM Payments p
JOIN Members m ON p.member_id = m.member_id
GROUP BY m.member_id, m.member_name
ORDER BY avg_payment DESC;

-- 10. Revenue by membership type
SELECT m.membership_type, SUM(p.amount) AS total_revenue
FROM Payments p
JOIN Members m ON p.member_id = m.member_id
GROUP BY m.membership_type
ORDER BY total_revenue DESC;
