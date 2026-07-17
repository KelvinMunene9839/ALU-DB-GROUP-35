CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50)  NOT NULL
);

INSERT INTO Faculty (name, email, department) VALUES
('Dr. Amina Uwase',    'a.uwase@alu.edu',    'Computer Science'),
('Mr. David Okoro',    'd.okoro@alu.edu',    'Mathematics'),
('Ms. Grace Mutesi',   'g.mutesi@alu.edu',   'Business'),
('Dr. Samuel Kagabo',  's.kagabo@alu.edu',   'Engineering'),
('Mrs. Linda Achieng', 'l.achieng@alu.edu',  'Humanities');

UPDATE Faculty SET department = 'Data Science' WHERE faculty_id = 2;
 
INSERT INTO Faculty (name, email, department) VALUES ('Dr. Guest Lecturer', 'guest@alu.edu', 'Visiting');
DELETE FROM Faculty WHERE email = 'guest@alu.edu';
 
SELECT name, email
FROM Faculty
WHERE department = 'Computer Science';
