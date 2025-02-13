/* MOST OPTIMAL SKILL BASED ON SALARY*/

/*
Ques: Top skills based on salary?
 - Looking at the average salary associated with each skill for Data Analyst role.
 - Not to consider jobs with NULL salary.
 - Help identify the most financially reqarding skills to learn.
*/

SELECT
    skills,
    ROUND(AVG(jp.salary_year_avg),0) AS avg_salary
FROM 
    job_postings_fact jp
INNER JOIN skills_job_dim sj ON jp.job_id=sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id=sd.skill_id
WHERE
    jp.job_title_short = 'Data Analyst' AND
    jp.salary_year_avg IS NOT NULL 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 10;

/*
INSIGHT
1. High demand for Big Data & ML skills. 
2. Big data skills(PySpark,Couchbase), ML tools(DataRobot,Jupyter) and 
   Python libraries(Pandas,Numpy) are high in demand.
3. S/W development and deployment proficiency are in demand using GitLab, 
   Kubernets,Airflow.
4. Familiarity with cloud and data engineering tools like Elasticsearch,
   Databricks and GCP significantly boosts earning potential
*/