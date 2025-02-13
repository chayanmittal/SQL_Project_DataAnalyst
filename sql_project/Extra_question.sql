/*
Ques: Find job postings for the first quater that have salary greater than $70000
 - Combine job posting tables from the first quater(Jan-March)
 - Get job posting with an average yearly salary > $70000
*/

SELECT 
    job_title_short,
    salary_year_avg,
    job_location,
    job_via,
    job_posted_date::DATE
FROM(
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT * 
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quater1_jobs_posting
WHERE
    salary_year_avg>70000 AND
    job_title_short LIKE '%Data Analyst'
ORDER BY
    salary_year_avg DESC;