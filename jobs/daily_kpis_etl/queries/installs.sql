
/*
 run_time
 {run_time}
 */

 -- incremental data today and yesterday
create or replace table `{project}.{dataset_dst}.{kpis_name}_inc`
partition by install_date
options (description = "{description}")
as
SELECT
    user_id,
    DATE(MIN(time)) AS install_date
FROM
    `{project}.{dataset_src}.{table_src}`
    where date(time) >= date("{date}")
GROUP BY user_id
order by install_date DESC;


-- insert new users into the installation panel
insert into `{project}.{dataset_dst}.{kpis_name}`
SELECT
    user_id,
    a.install_date,
    -- b.install_date
FROM
    `{project}.{dataset_dst}.{kpis_name}_inc` as a
    left join `{project}.{dataset_dst}.{kpis_name}` as b
    using(user_id)
    where b.user_id is null


/*
-- Validation - data distribution
SELECT
    install_date,
    COUNT(1) AS t_events
FROM
    `ppltx-m--tutorial-dev.fp_daily_kpis_etl.installs`
GROUP BY
    1
ORDER BY
    1 DESC
LIMIT 10;
*/
