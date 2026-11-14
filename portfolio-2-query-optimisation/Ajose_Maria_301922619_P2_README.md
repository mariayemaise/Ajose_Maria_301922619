# Portfolio 2 Query Processing and Optimisation

## Queries and results
Queries on the student portal retrieve academic registrations and grades for paid students, independent courses which are determined using NOT EXISTS subqueries, and department student counts using LEFT JOIN so that departments with zero students are included.

## Index comparison
The separate p2_benchmark.enrollment_history table contains 100,000 generated synthetic enrollment records using existing student, course, and lecturer identifiers. The Portfolio 1 records remain unchanged. This test table is created with CREATE TABLE AS and does not copy the operational table's constraints.

The query filters enrollment records within a five-day date range on submission_deadline (2026-03-01 to 2026-03-06), returning matching entries before and after adding idx_enrollment_history_deadline on submission_deadline. ANALYZE refreshes the test table statistics before measurement. Each phase has one warm-up and three measured EXPLAIN (ANALYZE, BUFFERS) runs.

| Measurement | Before index | After index |
| --- | --- | --- |
| Scan type | Seq Scan | Bitmap Index Scan / Bitmap Heap Scan |
| Three execution times (ms) | 14.140, 13.012, 13.500 | 1.266, 1.092, 1.876 |
| Median time (ms) | 13.500 | 1.266 |
| Shared buffer hits, third run | 960 | 738 |

## Performance analysis
Before indexing, PostgreSQL scans all 100,000 rows and removes non-matching rows through the date filter. After indexing, the planner utilizes a bitmap index scan to locate the matching entries efficiently. The median execution time falls from 13.500 ms to 1.266 ms and shared buffer hits fall from 960 to 738. Both phases use cached data; the variable execution times also show that this shared Codespace is not a controlled production benchmark. The result applies to this narrow date range, not every query. An index uses extra storage and adds maintenance work when records change.

## Files

- [SQL queries](Ajose_Maria_301922619_P2_Queries.sql)
- [Test data, execution plans and index SQL](Ajose_Maria_301922619_P2_Optimisation.sql)

### Screenshots

- [Query Results](images/Ajose_Maria_301922619_P2_QueryResults.png)
- [Before Index](images/Ajose_Maria_301922619_P2_BeforeIndex.png)
- [After Index – Run 1](images/Ajose_Maria_301922619_P2_AfterIndex1.png)
- [After Index – Run 2 and 3](images/Ajose_Maria_301922619_P2_AfterIndex2.png)

## Reference
- [PostgreSQL 16](https://www.postgresql.org/docs/16/using-explain.html)