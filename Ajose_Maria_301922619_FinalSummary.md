# MIT 8103 Advanced Database Systems: Portfolio Summary

* **Case-Study Name:** Student Result Portal (`student_result_portal_portfolio` / `student_portal_nosql`)
* **Name:** Ajose Maria
* **Student ID:** 301922619
* **Repository URL:** [GitHub Repository](https://github.com/mariayemaise/Ajose_Maria_301922619/tree/main)

---

## Case study

The Student Result Portal focuses on managing key academic activities, including departments, student records, courses, lecturers, and student enrollments. The project started with a relational database in PostgreSQL and later explored MongoDB's document-based approach, followed by distributed database  concepts. It apply database design, query optimisation, transaction management, and concurrency control using a practical academic system.

## Portfolio 1: Database Design and Modelling
Portfolio 1 focused on designing the relational database for the Student Result Portal. I used normalisation to organise the data and reduce duplication across tables such as department, student, course, lecturer, and enrollment. I also implemented primary keys, foreign keys, unique constraints, and check constraints to maintain data integrity and prevent invalid records.

## Portfolio 2: Query Processing and Optimisation
Portfolio 2 focused on improving query performance in PostgreSQL. I used EXPLAIN (ANALYZE, BUFFERS) to examine query execution plans and created a separate benchmark table with 100,000 synthetic enrollment records to avoid affecting the original data. After testing before and after creating a B-tree index on submission_deadline, the median execution time improved from 13.500 ms to 1.266 ms. This exercise helped me understand how indexing can make queries more efficient.

* **Performance Comparison Table:**

| Optimization Stage | Execution Strategy | Median Execution Time | Tested Dataset Size |
| :--- | :--- | :--- | :--- |
| **Before Indexing** | Sequential Scan | 13.500 ms | 100,000 synthetic records |
| **After Indexing** | 	Bitmap Index Scan/Bitmap Head Scan  | 1.266 ms | 100,000 synthetic records |


## Portfolio 3: Transactions and Concurrency

I used BEGIN, COMMIT, and ROLLBACK to update James Bede's tuition status from 'Pending' to 'Paid' and test how PostgreSQL handles invalid changes through check constraints. I also conducted a two-session concurrency test where Session A inserted 'Physics' while Session B attempted to insert the same department. After Session A committed, Session B received a unique constraint violation. This exercise helped me understand how transactions and constraints protect data integrity during concurrent operations.

## Portfolio 4: NoSQL and Advanced Data Models

 I created the student_portal_nosql database and stored four student activity records (EVT_001 to EVT_004) in the student_activities collection. Each document contains student and course information alongside event details.

## Portfolio 5: Distributed and Cloud Database Exercise
I proposed a three-member replica set where a primary handles writes while secondary members maintain copies of the data. I also examined how automatic elections, majority write concern, and replication lag affect database availability and consistency. The exercise covered sharding and important cloud security measures, including authentication, encryption, and backups. Although the replica set and sharding were not implemented, this exercise helped me understand how distributed databases support availability, fault tolerance, and scalability.

## Evidence
- Relational Schema & P1 README: [Portfolio 1 Directory](https://github.com/mariayemaise/Ajose_Maria_301922619/tree/main/portfolio-1-database-design)
- Query Optimization: [Portfolio 2 Directory](https://github.com/mariayemaise/Ajose_Maria_301922619/tree/main/portfolio-2-query-optimisation)
- Transactions & Concurrency Scripts: [Portfolio 3 Directory](https://github.com/mariayemaise/Ajose_Maria_301922619/tree/main/portfolio-3-transactions-concurrency)
- NoSQL Script & Document Model: [Portfolio 4 Directory](https://github.com/mariayemaise/Ajose_Maria_301922619/tree/main/portfolio-4-nosql)
- Distributed Theory README: [Portfolio 5 Directory](https://github.com/mariayemaise/Ajose_Maria_301922619/tree/main/portfolio-5-distributed-cloud)

## Individual reflection

I chose to use embedded sub-documents in MongoDB to keep related student activity information together and make event retrieval easier. I initially struggled to understand transaction boundaries and thought ROLLBACK would only undo the last statement rather than all changes made within a transaction.I reviewed PostgreSQL transaction handling, practised using ROLLBACK after constraint violations, and checked the final database state. I learned that a transaction is treated as a single unit, and ROLLBACK undoes all uncommitted changes made since BEGIN.


## References

- PostgreSQL 16 – [Constraints](https://www.postgresql.org/docs/16/ddl-constraints.html)
- PostgreSQL 16 – [Using EXPLAIN](https://www.postgresql.org/docs/16/using-explain.html)
- PostgreSQL 16 – [Transaction Isolation](https://www.postgresql.org/docs/16/transaction-iso.html)
- MongoDB Manual – [Documents](https://www.mongodb.com/docs/manual/core/document/)
- MongoDB Manual – [Replication and Replica Set Fundamentals](https://www.mongodb.com/docs/manual/replication/)


## AI Use Declaration

I used Gemini AI  to explain database concepts and review the structure and wording of my portfolio documentation.
I executed the database commands myself, verified the results against the assessment requirements, and made corrections where necessary. I understand the work submitted and take responsibility for its accuracy.
