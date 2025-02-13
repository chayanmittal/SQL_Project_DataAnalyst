/* HIGEST PAYING JOBS AND SKILLS REQUIRED*/

/*
Ques: What are the top paying data jobs?
- Identify the top 10 highest-paying DA role that are available remotely.
- Focuses on job posting with specified salaries(by removing null).
- Identify which skills to develop that align with top salaries.
*/

WITH top_job AS(
    SELECT
        job_id,
        job_title,
        cd.name company_name,
        salary_year_avg
    FROM
        job_postings_fact jp
    LEFT JOIN company_dim cd ON jp.company_id=cd.company_id
    WHERE
        job_title_short like '%Data Analyst' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    tj.*,
    skills
FROM 
    top_job tj
INNER JOIN skills_job_dim sj ON tj.job_id=sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id=sd.skill_id
ORDER BY
    salary_year_avg DESC