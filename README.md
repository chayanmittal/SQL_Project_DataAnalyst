# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [sql_project folder](/sql_project/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary. This query highlights the high paying opportunities in the field.

```sql
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
```
Here's the breakdown of the top data analyst jobs:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](/insights/top_paying_roles.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
ITH top_job AS(
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

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs:
- **SQL** is leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6.
Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

![Top Paying Skills](/insights/top_paying_roles_skills.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results*

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
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
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 110380       |
| Excel    | 75348        |
| Python   | 68409        |
| Tableau  | 56569        |
| Power BI | 45482        |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT
    skills,
    ROUND(AVG(jp.salary_year_avg),0) AS avg_salary
FROM 
    job_postings_fact jp
INNER JOIN skills_job_dim sj ON jp.job_id=sj.job_id
INNER JOIN skills_dim sd ON sj.skill_id=sd.skill_id
WHERE
    jp.job_title_short = 'Data Analyst' AND
    jp.salary_year_avg IS NOT NULL AND
    job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 10;
```
Here's a breakdown of the results for top paying skills for Data Analysts:

- **Emerging Technologies & AI/ML:** Skills in Solidity (blockchain), MXNet, Keras, PyTorch, and TensorFlow are commanding higher salaries, highlighting the growing demand for expertise in blockchain and artificial intelligence.

- **Cloud, DevOps & Automation Tools:** Tools like Terraform, VMware, Ansible, and Puppet remain in high demand, with salaries ranging from $124,000 to $147,000, reflecting the importance of cloud engineering and automation.

- **Legacy & Infrastructure Tools:** Traditional technologies such as SVN, GitLab, and Perl still offer significant salaries, indicating the ongoing need for professionals with expertise in older systems and infrastructure management.

- **High-paying Niche Skills:** The highest-paying roles are associated with specialized tools like SVN (version control), Couchbase (NoSQL database), and DataRobot (AI/ML automation), showing that rare and niche skills can lead to lucrative opportunities.


|skills         |          avg_salary|
|---------------|-------------------:|
|svn            |              400000|
|solidity       |              179000|
|couchbase      |              160515|
|datarobot      |              155486|
|golang         |              155000|
|mxnet          |              149000|
|dplyr          |              147633|
|vmware         |              147500|
|terraform      |              146734|
|twilio         |              138500|


*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
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
```

| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
|	92	   |spark		|   231		   |              116744|
|	75	   |databricks	|   138        |              114910|
|	93	   |pandas		|   111		   |              113705|
|	97	   |hadoop		|   185		   |              112946|
|   80     |snowflake	|   357        |              112876|
|   78     |redshift	|   136	       |              110766|
|   141    |express	    |   114	       |              110728|
|   2      |nosql	    |   123	       |              110365|
|   76     |aws	        |   372	       |              109973|
|   233    |jira	    |   198	       |              109914|

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts: 

- **High Demand for Data & Cloud Skills:** Python and SQL lead with the highest number of job openings (Python: 2,304, SQL: 3,892) and strong salaries, indicating high demand for data science, development, and database management roles. Cloud platforms like AWS and Azure also show significant openings and competitive salaries.

- **Specialized Tools in Data Analytics:** Tools like Looker, Snowflake, Spark, and Databricks are in demand, with salaries ranging from $109,000 to $116,000, reflecting the growing need for big data, real-time analytics, and business intelligence expertise.

- **Programming & Business Intelligence:** Java, Go, C, and R maintain solid openings, while Tableau and Qlik highlight strong demand for business intelligence and data visualization skills, with Tableau showing the highest number of openings (2,155).

- **Enterprise Technologies:** Oracle and Jira continue to be essential in enterprise environments, reflecting ongoing demand for enterprise software expertise in both development and project management roles.

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
