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

## Design and implementation files

| File | Contents |
|---|---|
| [Design](Ajose_Maria_301922619_P1_Design.md) | Entities, attributes, keys and relationships. |
| [ER diagram](Ajose_Maria_301922619_P1_ERDiagram.md) | The five tables and their relationships. |
| [Normalisation](Ajose_Maria_301922619_P1_Normalisation.md) | Example tables showing 1NF, 2NF and 3NF. |
| [Schema](Ajose_Maria_301922619_P1_Schema.sql) | Table definitions, keys and constraints. |
| [Sample records](Ajose_Maria_301922619_P1_SampleData.sql) | Fictional departments, students, lecturers, courses and enrolments. |
| [Constraint tests](Ajose_Maria_301922619_P1_ConstraintTests.sql) | Invalid insert statements and final row-count verification. |
| [Screenshots](images/) | Screenshots of terminal commands and constraint test results. |

## Implementation

The database was implemented using PostgreSQL 16 within GitHub Codespaces under the database name student_result_portal_portfolio. It consists of five tables: department, student, lecturer, course and enrollment.

Each table uses an auto-generated identity primary key. Foreign keys establish relationships between students and departments, courses and their prerequisites, and enrolments and their corresponding students, courses and lecturers.

Unique constraints prevent duplicate department names, course codes and lecturer email addresses. Additional CHECK constraints validate tuition statuses, numerical grades between 0 and 100, permitted letter grades (A–F), and prevent a course from being assigned itself as a prerequisite.

Sample records were inserted into the tables, and constraint tests were performed using the PostgreSQL command-line interface (psql).

## Test results

The constraint tests verified that the database rejects invalid records. These included violations of required NOT NULL fields, duplicate department names, lecturer email addresses and course codes, invalid foreign key references, and numerical or letter grades outside the permitted values.

After the sample data was inserted and the tests were completed, the final row counts were verified as follows: 2 departments, 2 students, 2 lecturers, 3 courses and 3 enrolments.

Invalid test statements were rejected by the database and did not add invalid records to the tables. More complex business rules, including prerequisite completion, submission deadline enforcement and tuition-based result access restrictions, require additional application-level logic or database triggers.

**Reference:** [PostgreSQL 16 – Constraints](https://www.postgresql.org/docs/16/ddl-constraints.html).