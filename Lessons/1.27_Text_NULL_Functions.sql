SELECT LENGTH ('SQL');

SELECT LOWER ('SQL');

SELECT UPPER ('SQL');

SELECT LEFT ('SQL', 2);

SELECT SUBSTRING ('SQL', 2, 1);

SELECT CONCAT ('SQL', '-', 'Functions');

SELECT TRIM (' SQL ');

SELECT REPLACE ('SQL', 'Q', '_');

SELECT REGEXP_REPLACE ('SQL@gmail.com', '^.*(@)', '\1');

-- Final example - Cleanup this using Text Functions

WITH title_lower AS (
    SELECT
        job_title,
        LOWER (TRIM (job_title)) AS job_title_clean
    FROM job_postings_fact
)

SELECT
    job_title,
    CASE
    WHEN job_title_clean LIKE '%data%' 
     AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
    WHEN job_title_clean LIKE '%data%'
     AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
    WHEN job_title_clean LIKE '%data%' 
     AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
      ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 30;



SELECT NULLIF(10, 10);

SELECT NULLIF(10, 20);

SELECT COALESCE (NULL, 1, 2); -- First non null value