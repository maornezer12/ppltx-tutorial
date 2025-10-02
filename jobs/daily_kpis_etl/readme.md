# Daily Aggregated KPIs ETL
This is a task from the final project.

## Description
Develop a Daily Aggregation ETL
Which aggregates data from Mobile gaming App.


Table source:
```dtd
`ppltx-tutorial-dev.gamepltx.fact`
```

## Job description
The daily ETL will run daily and will calculate the predefined defined KPIs

## KPIs
- Installs
- Daily user Panel
- last activity

## Commands
create schema 
```dtd
create schema fp_daily_kpis_etl options (description="contains tables of the daily kpis")
```
delete data from today
```dtd
DELETE FROM `ppltx-m--tutorial-dev.fp_daily_kpis_etl.daily_user_panel` WHERE date = CURRENT_DATE();
DELETE FROM `ppltx-m--tutorial-dev.fp_daily_kpis_etl.installs` WHERE install_date = CURRENT_DATE();
DELETE FROM `ppltx-m--tutorial-dev.fp_daily_kpis_etl.last_activity` WHERE last_activity = CURRENT_DATE();
```

## Schedule on VM - Production
create a bash file to run the scheduled ETL

[Crontab video](https://www.youtube.com/watch?v=Fsj9f-E5kz4&list=PLkKJj26K4JZ3NHY2C-G2MtlQ1EXOnC_tu&index=5)

Execute file name:
09:00

0 9 * * * bash
```bash
bash ~/workspace/ppltx-tutorial/jobs/daily_kpis_etl/scheduler/execute_daily_kpis_etl.sh
```

### Validation
Check that the ETL had run successfully and generated `end` log   
```bash
bash ~/workspace/ppltx-tutorial/jobs/daily_kpis_etl/scheduler/execute_daily_kpis_etl.sh
```

Monitor changes in daily KPIs ETL by configuration file
```bash
bash ~/workspace/ppltx-tutorial/jobs/daily_kpis_etl/scheduler/execute_kpi_monitoring.sh
```


### Data sample
```bash
bq head -n=5 ppltx-m--tutorial-dev:fp_scheduled_query.daily_segment
```



