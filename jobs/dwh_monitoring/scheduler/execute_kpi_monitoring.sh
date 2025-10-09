#!/bin/bash

#  ╔═══════════════════════════════════════════╗
#  ║ final project - Run daily kpi monitoring  ║
#  ╚═══════════════════════════════════════════╝

# Run the python script according to our configuration

cd ~/workspace/ppltx-tutorial/

# bash ~/workspace/ppltx-tutorial/jobs/dwh_monitoring/scheduler/execute_kpi_monitoring.sh

python3 jobs/dwh_monitoring/kpis_monitoring.py ppltx-m--tutorial-dev --etl-name kpis --etl-action daily
# python jobs/dwh_monitoring/kpis_monitoring.py ppltx-m--tutorial-dev --etl-name kpis --etl-action daily
