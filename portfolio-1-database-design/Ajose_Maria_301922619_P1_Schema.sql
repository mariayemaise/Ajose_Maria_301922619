
-- Student Result Portal Schema

BEGIN;

-- 1. Department Table
CREATE TABLE public.department (
    department_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Student Table
CREATE TABLE public.student (
    student_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department_id BIGINT NOT NULL
        REFERENCES public.department(department_id),
    tuition_status VARCHAR(20) NOT NULL
        CHECK (tuition_status IN ('Paid', 'Unpaid', 'Pending'))
);

-- 3. Lecturer Table
CREATE TABLE public.lecturer (
    lecturer_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lecturer_name VARCHAR(100) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE
);

-- 4. Course Table
CREATE TABLE public.course (
    course_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(150) NOT NULL,
    prerequisite_course_id BIGINT
        REFERENCES public.course(course_id),
    CHECK (
        prerequisite_course_id IS NULL
        OR prerequisite_course_id <> course_id
    )
);

-- 5. Enrollment Table
CREATE TABLE public.enrollment (
    enrollment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id BIGINT NOT NULL
        REFERENCES public.student(student_id),
    course_id BIGINT NOT NULL
        REFERENCES public.course(course_id),
    lecturer_id BIGINT NOT NULL
        REFERENCES public.lecturer(lecturer_id),
    numerical_grade NUMERIC(5,2)
        CHECK (numerical_grade BETWEEN 0 AND 100),
    letter_grade VARCHAR(2)
        CHECK (letter_grade IN ('A', 'B', 'C', 'D', 'E', 'F')),
    submission_deadline TIMESTAMPTZ NOT NULL

    -- Add UNIQUE (student_id, course_id)
    -- only if course retakes are not permitted.
);

COMMIT;
