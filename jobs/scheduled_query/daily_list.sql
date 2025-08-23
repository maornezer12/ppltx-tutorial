/*
list of top 100 most active users
in ppltx-app game

*/
--ppltx-m--tutorial-dev.fp_scheduled_query.daily_segment
--truncate table `ppltx-m--tutorial-dev.fp_scheduled_query.daily_segment`
--create or replace table `fp_scheduled_query.daily_segment`
--as
insert into `ppltx-m--tutorial-dev.fp_scheduled_query.daily_segment`
SELECT
  current_timestamp() as run_time,
  a as rn,
  LEFT(GENERATE_UUID(),8) AS uid,
  CAST(CEIL( 20 * RAND()) AS int64) AS level
FROM
  UNNEST(GENERATE_ARRAY(1, 100)) AS a