#!/usr/bin/env bash

#  ╔═══════════════════════════════════════════╗
#  ║    final project - Run daily logs monitor ║
#  ╚═══════════════════════════════════════════╝

# Run the python script according to our configuration

cd ~/workspace/ppltx-tutorial/

# bash ~/workspace/ppltx-tutorial/jobs/daily_kpis_etl/scheduler/execute_daily_kpis_etl.sh

python jobs/daily_kpis_etl/daily_kpis_etl.py ppltx-m--tutorial-dev --etl-name daily_kpis --etl-action daily

# bq head -n=5  ppltx-m--tutorial-dev:fp_daily_kpis_etl.daily_user_panel
