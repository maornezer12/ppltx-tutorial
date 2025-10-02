#!/bin/bash

#  ╔═══════════════════════════════════════════╗
#  ║ final project - Run daily Logs monitoring ║
#  ╚═══════════════════════════════════════════╝

# Run the python script according to our configuration

cd ~/workspace/ppltx-tutorial/

# bash ~/workspace/ppltx-tutorial/jobs/daily_kpis_etl/scheduler/execute_log_monitoring.sh

python jobs/daily_kpis_etl/logs_monitoring.py ppltx-m--tutorial-dev --etl-name log --etl-action daily --days-back 2
