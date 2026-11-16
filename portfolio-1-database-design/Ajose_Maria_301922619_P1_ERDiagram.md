
# Student Result Portal Database Design ER Diagram

```mermaid
erDiagram

    department {
        BIGINT department_id PK
        VARCHAR(100) department_name UK
    }

    student {
        BIGINT student_id PK
        VARCHAR(100) student_name
        BIGINT department_id FK
        VARCHAR(20) tuition_status
    }

    course {
        BIGINT course_id PK
        VARCHAR(20) course_code UK
        VARCHAR(150) course_name
        BIGINT prerequisite_course_id FK
    }

    lecturer {
        BIGINT lecturer_id PK
        VARCHAR(100) lecturer_name
        VARCHAR(254) email UK
    }

    enrollment {
        BIGINT enrollment_id PK
        BIGINT student_id FK
        BIGINT course_id FK
        BIGINT lecturer_id FK
        NUMERIC(5,2) numerical_grade
        VARCHAR(2) letter_grade
        TIMESTAMPTZ submission_deadline
    }

    department ||--o{ student : contains
    course |o--o{ course : requires_prerequisite
    student ||--o{ enrollment : registers_in
    course ||--o{ enrollment : receives
    lecturer ||--o{ enrollment : teaches
```


## Understanding the Diagram

- PK (Primary Key) uniquely identifies each record in a table, while FK (Foreign Key) links one table to another. UK (Unique Key) ensures that a value is unique.
- Relationship symbols : || means exactly one, |o means zero or one, and o{ means zero or many.
- A department can have zero or multiple students. Each student belongs to one department.
- A course can have zero or one prerequisite course. A course can be a prerequisite for zero or multiple courses.
- A student can have zero or multiple course enrollments. Each enrollment belongs to one student.
- A course can have zero or multiple enrollments over time. Each enrollment refers to one course.
- A lecturer can teach zero or multiple course enrollments. Each enrollment has one primary lecturer.
- All fields are required except prerequisite_course_id, numerical_grade, and letter_grade.
