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
  dt,
  CASE
    WHEN DATE_DIFF(CURRENT_DATE(), DATE(modified), DAY) > {days} THEN "Not updated for more than {days} day(s)"
    WHEN DATE(modified) = CURRENT_DATE() THEN "Single-day table"
  END AS alert_reason,
  name,
  modified,
  num_rows
FROM `{project}.{dataset}.{table_id}`
WHERE date = '{date}'
  AND
  (
  FALSE
  OR DATE_DIFF(CURRENT_DATE(), DATE(modified), DAY) > {days}
  OR DATE(modified) = CURRENT_DATE()
      )
;