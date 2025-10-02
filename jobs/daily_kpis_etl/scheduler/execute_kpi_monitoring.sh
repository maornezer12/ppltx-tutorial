#!/bin/bash

#  ╔═══════════════════════════════════════════╗
#  ║ final project - Run daily kpi monitoring  ║
#  ╚═══════════════════════════════════════════╝

# Run the python script according to our configuration

cd ~/workspace/ppltx-tutorial/

# bash ~/workspace/ppltx-tutorial/jobs/daily_kpis_etl/scheduler/execute_kpi_monitoring.sh

python jobs/daily_kpis_etl/kpis_monitoring.py ppltx-m--tutorial-dev --etl-name kpis --etl-action daily
