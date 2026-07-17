-- ============================================================
-- ALU_DATABASE — Group Assignment (MySQL)
-- Shared SQL file: schema, sample data, individual tasks,
-- group join/aggregate queries, normalization paragraph.
-- ============================================================

-- ------------------------------------------------------------
-- 1. CREATE DATABASE
-- ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS alu_db;
USE alu_db;

-- ------------------------------------------------------------
-- 2. CREATE TABLE statements (in dependency order)
-- ------------------------------------------------------------

-- Fabrice Ishimwe: Classroom (no dependencies)
CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number  VARCHAR(10)  NOT NULL,
    building     VARCHAR(50)  NOT NULL,
    capacity     INT          NOT NULL
);

-- Keza Lysley: Faculty (no dependencies)
CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50)  NOT NULL
);

-- Liliose Gashugi: Students (depends on Classroom)
CREATE TABLE Students (
    student_id      INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    classroom_id    INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

-- Landry Rwema: Courses (depends on Faculty and Classroom)
CREATE TABLE Courses (
    course_id    INT PRIMARY KEY AUTO_INCREMENT,
    course_name  VARCHAR(100) NOT NULL,
    credits      INT          NOT NULL,
    faculty_id   INT,
    classroom_id INT,
    FOREIGN KEY (faculty_id)   REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

-- Kelvin Nyagah: Extra_Curricular_Activities (depends on Faculty)
CREATE TABLE Extra_Curricular_Activities (
    activity_id        INT PRIMARY KEY AUTO_INCREMENT,
    activity_name      VARCHAR(100) NOT NULL,
    category           VARCHAR(50)  NOT NULL,
    faculty_advisor_id INT,
    FOREIGN KEY (faculty_advisor_id) REFERENCES Faculty(faculty_id)
);

-- Kelvin Nyagah: Junction table — Students <-> Courses (many-to-many)
CREATE TABLE Student_Courses (
    student_id INT NOT NULL,
    course_id  INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id)  REFERENCES Courses(course_id)
);

-- Kelvin Nyagah: Junction table — Students <-> Activities (many-to-many)
CREATE TABLE Student_Activities (
    student_id  INT NOT NULL,
    activity_id INT NOT NULL,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id)  REFERENCES Students(student_id),
    FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id)
);

-- ------------------------------------------------------------
-- 3. INSERT statements
-- ------------------------------------------------------------

-- Fabrice Ishimwe: Classroom sample rows
INSERT INTO Classroom (room_number, building, capacity) VALUES
('A101', 'Innovation Hall', 40),
('A102', 'Innovation Hall', 35),
('B201', 'Leadership Wing', 60),
('B202', 'Leadership Wing', 25),
('C301', 'Science Block',   50);

-- Keza Lysley: Faculty sample rows
INSERT INTO Faculty (name, email, department) VALUES
('Dr. Amina Uwase',    'a.uwase@alu.edu',    'Computer Science'),
('Mr. David Okoro',    'd.okoro@alu.edu',    'Mathematics'),
('Ms. Grace Mutesi',   'g.mutesi@alu.edu',   'Business'),
('Dr. Samuel Kagabo',  's.kagabo@alu.edu',   'Engineering'),
('Mrs. Linda Achieng', 'l.achieng@alu.edu',  'Humanities');

-- Liliose Gashugi: Students sample rows
INSERT INTO Students (name, email, classroom_id, enrollment_date) VALUES
('Kevin Niyonzima',  'k.niyonzima@alustudent.com', 1, '2025-09-01'),
('Aisha Bello',      'a.bello@alustudent.com',     1, '2025-09-01'),
('Thierry Habimana', 't.habimana@alustudent.com',  2, '2025-09-02'),
('Naledi Dlamini',   'n.dlamini@alustudent.com',   3, '2025-09-03'),
('Chinedu Eze',      'c.eze@alustudent.com',       4, '2025-09-05'),
('Fatou Diallo',     'f.diallo@alustudent.com',    5, '2025-09-05');

