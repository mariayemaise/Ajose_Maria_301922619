
# Portfolio 3 Transactions and Concurrency

## Commit and rollback
The transaction script successfully modified James Bede's tuition status from Pending to Paid and committed the change, returning UPDATE 1. A second test introduced an invalid tuition status that violated the student_tuition_status_check constraint, causing an error. The transaction was rolled back, undoing any changes made within that transaction. A final verification query confirmed that the previously committed Paid status remained intact.

## Isolation and concurrency control
Two independent PostgreSQL connections were used to test concurrent inserts under the Read Committed isolation level.

Session A inserted a new department named Physics but did not immediately commit. Session B then attempted to insert another department with the same name. Its operation waited for Session A's transaction to resolve.

After Session A committed, Session B resumed and received a unique constraint violation:

ERROR: duplicate key value violates unique constraint "department_department_name_key"

Session B's failed transaction was subsequently rolled back. A final verification query confirmed that Session A's committed department record persisted and that the conflicting insert from Session B was rejected.

## Conclusion
This exercise showed us how PostgreSQL transactions, CHECK constraints and unique constraints keep data consistent. COMMIT commits your successful transaction, ROLLBACK rolls back your unsuccessful transaction. This concurrency test also showed us how PostgreSQL's unique constraint manages concurrent inserts and avoids duplicate department names when two sessions are running concurrently with the Read Committed isolation level.

## Files
- [Transactions SQL](Ajose_Maria_301922619_P3_Transactions.sql)
- [Session A SQL](Ajose_Maria_301922619_P3_SessionA.sql)
- [Session B SQL](Ajose_Maria_301922619_P3_SessionB.sql)
- Screenshots: [Commit](Images/Ajose_Maria_301922619_P3_Commit.png), [Rollback](Images/  
  Ajose_Maria_301922619_P3_Rollback.png) ,and [ConcurrencyResult](Images/Ajose_Maria_301922619_P3_ConcurrencyResult.png)

## References
- PostgreSQL 16 — [Transaction Isolation](https://www.postgresql.org/docs/16/transaction-iso.html)
- PostgreSQL 16 — [Explicit Locking](https://www.postgresql.org/docs/16/explicit-locking.html)