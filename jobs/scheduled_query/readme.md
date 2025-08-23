# Scheduled Query

This is a task from the final project.

## Description
Develop an ETL on public dataset.

Define its KPIs and schedule it on:

BigQuery scheduler
Bash script - Which runs the query
Deploy to production on VM

## Job description
The query will run daily and will add 100 active users the
segmentation table

## Commands
create schema 
```dtd
create schema fp_scheduled_query options (description="contains tables of the daily sementation")
```
truncate table
```dtd
truncate table `fp_scheduled_query.daily_segment`
```

## Schedule on BigQuery scheduler
every day 08:00

[query link](https://console.cloud.google.com/bigquery/scheduled-queries/locations/us/configs/68aee23f-0000-21c6-869f-34c7e948494f/runs?invt=Ab6OkQ&project=ppltx-m--tutorial-dev&supportedpurview=project)


## Schedule query in bash file - [ref](https://cloud.google.com/bigquery/docs/reference/bq-cli-reference?_gl=1*1ti7hc*_ga*MTM4MzI5MzEzMC4xNjgyOTY5Mjg0*_ga_WH2QY8WWF5*MTc0MTg2OTg3NS45MDUuMS4xNzQxODcxNzEwLjI4LjAuMA..#bq_query)
```bash
bq query --use_legacy_sql=false < query.sql
```
Open Google Cloud SDK Shell
```bash
cd C:\workspace\ppltx-tutorial
bq query --use_legacy_sql=false < jobs/scheduled_query/daily_list.sql
```


## Schedule on VM
create a bash file to run the scheduled query
```bash
bq head -n=5 ppltx-m--tutorial-dev:fp_scheduled_query.daily_segment
```
[Crontab video](https://www.youtube.com/watch?v=Fsj9f-E5kz4&list=PLkKJj26K4JZ3NHY2C-G2MtlQ1EXOnC_tu&index=5)



