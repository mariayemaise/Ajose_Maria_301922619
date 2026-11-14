

-- BLOCK 1: Benchmark Schema and Synthetic History Table Setup

-- Create an isolated benchmark schema
CREATE SCHEMA IF NOT EXISTS p2_benchmark;

-- Remove the existing benchmark table if exist
DROP TABLE IF EXISTS p2_benchmark.enrollment_history;

-- Generate 100,000 synthetic historical enrollment records
CREATE TABLE p2_benchmark.enrollment_history AS
SELECT
    generate_series(1, 100000) AS history_id,
    FLOOR(random() * 2)::BIGINT + 1 AS student_id,
    FLOOR(random() * 3)::BIGINT + 10 AS course_id,
    FLOOR(random() * 2)::BIGINT + 1 AS lecturer_id,
    ROUND((random() * 40 + 60)::NUMERIC, 2) AS numerical_grade,
    TIMESTAMPTZ '2026-01-01 00:00:00+00'
        + (random() * INTERVAL '365 days') AS submission_deadline;

-- Refresh table statistics
ANALYZE p2_benchmark.enrollment_history;

-- Verify total number of records
SELECT COUNT(*) AS total_rows
FROM p2_benchmark.enrollment_history;


-- BLOCK 2

-- Return records within a five-day date range
SELECT
    history_id,
    student_id,
    course_id,
    submission_deadline,
    numerical_grade
FROM p2_benchmark.enrollment_history
WHERE submission_deadline >= TIMESTAMPTZ '2026-03-01 00:00:00+00'
  AND submission_deadline < TIMESTAMPTZ '2026-03-06 00:00:00+00'
ORDER BY submission_deadline;


-- BLOCK 3: Pre-Index Execution Plan

-- Measure performance before creating the custom index.
-- Ignore the first warm-up time; record the next three Execution Time values.
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    history_id,
    student_id,
    course_id,
    submission_deadline,
    numerical_grade
FROM p2_benchmark.enrollment_history
WHERE submission_deadline >= TIMESTAMPTZ '2026-03-01 00:00:00+00'
  AND submission_deadline < TIMESTAMPTZ '2026-03-06 00:00:00+00'
ORDER BY submission_deadline;


-- BLOCK 4:  Index Creation

-- Create an index on submission_deadline
CREATE INDEX idx_enrollment_history_deadline
ON p2_benchmark.enrollment_history (submission_deadline);

-- Refresh statistics after index creation
ANALYZE p2_benchmark.enrollment_history;


-- BLOCK 5: Post-Index Execution Plan

-- Measure performance after creating the  index.
-- Ignore the first warm-up time; record the next three Execution Time values.
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    history_id,
    student_id,
    course_id,
    submission_deadline,
    numerical_grade
FROM p2_benchmark.enrollment_history
WHERE submission_deadline >= TIMESTAMPTZ '2026-03-01 00:00:00+00'
  AND submission_deadline < TIMESTAMPTZ '2026-03-06 00:00:00+00'
ORDER BY submission_deadline;
