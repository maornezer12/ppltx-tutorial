/*
 KPIs Name
 {kpis_name}

 Description
 {description}
*/

SELECT
  abs((users_count - {d1}) / {d1}) > {thresh_in_percent} AS raise_flag,
  "{kpis_name}" AS kpi,
  last_activity,
  users_count AS metric,
  {d1} AS previous_metric,
  "{project}.{dataset}.{table_id}" AS table_name
FROM (
  SELECT
    last_activity,
    users_count,
    LAG(users_count, 1) OVER (ORDER BY last_activity) AS {d1}
  FROM (
    SELECT
      last_activity,
      COUNT(1) AS users_count
    FROM `{project}.{dataset}.{table_id}`
    GROUP BY last_activity
    ORDER BY last_activity DESC
    LIMIT 5
  )
)
ORDER BY last_activity DESC
LIMIT 1;
