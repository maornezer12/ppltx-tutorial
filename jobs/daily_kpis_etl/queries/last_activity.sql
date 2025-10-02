/*
 run_time
 {run_time}
*/
create or replace table `{project}.{dataset_dst}.{kpis_name}_inc`
partition by last_activity
options (description = "{description}")
as
SELECT
    user_id,
    DATE(MAX(time)) AS last_activity
FROM `{project}.{dataset_src}.{table_src}`
WHERE DATE(time) >= DATE("{date}")
GROUP BY user_id;

delete from `{project}.{dataset_dst}.{kpis_name}`
where last_activity >= date("{date}");

insert into `{project}.{dataset_dst}.{kpis_name}`
SELECT *
FROM `{project}.{dataset_dst}.{kpis_name}_inc`;

/*
-- Validation - data distribution
SELECT
    last_activity,
    COUNT(1) AS users
FROM
    `{project}.{dataset_dst}.{kpis_name}`
GROUP BY
    1
ORDER BY
    1 DESC
LIMIT 10;
*/
