/* MOST OPTINAL SKILL IN TERMS OF HIGH DEMAND AND PAY  */

/*
Ques: The most optimal skill to learn in terms of demand and pay?
 - Identif skills high in demand and associated with high salaries for data role(Data Analyst)
 - Offering strategic insight for career development
 */

WITH skills_demand AS(
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(sj.job_id) As demand_count
        
    FROM 
        job_postings_fact jp
    INNER JOIN skills_job_dim sj ON jp.job_id=sj.job_id
    INNER JOIN skills_dim sd ON sj.skill_id=sd.skill_id
    WHERE
        jp.job_title_short LIKE '%Data Analyst' AND
        jp.salary_year_avg IS NOT NULL
    GROUP BY
        sd.skill_id
), avgerage_salary AS(
    SELECT
        sd.skill_id,
        sd.skills,
        ROUND(AVG(jp.salary_year_avg),0) AS avg_salary
    FROM 
        job_postings_fact jp
    INNER JOIN skills_job_dim sj ON jp.job_id=sj.job_id
    INNER JOIN skills_dim sd ON sj.skill_id=sd.skill_id
    WHERE
        jp.job_title_short LIKE '%Data Analyst' AND
        jp.salary_year_avg IS NOT NULL
    GROUP BY
        sd.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN avgerage_salary ON skills_demand.skill_id=avgerage_salary.skill_id
WHERE
    demand_count > 100
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25

/*Without CTE and optimizing the sql*/
SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sj.job_id) AS num_openings,
    ROUND(AVG(jp.salary_year_avg),0) AS avg_salary
FROM job_postings_fact jp
INNER JOIN skills_job_dim sj ON sj.job_id=jp.job_id
INNER JOIN skills_dim sd ON sd.skill_id=sj.skill_id
WHERE
    jp.job_title_short LIKE '%Data Analyst' AND
    jp.salary_year_avg IS NOT NULL
GROUP BY
    sd.skill_id
HAVING 
    COUNT(sj.job_id) > 100   
ORDER BY
    avg_salary DESC,
    num_openings DESC
LIMIT 25;