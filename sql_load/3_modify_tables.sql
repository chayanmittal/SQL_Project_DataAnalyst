/*
To run in PSQL tool(rt jobs_project in pgAdmin)
\copy company_dim FROM 'C:\Users\rsrcy\AppData\Local\EduInno Dynamics1\SQL_Project_DataAnalyst\csv_files\company_dim.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\Users\rsrcy\AppData\Local\EduInno Dynamics1\SQL_Project_DataAnalyst\csv_files\job_postings_fact.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\Users\rsrcy\AppData\Local\EduInno Dynamics1\SQL_Project_DataAnalyst\csv_files\skills_dim.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\Users\rsrcy\AppData\Local\EduInno Dynamics1\SQL_Project_DataAnalyst\csv_files\skills_job_dim.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
*/
select count(*) from company_dim;
select count(*) from skills_dim;
select count(*) from job_postings_fact;
select count(*) from skills_job_dim;
