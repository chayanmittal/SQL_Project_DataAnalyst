
/* MOST POPULAR SKILLS IN DEMAND   */

/*
Ques: Find the count of the number of jobs posting per skill
 - Display the top 10 skills by their demand in remote jobs
 - Include skill id, name & count of postings requiring the skill
 - Using CTE
*/

WITH remote_job_skill AS(
    SELECT 
        sd.skill_id,
        COUNT(*) AS openings_count
    FROM 
        skills_job_dim sd
    INNER JOIN job_postings_fact jp on jp.job_id=sd.job_id
    WHERE
        jp.job_title_short LIKE '%Data Analyst'
    GROUP BY
        sd.skill_id
) 

SELECT
    sk.skills,
    rk.openings_count,
    sk.skill_id
FROM
    remote_job_skill rk
INNER JOIN
    skills_dim sk ON rk.skill_id=sk.skill_id
ORDER BY
    rk.openings_count DESC
LIMIT 10;

/*
Ques: What are the most in demand skills for data roles?
 - Displaying the top 10 skills by their demand.
 - Considering all job postings.
 - Identify the most valuable skills for job seekers in Data field. 
 - Without CTE
*/

SELECT
    skills,
    COUNT(sj.job_id) As count
    
FROM 
    job_postings_fact jp
INNER JOIN skills_job_dim sj ON jp.job_id=sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id=sd.skill_id
WHERE
    jp.job_title_short LIKE '%Data Analyst'
GROUP BY
    skills
ORDER BY
    count DESC
LIMIT 5;