# ALU Database — Group Project

A relational database for a school system, built in **MySQL** as a team assignment. The database models five entities — Students, Classroom, Faculty, Courses, and Extra_Curricular_Activities — plus two junction tables that handle the many-to-many relationships between students and their courses/activities.

## Repository contents

| File | Description |
|------|-------------|
| `alu_db.sql` | The single shared SQL script: database creation, all tables, sample data, individual DML statements, join queries, aggregate query, and our normalization write-up (as comments). |
| `README.md` | This file. |

## Team & ownership

| Member | Owns |
|--------|------|
| Liliose Gashugi | `Students` table |
| Fabrice Ishimwe | `Classroom` table |
| Keza Lysley | `Faculty` table |
| Landry Rwema | `Courses` table |
| Kelvin Nyagah | `Extra_Curricular_Activities` + junction tables (`Student_Courses`, `Student_Activities`) |

Each member committed their own section of `alu_db.sql` directly, so individual contributions are visible in the commit history.

## Schema overview

```
Classroom ──< Students
Classroom ──< Courses >── Faculty
Faculty  ──< Extra_Curricular_Activities

Students >──< Courses                        (via Student_Courses)
Students >──< Extra_Curricular_Activities    (via Student_Activities)
```

- **One-to-many:** a classroom holds many students; a faculty member teaches many courses and advises many activities; a classroom hosts many courses.
- **Many-to-many:** students ↔ courses and students ↔ activities, resolved with junction tables using composite primary keys (`student_id` + `course_id` / `activity_id`).

All foreign keys reference valid primary keys, and the schema is in third normal form — see the normalization paragraph in the comments of `alu_db.sql`.

## How to run

1. Make sure MySQL is installed and running.
2. From a terminal:

   ```bash
   mysql -u <your_username> -p < alu_db.sql
   ```

   Or from inside the MySQL shell / Workbench:

   ```sql
   SOURCE alu_db.sql;
   ```

3. The script creates the database `alu_db`, builds all seven tables **in dependency order** (Classroom and Faculty first, then Students, Courses, Activities, and the junction tables), inserts sample data, and runs every required query. It executes cleanly top to bottom with no foreign-key errors.

## What the script demonstrates

- **DDL:** `CREATE DATABASE`, `CREATE TABLE` with appropriate data types, primary keys, and foreign key constraints.
- **DML:** `INSERT` (5+ rows per table), plus one `UPDATE`, one `DELETE`, and one `SELECT ... WHERE` per member, labeled by name in comments.
- **Joins:** three multi-table `JOIN` queries that output full sentences, e.g. *"Kevin Niyonzima is enrolled in Introduction to Databases, taught by Dr. Amina Uwase, in room A101 (Innovation Hall)."*
- **Aggregation:** a `COUNT()` + `GROUP BY` query showing how many students are enrolled in each course (using `LEFT JOIN` so empty courses still appear).
- **Normalization:** a short written analysis included as a comment block at the end of the SQL file.
