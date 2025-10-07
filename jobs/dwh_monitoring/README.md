# Daily DWH monitoring
This is a task from the final project.

## Description
BigQuery public project contains many datasets,

It is impossible to monitor when each table had been updated

and what is the info on each table.

As a BI developer, you have been requested to develop a daily job
which will monitor this data warehouse.

The job will extract the info on all the tables,

you need to define which properties you would like to extract and where to

save it.

Action Items:

- Define the KPIs you want to extract
- Develop the python script which execute this operation
- Draw a chart flow for the whole process
- Which features will you add to the process?


Project source:
```dtd
`bigquery-public-data`
```

## Job description
The daily ETL will run daily and will extract the dataset and tables properties.
Additional script alert on predefining KPIs.
For example, the table hadn't been updated more then X days.

## KPIs
- Created
- Last modified
- Data location
- Table Type
- Number of rows
- Total physical bytes
- Total logical bytes


## Documents Reference
[listing datasets](https://cloud.google.com/bigquery/docs/listing-datasets)
[list tables](https://cloud.google.com/bigquery/docs/tables#get_information_about_tables)
[get table](https://cloud.google.com/bigquery/docs/samples/bigquery-load-table-dataframe)


## Commands
create schema 
```dtd
create schema fp_daily_dwh_monitor options (description="contains tables of the dwh monitor process")
```

[//]: # (bq head ppltx-m--tutorial-dev:fp_daily_dwh_monitor.all_tables)


delete data from today
```dtd
DELETE `ppltx-m--tutorial-dev`.fp_daily_dwh_monitor.all_tables WHERE date = FORMAT_DATE('%Y-%m-%d', `CURRENT_DATE`());
```

## Schedule on VM - Production
create a bash file to run the scheduled ETL

[Crontab video](https://www.youtube.com/watch?v=Fsj9f-E5kz4&list=PLkKJj26K4JZ3NHY2C-G2MtlQ1EXOnC_tu&index=5)

Execute file name:
10:00

0 10 * * * bash
```bash
bash ~/workspace/ppltx-tutorial/jobs/dwh_monitoring/scheduler/execute_daily_dwh_monitoring.sh
```

### Validation
Check that the ETL had run successfully and generated `end` log   
```bash
bash ~/workspace/ppltx-tutorial/jobs/dwh_monitoring/scheduler/execute_log_monitoring.sh
```

Monitor changes in daily KPIs ETL by configuration file
```bash
bash ~/workspace/ppltx-tutorial/jobs/dwh_monitoring/scheduler/execute_kpi_monitoring.sh
```

## Logs
get logs

```sql
SELECT
  DATETIME_DIFF(CURRENT_DATETIME(), ts, HOUR) > 24 AS raise_flag,
  FORMAT_DATE("%Y-%m-%d %H", ts) AS lt,
  *
FROM
  `ppltx-m--tutorial-dev.logs.daily_logs`
WHERE
  TRUE
  AND job_name = 'dwh_monitor'
  AND file_name = 'daily_dwh_monitor.py'
  AND step_name = 'end'
ORDER BY
  ts DESC
LIMIT 10;

```
