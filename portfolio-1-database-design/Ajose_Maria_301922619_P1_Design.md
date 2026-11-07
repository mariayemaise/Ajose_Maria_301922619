# Student Result Portal Database Design

## Entities
The database has five entities for academic tracking

 | ENTITY | DATA STORED |
| :--- | :--- |
| Student | Student profiles and registration details. |
| Department | Academic departments within the university. |
| Course | Course records |
| Lecturer | Lecturer's details. |
| Enrollment | Record of a student's enrollment in a course, including grades and lecturer assignment |

## Attributes and keys
Each record has an automatically generated ID.  unique means no duplicate values. Required means the value cannot be NULL or can not be missing.

| entity | Attributes and proposed PostgreSQL types | Keys and required values |
| :--- | :--- | :--- |
| student | student_id BIGINT; student_name VARCHAR(100); department_id BIGINT; tuition_status VARCHAR(20) | PK: student_id. FK: department_id → department.department_id. All required. |
| department | department_id BIGINT; department_name VARCHAR(100) | PK: department_id. Unique: department_name. All required. |
| course | course_id BIGINT; course_code VARCHAR(20); course_name VARCHAR(150); prerequisite_course_id BIGINT | PK: course_id. FK: prerequisite_course_id → course.course_id. Unique: course_code. All required except prerequisite_course_id. |
| lecturer | lecturer_id BIGINT; lecturer_name VARCHAR(100); email VARCHAR(254) | PK: lecturer_id. Unique: email. All required. |
| enrollment | enrollment_id BIGINT; student_id BIGINT; course_id BIGINT; lecturer_id BIGINT; numerical_grade NUMERIC(4,2); letter_grade VARCHAR(2); submission_deadline TIMESTAMPTZ | PK: enrollment_id. FKs: student_id → student.student_id, course_id → course.course_id, lecturer_id → lecturer.lecturer_id. All required except numerical_grade and letter_grade. |

## Relationships

| Tables linked | Relationship | Meaning |
| :--- | :--- | :--- |
| department → student | One to many | A department can have zero or more students; each student belongs to exactly one department. |
| course → course (prerequisite) | Self-referencing (zero or one) | A course can require zero or one prerequisite course; a course can be a prerequisite for zero or many courses. |
| student → enrollment | One to many | A student can have zero or more course enrollments; each enrollment belongs to exactly one student. |
| course → enrollment | One to many | A course can have zero or many enrollments over time; each enrollment refers to exactly one course. |
| lecturer → enrollment | One to many | A lecturer can teach many course enrollments; each enrollment has exactly one primary lecturer. |

## Business rules and constraints

Rules 1 and 2: Student IDs, departments, and primary lecturer assignments are enforced through primary and required foreign keys.

Rule 4: The numeric grade must be between 0 and 100 and enforced by database check constraint (CHECK (numerical_grade BETWEEN 0 AND 100)).

Rule 5: Letter grades are  restricted to  A, B, C, D, E, and F (CHECK (letter_grade IN ('A', 'B', 'C', 'D', 'E', 'F'))).

Rule 6: No student may be registered in a course if any of the prerequisites have not been completed with a good grade. This rule requires database triggers.

Rule 7: Assessment marks cannot be  updated after the official grade submission deadline and it is enforced by comparing the transaction date against the submission_deadline timestamp.

Rule 8: Students with outstanding tuition balances (tuition_status) can not view uploaded results or request for transcripts.
