---Session A: Begin Transaction and Insert Uncommitted Record
-- A inserts a new department ('Physics') within an active transaction but does not commit yet.
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

INSERT INTO public.department (department_name) 
VALUES ('Physics');

-- Commit the Transaction
-- commits its transaction, finalizing the insertion of 'Physics' and releasing the lock.
COMMIT;