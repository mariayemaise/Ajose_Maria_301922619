
-- SampleData.sql
-- Contains a small valid dataset to populate the Student Result Portal.

BEGIN;

-- 1. Populate Department Table
INSERT INTO public.department (department_name) VALUES
('Computer Science'),
('Mathematics');

-- 2. Populate Student Table
INSERT INTO public.student (student_name, department_id, tuition_status) VALUES
(
    'Rhoda Atanda',
    (SELECT department_id FROM public.department
     WHERE department_name = 'Computer Science'),
    'Paid'
),
(
    'James Bede',
    (SELECT department_id FROM public.department
     WHERE department_name = 'Mathematics'),
    'Pending'
);

-- 3. Populate Lecturer Table
INSERT INTO public.lecturer (lecturer_name, email) VALUES
('Dr. Alani', 'alani@example.com'),
('Professor Grace', 'grace@example.com');

-- 4. Populate Course Table
-- Insert courses without prerequisites first.
INSERT INTO public.course (course_code, course_name, prerequisite_course_id) VALUES
('CS101', 'Intro to Programming', NULL),
('MATH101', 'Calculus I', NULL);

-- Insert course with a prerequisite.
INSERT INTO public.course (course_code, course_name, prerequisite_course_id) VALUES
(
    'CS102',
    'Data Structures',
    (SELECT course_id FROM public.course
     WHERE course_code = 'CS101')
);

-- 5. Populate Enrollment Table
-- Demonstrates graded and pending student results.
INSERT INTO public.enrollment
(student_id, course_id, lecturer_id, numerical_grade,
 letter_grade, submission_deadline)
VALUES
(
    (SELECT student_id FROM public.student
     WHERE student_name = 'Rhoda Atanda'),
    (SELECT course_id FROM public.course
     WHERE course_code = 'CS101'),
    (SELECT lecturer_id FROM public.lecturer
     WHERE email = 'alani@example.com'),
    85.00,
    'A',
    '2026-12-01 23:59:59+00'
),
(
    (SELECT student_id FROM public.student
     WHERE student_name = 'Rhoda Atanda'),
    (SELECT course_id FROM public.course
     WHERE course_code = 'CS102'),
    (SELECT lecturer_id FROM public.lecturer
     WHERE email = 'grace@example.com'),
    90.00,
    'A',
    '2026-12-01 23:59:59+00'
),
(
    (SELECT student_id FROM public.student
     WHERE student_name = 'James Bede'),
    (SELECT course_id FROM public.course
     WHERE course_code = 'MATH101'),
    (SELECT lecturer_id FROM public.lecturer
     WHERE email = 'alani@example.com'),
    NULL,
    NULL,
    '2026-12-15 23:59:59+00'
);

COMMIT;
