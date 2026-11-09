
# Student Result Portal Normalisation

Normalisation splits information into related tables to reduce repeated details and prevent inconsistent updates. The same two student records are used below. Only the fields needed to explain the changes are shown; 

## Enrollment list

| student_id | student_name | department_name | enrollment |
| :--- | :--- | :--- | :--- |
| 1 | Rhoda Atanda | Computer Science | CS101: Intro to Programming, Dr. Alani, Grade: 85; CS102: Data Structures, Professor Grace, Grade: 90 |
| 2 | James Bede | Mathematics | MATH101: Calculus I, Dr. Alani, Grade: 78 |

The first row contains two course enrollments packed into a single cell. Finding an individual course or updating a single grade is difficult because Rhoda's record has multiple courses together.

## 1NF: Each cell contains a single value

Each course enrollment gets its own row. 

| student_id | student_name | department_name | course_code | course_name | lecturer_name | numerical_grade | 
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | 
| 1 | Rhoda Atanda | Computer Science | CS101 | Intro to Programming | Dr. Alani | 85 | 
| 1 | Rhoda Atanda | Computer Science | CS102 | Data Structures | Professor Grace | 90 | 
| 2 | James Bede | Mathematics | MATH101 | Calculus I | Dr. Alani | 78 | 

For this example, the key is (student_id, course_code). Both values together identify one enrollment, assuming a student cannot enroll in the same course twice simultaneously. student_id alone is not enough: student 1 appears twice.

The rows are in 1NF, but student details (name and department) and course details (name and lecturer) are repeated across multiple rows.

## 2NF: Every non-key field depends on the entire key.

A table must first satisfy 1NF. In addition, every non-key field must depend on the  primary key, not just part of a composite key.

Here, student_id alone determines student_name and department_name. Likewise, course_code alone determines course_name and lecturer_name. Those details belong to the student or course respectively, regardless of the other part of the key. They move into separate tables.

Student details
Key: student_id.

| student_id | student_name | department_name |
| :--- | :--- | :--- |
| 1 | Rhoda Atanda | Computer Science |
| 2 | James Bede | Mathematics |

Course details
Key: course_code.

| course_code | course_name | lecturer_name |
| :--- | :--- | :--- |
| CS101 | Intro to Programming | Dr. Alani |
| CS102 | Data Structures | Professor Grace |
| MATH101 | Calculus I | Dr. Alani |

Enrollment details
Key: (student_id, course_code). student_id and course_code link to their respective details.

| student_id | course_code | numerical_grade |
| :--- | :--- | :--- | 
| 1 | CS101 | 85 | 
| 1 | CS102 | 90 | 
| 2 | MATH101 | 78 |

Student and course details no longer repeat for every enrollment. However, department names still repeat across students, and lecturer names still repeat across courses.

## 3NF: Store each detail with the entity it describes

A table must first satisfy 2NF. Also, non-key fields should depend only on the primary key, not on other non-key fields. This helps avoid data duplication and keeps related information  organised. Two remaining links explain the next split:

department_name describes the department, not just the student row.

lecturer_name describes the lecturer, not just the course row.

Department
Key: department_id.

| department_id | department_name |
| :--- | :--- |
| 1 | Computer Science |
| 2 | Mathematics |

Student
Key: student_id. department_id is a foreign key to department.

| student_id | department_id | student_name |
| :--- | :--- | :--- |
| 1 | 1 | Rhoda Atanda |
| 2 | 2 | James Bede |

Lecturer
Key: lecturer_id.

| lecturer_id | lecturer_name | email |
| :--- | :--- | :--- |
| 1 | Dr. Alani | alani@uni.edu |
| 2 | Professor Grace | grace@uni.edu |

Course
Key: course_id. lecturer_id links each course to its assigned lecturer, while prerequisite_course_id links a course to its prerequisite.

| course_id | course_code | course_name | prerequisite_course_id | lecturer_id |
| :--- | :--- | :--- | :--- | :--- |
| 10 | CS101 | Intro to Programming | NULL | 1 |
| 11 | CS102 | Data Structures | 10 | 2 |
| 12 | MATH101 | Calculus I | NULL | 1 |

Enrollment

The final design uses enrollment_id as its primary key, rather than relying on composite student and course codes to identify a single registration record. student_id, course_id, and lecturer_id are foreign keys. Adding an ID is a design choice, not what makes a table 3NF.

| enrollment_id | student_id | course_id | lecturer_id | numerical_grade |
| :--- | :--- | :--- | :--- | :--- |
| 501 | 1 | 10 | 1 | 85 |
| 502 | 1 | 11 | 2 | 90 |
| 503 | 2 | 12 | 1 | 78 |

Now department names and lecturer emails are stored once in their respective lookup tables. The IDs preserve the links, so the complete academic record can still be brought together when queried.

These are the five tables in the ER diagram. The complete schema also includes tuition_status, letter_grade, and submission_deadline. Unique keys, grade range checks, prerequisite validation, and tuition clearance rules remain necessary; normalisation does not enforce those operational business rules by itself.

