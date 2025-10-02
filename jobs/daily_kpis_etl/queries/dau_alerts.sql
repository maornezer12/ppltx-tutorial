/*
 Run_time
 {run_time}

 KPIs Name
 {kpis_name}

 Description
 {description}
 */


SELECT
  abs((DAU - {d1})/ {d1}) > {thresh_in_percent} as raise_flag,
  "{kpis_name}" as kpi,
    date,
    DAU as metric,
    {d1} as previous_metric,
  "{project}.{dataset}.{table_id}" as table_name
--  DAU / d1 > 1.1 as raise_flag
FROM
-- {project}.{dataset}.{table_id}
(

SELECT
  date,
  DAU,
  LAG(DAU,1 ) over (order by date) as {d1}
FROM
(
SELECT
  date,
  count(1) as DAU
FROM
`{project}.{dataset}.{table_id}`
group by all
order by 1 desc
limit 5
)

)
order by date desc
limit 1

