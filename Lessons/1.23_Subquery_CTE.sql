-- Subquery

SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    OR salary_hour_avg IS NOT NULL
)
  LIMIT 10;

-- CTE

WITH valid_salaries AS (
  SELECT *
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    OR salary_hour_avg IS NOT NULL
)
SELECT *
FROM valid_salaries;



-- Scenario 1 - Subquery is SELECT
-- Show each job's salary next to the overall market median:

SELECT
    Job_title_short,
    salary_year_avg,
    (
        SELECT MEDIAN (salary_year_avg)
        FROM job_postings_fact
    ) AS market_median_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    LIMIT 10;



-- Scenario 2 - Subquery is FROM
-- Stage only jobs that are remote after aggregating to determine the remote median salary per job:

SELECT
    Job_title_short,
   MEDIAN (salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN (salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary
    FROM (
        SELECT 
        Job_title_short,
        salary_year_avg,
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS clean_jobs
    GROUP BY Job_title_short
    LIMIT 10;



-- Scenario 3 - Subquery is HAVING
-- Keep only job titles where median salary is above the overall median:

SELECT
    Job_title_short,
   MEDIAN (salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN (salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary
    FROM (
        SELECT 
        Job_title_short,
        salary_year_avg,
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS clean_jobs
    GROUP BY Job_title_short
    HAVING MEDIAN (salary_year_avg) > (
          SELECT MEDIAN (salary_year_avg)
        FROM job_postings_fact
        WHERE job_work_from_home = TRUE
    )
    LIMIT 10;


    -- CTE example
    -- Compare how much more (or less) remote roles pay compares to onsite roles for each job title.
    -- Use a CTE to calculate the median salary by title and work arrangement, then compare those medians.

WITH title_median AS (
SELECT
    job_title_short,
    job_work_from_home,
    MEDIAN (salary_year_avg)::INT AS median_salary
    FROM job_postings_fact
    WHERE job_country = 'United Kingdom'
    GROUP BY job_title_short,
    job_work_from_home
)

SELECT 
    r.job_title_short,
    r.median_salary AS remote_median_salary,
    o.median_salary AS onsite_median_salary,
    (r.median_salary - o.median_salary) AS remote_premium
FROM title_median AS r
INNER JOIN title_median AS o
ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC;



-- Identify job postings that have no associated skills before loading them into a data mart

SELECT *
FROM job_postings_fact
ORDER BY job_id
LIMIT 10;

SELECT *
FROM skills_job_dim
ORDER BY job_id
LIMIT 40;


SELECT *
FROM job_postings_fact AS tgt
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS src
    WHERE tgt.job_id = src.job_id
)
ORDER BY job_id;