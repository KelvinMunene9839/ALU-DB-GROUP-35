cat > member_b_classroom.sql << 'EOF'
-- Member B — Classroom Table

CREATE TABLE Classroom (
    classroom_id    INT AUTO_INCREMENT PRIMARY KEY,
    room_number     VARCHAR(10)     NOT NULL,
    building        VARCHAR(50)     NOT NULL,
    capacity        INT             NOT NULL,
    room_type       VARCHAR(30)     NOT NULL
);

INSERT INTO Classroom (room_number, building, capacity, room_type) VALUES
('101', 'Main Hall', 40, 'Standard'),
('102', 'Main Hall', 30, 'Standard'),
('201', 'Science Wing', 25, 'Lab'),
('202', 'Science Wing', 20, 'Lab'),
('310', 'Auditorium Block', 120, 'Lecture Hall');

-- Member B: UPDATE
UPDATE Classroom
SET capacity = 45
WHERE room_number = '101' AND building = 'Main Hall';

-- Member B: DELETE
DELETE FROM Classroom
WHERE room_number = '202' AND building = 'Science Wing';

-- Member B: SELECT
SELECT * FROM Classroom;
EOF
