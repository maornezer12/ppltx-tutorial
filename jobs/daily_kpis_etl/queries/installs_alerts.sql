/*
 KPIs Name
 {kpis_name}

 Description
 {description}
*/

SELECT
  abs((t_installs - {d1})/ {d1}) > {thresh_in_percent} as raise_flag,
  "{kpis_name}" as kpi,
   install_date,
   t_installs as metric,
    {d1} as previous_metric,
  "{project}.{dataset}.{table_id}" as table_name
FROM
(
  SELECT
    install_date,
    t_installs,
    LAG(t_installs, 1) OVER (ORDER BY install_date) as {d1}
  FROM
  (
    SELECT
      install_date,
      COUNT(1) as t_installs
    FROM `{project}.{dataset}.{table_id}`
    GROUP BY install_date
    ORDER BY install_date DESC
    LIMIT 5
  )
)
ORDER BY install_date DESC
LIMIT 1;
