#!/bin/bash

#  ╔═══════════════════════════════════════════╗
#  ║ final project - Run daily Logs monitor    ║
#  ╚═══════════════════════════════════════════╝

# Run the python script according to our configuration

cd ~/workspace/ppltx-tutorial/

# bash ~/workspace/ppltx-tutorial/jobs/dwh_monitoring/scheduler/execute_log_monitoring.sh

python3 jobs/dwh_monitoring/logs_monitoring.py ppltx-m--tutorial-dev --etl-name log --etl-action daily

# python jobs/dwh_monitoring/logs_monitoring.py ppltx-m--tutorial-dev --etl-name log --etl-action daily
