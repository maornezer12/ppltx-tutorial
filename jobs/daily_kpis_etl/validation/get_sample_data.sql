/* Make sure that the process run today AND calculated the date */

SELECT
  *
FROM
  `ppltx-m--tutorial-dev.fp_daily_kpis_etl.daily_user_panel`
order by date desc
limit 5;

SELECT
  *
FROM
  `ppltx-m--tutorial-dev.fp_daily_kpis_etl.installs`
order by install_date desc
limit 5;


SELECT
  *
FROM
  `ppltx-m--tutorial-dev.fp_daily_kpis_etl.last_activity`
order by last_activity desc
limit 5;