/*
 run_time
 {run_time}
 */
create or replace table `{project}.{dataset_dst}.{kpis_name}_inc`
partition by date
options (description = "{description}")
as
SELECT
    user_id,
    DATE(time) AS date,
    COUNT(1) AS total_events,
    SUM(coins_added) as total_coins_added
FROM
`{project}.{dataset_src}.{table_src}`
where date(time) >= date("{date}")
GROUP BY ALL;


-- clear the recent 2 days from the daily_user_panel
delete from `{project}.{dataset_dst}.{kpis_name}`
where date >= date("{date}");

-- insert into the incremental table into the panel
insert into `{project}.{dataset_dst}.{kpis_name}`
SELECT *
FROM `{project}.{dataset_dst}.{kpis_name}_inc`

/*
-- Validation - data distribution
SELECT
    date,
    COUNT(1) AS t_events
FROM
    `ppltx-m--tutorial-dev.fp_daily_kpis_etl.daily_user_panel`
GROUP BY
    1
ORDER BY
    1 DESC
LIMIT 10;
*/

