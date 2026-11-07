# Portfolio 1 Database Design and Modelling

## Case study
Student Result Portal manages academic records in a university. It stores the data of students, academic departments, degree programs, courses, lecturer assignments, and grade records for each semester. 

## Users
Administrators duties include enrolling new students, keeping course catalogues up to date, and assigning lecturers to courses. Lecturers upload, update and submit final assessment marks for their assigned courses. Students can log in to see their courses, view their published semester grades, calculate their current GPA and request an official transcript.

## Main operations
The system allow students to be registered for academic sessions and enrolled in particular courses, lecturers to be assigned to course units, uploading of official semester results and generation of academic transcripts.

## Business rules
1. Students have unique Student ID numbers.

2. Each student is a member of one academic department.

3. The courses must be allocated to one main lecturer per semester.

4. The numeric grade must be between 0 and 100.

5. Only valid grades A, B, C, D, E and F can be assigned as a letter grade.

6. No student may be registered in a course if any of the prerequisites have not been completed with a good grade.

7. It is not possible to add or edit assessment marks after the official grade submission date for the term.

8. students with outstanding tuition balance can not view uploaded results or request a transcript.

## Scope
This database design covers  academic tracking, such as student profiles, course registration, lecturer assignments, grade entry, grade point averages, and generation of transcripts. It does not include financial billing systems, online payment gateways, housing management, learning management system (LMS) content delivery or campus library operations. 