-- Landry Rwema: Courses sample rows
INSERT INTO Courses (course_name, credits, faculty_id, classroom_id) VALUES
('Introduction to Databases',      3, 1, 1),
('Calculus I',                     4, 2, 3),
('Entrepreneurial Leadership',     3, 3, 2),
('Engineering Fundamentals',       4, 4, 5),
('Academic Writing',               2, 5, 4);

-- Kelvin Nyagah: Extra_Curricular_Activities sample rows
INSERT INTO Extra_Curricular_Activities (activity_name, category, faculty_advisor_id) VALUES
('Coding Club',        'Technology', 1),
('Debate Society',     'Academic',   5),
('Football Team',      'Sports',     4),
('Entrepreneurs Hub',  'Business',   3),
('Chess Club',         'Games',      2);

-- Kelvin Nyagah: Student_Courses sample rows (enrollments)
INSERT INTO Student_Courses (student_id, course_id) VALUES
(1, 1), (1, 2),
(2, 1), (2, 3),
(3, 2), (3, 4),
(4, 3),
(5, 4), (5, 5),
(6, 1), (6, 5);

-- Kelvin Nyagah: Student_Activities sample rows (participation)
INSERT INTO Student_Activities (student_id, activity_id) VALUES
(1, 1), (1, 3),
(2, 2),
(3, 1),
(4, 4),
(5, 3), (5, 5),
(6, 2);

-- ------------------------------------------------------------
-- 4. Individual UPDATE / DELETE / SELECT statements
-- ------------------------------------------------------------

-- ===== Liliose Gashugi (Students) =====
-- UPDATE: Kevin moves to a different classroom
UPDATE Students SET classroom_id = 2 WHERE student_id = 1;

-- DELETE: remove a student who withdrew
-- (student 6 has junction rows; remove those first to satisfy FKs)
DELETE FROM Student_Courses    WHERE student_id = 6;
DELETE FROM Student_Activities WHERE student_id = 6;
DELETE FROM Students           WHERE student_id = 6;

-- SELECT: students enrolled on or after 2025-09-02
SELECT name, email, enrollment_date
FROM Students
WHERE enrollment_date >= '2025-09-02';

-- ===== Fabrice Ishimwe (Classroom) =====
-- UPDATE: room B202 was expanded
UPDATE Classroom SET capacity = 30 WHERE room_number = 'B202';

-- DELETE: (safe demo) insert then remove an unused room
INSERT INTO Classroom (room_number, building, capacity) VALUES ('D401', 'Annex', 20);
DELETE FROM Classroom WHERE room_number = 'D401';

-- SELECT: classrooms that hold at least 40 people
SELECT room_number, building, capacity
FROM Classroom
WHERE capacity >= 40;

-- ===== Keza Lysley (Faculty) =====
-- UPDATE: Mr. Okoro changes department
UPDATE Faculty SET department = 'Data Science' WHERE faculty_id = 2;

-- DELETE: (safe demo) insert then remove a visiting lecturer
INSERT INTO Faculty (name, email, department) VALUES ('Dr. Guest Lecturer', 'guest@alu.edu', 'Visiting');
DELETE FROM Faculty WHERE email = 'guest@alu.edu';

-- SELECT: all Computer Science faculty
SELECT name, email
FROM Faculty
WHERE department = 'Computer Science';

-- ===== Landry Rwema (Courses) =====
-- UPDATE: Academic Writing becomes a 3-credit course
UPDATE Courses SET credits = 3 WHERE course_name = 'Academic Writing';

-- DELETE: (safe demo) insert then remove a cancelled course
INSERT INTO Courses (course_name, credits, faculty_id, classroom_id) VALUES ('Cancelled Elective', 1, 5, 4);
DELETE FROM Courses WHERE course_name = 'Cancelled Elective';

-- SELECT: courses worth 3 or more credits
SELECT course_name, credits
FROM Courses
WHERE credits >= 3;

-- ===== Kelvin Nyagah (Extra_Curricular_Activities + junctions) =====
-- UPDATE: Chess Club is reclassified
UPDATE Extra_Curricular_Activities SET category = 'Strategy' WHERE activity_name = 'Chess Club';

-- DELETE: a student drops the Football Team
DELETE FROM Student_Activities WHERE student_id = 5 AND activity_id = 3;

