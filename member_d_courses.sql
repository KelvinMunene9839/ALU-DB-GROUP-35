-- Member D — Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT,
    faculty_id INT,
    classroom_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

INSERT INTO Courses (course_id, course_name, credits, faculty_id, classroom_id) VALUES
(1, 'Introduction to Databases', 3, 1, 1),
(2, 'Data Structures and Algorithms', 4, 2, 2),
(3, 'Web Development', 3, 1, 3),
(4, 'Computer Networks', 3, 3, 1),
(5, 'Software Engineering', 4, 2, 5);

-- Member D: UPDATE
UPDATE Courses SET credits = 4 WHERE course_id = 1;

-- Member D: DELETE
DELETE FROM Courses WHERE course_id = 5;

-- Member D: SELECT
SELECT * FROM Courses WHERE credits >= 4;
