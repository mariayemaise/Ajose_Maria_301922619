
-- ConstraintTests.sql
-- Tests invalid data entries against the Student Result Portal schema.

-- 1. A department name is required and cannot be missing.
INSERT INTO public.department (department_name)
VALUES (NULL);


-- 2. Computer Science already exists, so its name cannot be used again.
INSERT INTO public.department (department_name)
VALUES ('Computer Science');


-- 3. Department ID 9999 does not exist in this practice database.
INSERT INTO public.student (student_name, department_id, tuition_status)
VALUES ('Unknown Student', 9999, 'Paid');


-- 4. Tuition status must be Paid, Unpaid or Pending.
INSERT INTO public.student (student_name, department_id, tuition_status)
VALUES (
    'Invalid Tuition',
    (SELECT department_id FROM public.department
     WHERE department_name = 'Computer Science'),
    'Waived'
);


-- 5. Dr. Alani's email cannot be used for another lecturer.
INSERT INTO public.lecturer (lecturer_name, email)
VALUES ('Another Lecturer', 'alani@example.com');


-- 6. CS101 already exists, so its course code cannot be reused.
INSERT INTO public.course (course_code, course_name, prerequisite_course_id)
VALUES ('CS101', 'Duplicate Course', NULL);


-- 7. A course cannot be its own prerequisite.
UPDATE public.course
SET prerequisite_course_id = course_id
WHERE course_code = 'CS101';


-- 8. A numerical grade cannot exceed 100.
INSERT INTO public.enrollment
    (student_id, course_id, lecturer_id, numerical_grade,
     letter_grade, submission_deadline)
VALUES (
    (SELECT student_id FROM public.student
     WHERE student_name = 'Rhoda Atanda'),
    (SELECT course_id FROM public.course
     WHERE course_code = 'CS101'),
    (SELECT lecturer_id FROM public.lecturer
     WHERE email = 'alani@example.com'),
    105.00,
    'A',
    '2026-06-01 23:59:59+00'
);


-- 9. Letter grades must be A, B, C, D, E or F.
INSERT INTO public.enrollment
    (student_id, course_id, lecturer_id, numerical_grade,
     letter_grade, submission_deadline)
VALUES (
    (SELECT student_id FROM public.student
     WHERE student_name = 'Rhoda Atanda'),
    (SELECT course_id FROM public.course
     WHERE course_code = 'CS101'),
    (SELECT lecturer_id FROM public.lecturer
     WHERE email = 'alani@example.com'),
    85.00,
    'Z',
    '2026-06-01 23:59:59+00'
);


-- Failed operations must not change these counts:
-- department: 2, student: 2, lecturer: 2, course: 3, enrollment: 3.

SELECT 'department' AS table_name, COUNT(*) AS row_count
FROM public.department
UNION ALL
SELECT 'student', COUNT(*)
FROM public.student
UNION ALL
SELECT 'lecturer', COUNT(*)
FROM public.lecturer
UNION ALL
SELECT 'course', COUNT(*)
FROM public.course
UNION ALL
SELECT 'enrollment', COUNT(*)
FROM public.enrollment;
