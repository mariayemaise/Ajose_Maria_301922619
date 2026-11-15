
-- Session B: Attempt Conflicting Insert (Causes Waiting)
-- Session B attempts to insert the exact same department name. 
-- Because Session A holds an uncommitted lock on that unique value, Session B is blocked and forced to wait.
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO public.department (department_name) 
VALUES ('Physics');

-- As soon as Session A commits, Session B will unblock and throw an error
ERROR:  duplicate key value violates unique constraint "department_department_name_key"
DETAIL: Key (department_name)=(Physics) already exists.

--  clean up Session B's aborted transaction:
ROLLBACK;