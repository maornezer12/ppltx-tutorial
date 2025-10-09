/*
 Run_time
 {run_time}

 KPIs Name
 {kpis_name}

 Description
 {description}
*/

SELECT
  TRUE AS raise_flag,
  DATE(CURRENT_DATETIME()) AS check_date,
  CASE
    WHEN DATE_DIFF(CURRENT_DATE(), DATE(modified), DAY) > {days} THEN "Not updated for more than {days} day(s)"
    WHEN DATE(modified) = CURRENT_DATE() THEN "Single-day table"
  END AS alert_reason,
  name,
  project,
  dataset_id,
  table_id,
  modified,
  num_rows
FROM `{project}.{dataset}.{table_id}`
WHERE
  (
    DATE_DIFF(CURRENT_DATE(), DATE(modified), DAY) > {days}
    OR DATE(modified) = CURRENT_DATE()
  )
ORDER BY modified DESC
LIMIT 50;
