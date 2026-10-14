-- Bucket Salaries
-- < 25 = 'Low'
-- 25-50 = 'Medium'
-- ? 50 = 'High'

 SELECT
    job_title_short,
    salary_hour_avg,
    CASE 
        WHEN salary_hour_avg < 25 THEN 'LOW'
        WHEN salary_hour_avg < 50 THEN 'MEDIUM'
        ELSE 'High'  
    END AS salary_category
    FROM job_postings_fact
    WHERE salary_hour_avg IS NOT NULL
    LIMIT 10;




-- Handling missing data (NULLS)
-- Filter NULL salary values

 SELECT
    job_title_short,
    salary_hour_avg,
    CASE 
        WHEN salary_hour_avg IS NULL THEN 'Missing'
        WHEN salary_hour_avg < 25 THEN 'LOW'
        WHEN salary_hour_avg < 50 THEN 'MEDIUM'
        ELSE 'High'  
    END AS salary_category
    FROM job_postings_fact
    LIMIT 10;



-- Categorising categorical values
-- Classify the 'job_title' column values as:
    -- 'Data Analysis'
    -- 'Data Engineer'
    -- 'Data Scientist'

SELECT
    job_title,
    CASE
    WHEN job_title LIKE '%Data%' AND job_title LIKE '%Analyst%' THEN 'Data Analyst'
     WHEN job_title LIKE '%Data%' AND job_title LIKE '%AEngineer%' THEN 'Data Engineer'
      WHEN job_title LIKE '%Data%' AND job_title LIKE '%Scientist%' THEN 'Data Scientist'
      ELSE 'Other'
    END AS job_title_category,
    job_title_short
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 20;



-- Conditional aggregation
-- Calculate median salaries for different buckets
    -- < £100k
    -- >= £100k

SELECT
    job_title_short,
    COUNT(*) AS total_postings,
    MEDIAN(
        CASE
            WHEN salary_year_avg <100_000 THEN salary_year_avg
        END
       ) AS median_low_salary,
     MEDIAN(
        CASE
            WHEN salary_year_avg <100_000 THEN salary_year_avg
        END
       ) AS median_high_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY job_title_short;



    -- Final example: Conditional calculations
    -- Compute a standardised_salary using yearly salary and adjusted hourly salary (e.g. 2080 hours/year)
    -- Categorise salaries into tiers of:
        -- < 75k 'Low'
        -- 75k - 150k 'Medium'
        -- >= 150k 'High'

WITH salaries AS (
    SELECT 
    job_title_short,
    salary_hour_avg,
    salary_year_avg,
    CASE
        WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
        WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg*2080
    END AS standardised_salary
    FROM 
    job_postings_fact
  
)
SELECT 
    *,
    CASE
        WHEN standardised_salary IS NULL THEN 'Missing'
        WHEN standardised_salary < 75_000 THEN 'Low'
        WHEN standardised_salary < 150_000 THEN 'Medium'
       ELSE 'High'
    END AS salary_bucket
FROM salaries
LIMIT 10;