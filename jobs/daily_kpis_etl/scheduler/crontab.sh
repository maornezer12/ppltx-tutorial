#  ╔═══════════════════════════════════════════╗
#  ║ final project - All jobs - Run daily KPIs ║
#  ╚═══════════════════════════════════════════╝


# m h  dom mon dow   command
# Daily Aggregation
0 9 * * * bash ~/workspace/ppltx-tutorial/jobs/daily_kpis_etl/scheduler/execute_daily_kpis_etl.sh

# Daily logs monitor
10 9 * * * bash ~/workspace/ppltx-tutorial/jobs/daily_kpis_etl/scheduler/execute_log_monitoring.sh

# Daily KPIs monitor
15 9 * * * bash ~/workspace/ppltx-tutorial/jobs/daily_kpis_etl/scheduler/execute_kpi_monitoring.sh


# Ctrl x
# Y
# Enter