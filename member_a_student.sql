CREATE DATABASE IF NOT EXISTS alu_db;
USE alu_db;

CREATE TABLE Students (
    student_id      INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    classroom_id    INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

INSERT INTO Students (name, email, classroom_id, enrollment_date) VALUES
('Kevin Niyonzima',  'k.niyonzima@alustudent.com', 1, '2025-09-01'),
('Aisha Bello',      'a.bello@alustudent.com',     1, '2025-09-01'),
('Thierry Habimana', 't.habimana@alustudent.com',  2, '2025-09-02'),
('Naledi Dlamini',   'n.dlamini@alustudent.com',   3, '2025-09-03'),
('Chinedu Eze',      'c.eze@alustudent.com',       4, '2025-09-05'),
('Fatou Diallo',     'f.diallo@alustudent.com',    5, '2025-09-05');

UPDATE Students SET classroom_id = 2 WHERE student_id = 1;
 
DELETE FROM Student_Courses    WHERE student_id = 6;
DELETE FROM Student_Activities WHERE student_id = 6;
DELETE FROM Students           WHERE student_id = 6;
 
SELECT name, email, enrollment_date
FROM Students
WHERE enrollment_date >= '2025-09-02';
