# Student Result Portal Database Design ER Diagram

erDiagram
    direction LR
    
    %% Entity definitions with exact types and key markings
    department {
        bigint department_id PK
        varchar_100 department_name UK
    }
    
    student {
        bigint student_id PK
        varchar_100 student_name
        bigint department_id FK
        varchar_20 tuition_status
    }
    
    course {
        bigint course_id PK
        varchar_20 course_code UK
        varchar_150 course_name
        bigint prerequisite_course_id FK
    }
    
    lecturer {
        bigint lecturer_id PK
        varchar_100 lecturer_name
        varchar_254 email UK
    }
    
    enrollment {
        bigint enrollment_id PK
        bigint student_id FK
        bigint course_id FK
        bigint lecturer_id FK
        numeric_4_2 numerical_grade
        varchar_2 letter_grade
        timestamptz submission_deadline
    }

    %% Relationship definitions with exact cardinalities
    %% and labels as specified
    
    department ||--o{ student : "contains"
    course |o--o{ course : "requires_prerequisite"
    student ||--o{ enrollment : "registers_in"
    course ||--o{ enrollment : "receives"
    lecturer ||--o{ enrollment : "teaches"

## Understanding the Diagram

- PK (Primary Key) uniquely identifies each record in a table, while FK (Foreign Key) links one table to another. UK (Unique Key) ensures that a value is unique.
- Relationship symbols : || means exactly one, |o means zero or one, and o{ means zero or many.
- A department can have zero or multiple students. Each student belongs to one department.
- A course can have zero or one prerequisite course. A course can be a prerequisite for zero or multiple courses.
- A student can have zero or multiple course enrollments. Each enrollment belongs to one student.
- A course can have zero or multiple enrollments over time. Each enrollment refers to one course.
- A lecturer can teach zero or multiple course enrollments. Each enrollment has one primary lecturer.
- All fields are required except prerequisite_course_id, numerical_grade, and letter_grade.