-- SELECT: all sports activities
SELECT activity_name, category
FROM Extra_Curricular_Activities
WHERE category = 'Sports';

-- ------------------------------------------------------------
-- Soumaya: Relationship integrity check — confirming no orphaned foreign keys
SELECT s.student_id FROM Students s
LEFT JOIN Classroom c ON s.classroom_id = c.classroom_id
WHERE s.classroom_id IS NOT NULL AND c.classroom_id IS NULL;

SELECT co.course_id FROM Courses co
LEFT JOIN Faculty f ON co.faculty_id = f.faculty_id
WHERE co.faculty_id IS NOT NULL AND f.faculty_id IS NULL;

SELECT sc.student_id, sc.course_id FROM Student_Courses sc
LEFT JOIN Students s ON sc.student_id = s.student_id
LEFT JOIN Courses c ON sc.course_id = c.course_id
WHERE s.student_id IS NULL OR c.course_id IS NULL;
-- empty result sets = no orphans, integrity confirmed
-- ------------------------------------------------------------
-- 5. Group JOIN queries
-- ------------------------------------------------------------

-- JOIN 1: "Student X is enrolled in Course Y, taught by Faculty Z, in Classroom W."
SELECT CONCAT(s.name, ' is enrolled in ', c.course_name,
              ', taught by ', f.name,
              ', in room ', cl.room_number, ' (', cl.building, ').') AS sentence
FROM Student_Courses sc
JOIN Students  s  ON sc.student_id  = s.student_id
JOIN Courses   c  ON sc.course_id   = c.course_id
JOIN Faculty   f  ON c.faculty_id   = f.faculty_id
JOIN Classroom cl ON c.classroom_id = cl.classroom_id;

-- JOIN 2: "Student X participates in Activity Y, advised by Faculty Z."
SELECT CONCAT(s.name, ' participates in ', a.activity_name,
              ', advised by ', f.name, '.') AS sentence
FROM Student_Activities sa
JOIN Students s ON sa.student_id  = s.student_id
JOIN Extra_Curricular_Activities a ON sa.activity_id = a.activity_id
JOIN Faculty  f ON a.faculty_advisor_id = f.faculty_id;

-- JOIN 3 (our choice): "Student X sits in room Y in building Z."
SELECT CONCAT(s.name, ' sits in room ', cl.room_number,
              ' in ', cl.building, '.') AS sentence
FROM Students s
JOIN Classroom cl ON s.classroom_id = cl.classroom_id;

-- ------------------------------------------------------------
-- 6. Group aggregate query
-- ------------------------------------------------------------

-- How many students are enrolled in each course
SELECT c.course_name, COUNT(sc.student_id) AS number_of_students
FROM Courses c
LEFT JOIN Student_Courses sc ON c.course_id = sc.course_id
GROUP BY c.course_id, c.course_name
ORDER BY number_of_students DESC;

-- Soumaya: how many students participate in each activity
SELECT a.activity_name, COUNT(sa.student_id) AS number_of_students
FROM Extra_Curricular_Activities a
LEFT JOIN Student_Activities sa ON a.activity_id = sa.activity_id
GROUP BY a.activity_id, a.activity_name
ORDER BY number_of_students DESC;

-- ------------------------------------------------------------
-- 7. Normalization paragraph (group answer)
-- ------------------------------------------------------------
-- Our schema is in third normal form. No table stores repeating groups or
-- data that belongs to another entity: classroom details (room, building,
-- capacity) live only in Classroom, and Students and Courses reference them
-- by classroom_id instead of duplicating them; likewise faculty details live
-- only in Faculty and are referenced by foreign key from Courses and
-- Extra_Curricular_Activities. The two many-to-many relationships
-- (students-to-courses and students-to-activities) are resolved through the
-- junction tables Student_Courses and Student_Activities, each with a
-- composite primary key (student_id + the other id). This prevents the
-- duplication we would get if we stored course or activity lists inside the
-- Students table, and it means a student can join any number of courses or
-- activities without repeating their personal data. Every non-key column in
-- every table depends only on that table's primary key, so there are no
-- partial or transitive dependencies.
