-- Member E (Kelvin) — Extra_Curricular_Activities + Junction Tables
-- Depends on: Students, Courses, Faculty 

CREATE TABLE Extra_Curricular_Activities (
    activity_id   INT AUTO_INCREMENT PRIMARY KEY,
    activity_name VARCHAR(100) NOT NULL,
    category      VARCHAR(50)  NOT NULL,
    schedule_day  VARCHAR(20)  NOT NULL,
    faculty_id    INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);

INSERT INTO Extra_Curricular_Activities (activity_name, category, schedule_day, faculty_id) VALUES
('Basketball Club',       'Sports',     'Monday',    4),
('Debate Society',        'Academic',   'Tuesday',   5),
('Coding Club',           'Technology', 'Wednesday', 1),
('Drama Society',         'Arts',       'Thursday',  5),
('Entrepreneurship Club', 'Business',   'Friday',    3);

-- Member E: UPDATE
UPDATE Extra_Curricular_Activities
SET schedule_day = 'Saturday'
WHERE activity_name = 'Basketball Club';

-- Member E: DELETE
INSERT INTO Extra_Curricular_Activities (activity_name, category, schedule_day, faculty_id)
VALUES ('Temporary Chess Club', 'Academic', 'Sunday', 2);
DELETE FROM Extra_Curricular_Activities WHERE activity_name = 'Temporary Chess Club';

-- Member E: SELECT
SELECT activity_name, category, schedule_day
FROM Extra_Curricular_Activities
WHERE category = 'Academic';


-- Junction Table 1: Student_Courses (many-to-many: Students <-> Courses)
CREATE TABLE Student_Courses (
    student_id      INT  NOT NULL,
    course_id       INT  NOT NULL,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id)  REFERENCES Courses(course_id)
);

INSERT INTO Student_Courses (student_id, course_id, enrollment_date) VALUES
(1, 1, '2025-09-10'),
(1, 2, '2025-09-10'),
(2, 1, '2025-09-10'),
(3, 3, '2025-09-11'),
(4, 2, '2025-09-11'),
(6, 4, '2025-09-12');

-- Member E: UPDATE
UPDATE Student_Courses
SET enrollment_date = '2025-09-15'
WHERE student_id = 1 AND course_id = 2;

-- Member E: DELETE
DELETE FROM Student_Courses WHERE student_id = 6 AND course_id = 4;

-- Member E: SELECT
SELECT * FROM Student_Courses WHERE student_id = 1;


-- Junction Table 2: Student_Activities (many-to-many: Students <-> Extra_Curricular_Activities)
CREATE TABLE Student_Activities (
    student_id  INT  NOT NULL,
    activity_id INT  NOT NULL,
    join_date   DATE NOT NULL,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id)  REFERENCES Students(student_id),
    FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id)
);

INSERT INTO Student_Activities (student_id, activity_id, join_date) VALUES
(1, 1, '2025-09-12'),
(2, 3, '2025-09-12'),
(3, 2, '2025-09-13'),
(4, 4, '2025-09-13'),
(6, 5, '2025-09-14');

-- Member E: UPDATE
UPDATE Student_Activities
SET join_date = '2025-09-20'
WHERE student_id = 2 AND activity_id = 3;

-- Member E: DELETE
DELETE FROM Student_Activities WHERE student_id = 6 AND activity_id = 5;

-- Member E: SELECT
SELECT * FROM Student_Activities WHERE student_id = 4;
