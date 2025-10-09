#!/usr/bin/env bash

#  ╔═══════════════════════════════════════════╗
#  ║final project - Run daily dwh_monitoring   ║
#  ╚═══════════════════════════════════════════╝

# Run the python script according to our configuration

cd ~/workspace/ppltx-tutorial/

# bash ~/workspace/ppltx-tutorial/jobs/dwh_monitoring/scheduler/execute_daily_dwh_monitoring.sh

python3 jobs/dwh_monitoring/daily_dwh_monitoring.py ppltx-m--tutorial-dev --etl-name dwh_monitoring --etl-action daily --dry-run

# python3 jobs/dwh_monitoring/daily_dwh_monitoring.py ppltx-m--tutorial-dev --etl-name dwh_monitoring --etl-action daily --days-back 1
# python jobs/dwh_monitoring/daily_dwh_monitoring.py ppltx-m--tutorial-dev --etl-name dwh_monitoring --etl-action daily --days-back 1

