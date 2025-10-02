#!/bin/bash

#  ╔═══════════════════════════════════════════╗
#  ║ final project - Run daily log monitoring  ║
#  ╚═══════════════════════════════════════════╝

# Run the python script according to our configuration

cd ~/workspace/ppltx-tutorial/

# bash ~/workspace/bi/jobs/my_etl/scheduler/execute_log_monitoring.sh


python jobs/daily_kpis_etl/logs_monitoring.py ppltx-m--tutorial-dev --etl-name log --etl-action daily --days-back 2
