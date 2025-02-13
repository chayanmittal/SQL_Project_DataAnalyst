/*HIGHEST PAYING JOBS*/

/*
Ques: What are the top paying data analyst jobs?
- Identify the top 10 highest-paying Data role that are available remotely.
- Focuses on job posting with specified salaries(by removing null).
*/

SELECT
    job_id,
    job_title,
    cd.name company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact jp
LEFT JOIN company_dim cd ON jp.company_id=cd.company_id
WHERE
    job_title_short like '%Data Analyst%' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
