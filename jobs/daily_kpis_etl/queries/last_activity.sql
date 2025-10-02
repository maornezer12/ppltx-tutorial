/*
 run_time
 {run_time}
*/
-- all the users who where active on the recent days
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

--union between the panel and the inc table and aggregate
create or replace table `{project}.{dataset_dst}.{kpis_name}`
partition by last_activity
options (description = "{description}")
as
SELECT
    user_id,
    DATE(MAX(last_activity)) AS last_activity
FROM
    (
    SELECT * FROM `{project}.{dataset_dst}.{kpis_name}_inc`
    UNION ALL
    SELECT * FROM `{project}.{dataset_dst}.{kpis_name}`
    )
GROUP BY ALL


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


