--- This query is used to check the current state of the target student record before executing the transaction bloack
--- Result: 4 | James Bede | Pending
SELECT student_id, student_name, tuition_status 
FROM public.student 
WHERE student_id = 4;

--- Successful Transaction with Commit
--- This block changes the tuition status for James Bede to 'Paid' and commits it.
--  Result: UPDATE 1 on the first execution, followed by UPDATE 0 on the repeat check.
BEGIN;

UPDATE public.student 
SET tuition_status = 'Paid' 
WHERE student_id = 4 AND tuition_status = 'Pending';

COMMIT;

-- Repeat check (should affect 0 rows )
UPDATE public.student 
SET tuition_status = 'Paid' 
WHERE student_id = 4 AND tuition_status = 'Pending';

--- Failed Transaction with Rollback
--- The transaction starts with a valid update, but a subsequent statement violates the database's check constraint, forcing a full rollback of the transaction.
--- Result: An ERROR: new row for relation "student" violates check constraint "student_tuition_status_check" message, followed by ROLLBACK.
BEGIN;

-- Valid change
UPDATE public.student 
SET tuition_status = 'Pending' 
WHERE student_id = 4;

-- Deliberate violation (violates the tuition_status CHECK constraint)
UPDATE public.student 
SET tuition_status = 'InvalidStatus' 
WHERE student_id = 4;

ROLLBACK;

--- This query proves that the earlier committed change ('Paid') remains safely stored, while any intermediate changes from the rolled-back transaction were completely discarded.
--- Result: 4 | James Bede | Paid
SELECT student_id, student_name, tuition_status 
FROM public.student 
WHERE student_id = 4;