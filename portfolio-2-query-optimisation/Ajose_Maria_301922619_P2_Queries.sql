
-- Q1: List student course enrollments with department, course details, and grades for paid students.
SELECT s.student_name, d.department_name, c.course_code, c.course_name, e.numerical_grade, e.letter_grade
FROM public.enrollment e
JOIN public.student s USING (student_id)
JOIN public.department d ON s.department_id = d.department_id
JOIN public.course c USING (course_id)
WHERE s.tuition_status = 'Paid'
ORDER BY s.student_name, c.course_code;

-- Q2: Find courses that are not required as a prerequisite for any other course.
SELECT c.course_code, c.course_name
FROM public.course c
WHERE NOT EXISTS (
    SELECT 1 FROM public.course p
    WHERE p.prerequisite_course_id = c.course_id
)
ORDER BY c.course_code;

-- Q3: Count the number of students in each department, keep departments with zero students.
SELECT d.department_name, count(s.student_id) AS total_students
FROM public.department d LEFT JOIN public.student s USING (department_id)
GROUP BY d.department_id, d.department_name 
ORDER BY d.department_name;