#  ╔═══════════════════════════════════════════╗
#  ║ final project - All jobs - Run daily KPIs ║
#  ╚═══════════════════════════════════════════╝


# m h  dom mon dow   command
# Daily Aggregation
0 12 * * * bash ~/workspace/ppltx-tutorial/jobs/dwh_monitoring/scheduler/execute_daily_dwh_monitoring.sh

# Daily logs monitor
10 12 * * * bash ~/workspace/ppltx-tutorial/jobs/dwh_monitoring/scheduler/execute_log_monitoring.sh

# Daily KPIs monitor
15 12 * * * bash ~/workspace/ppltx-tutorial/jobs/dwh_monitoring/scheduler/execute_kpi_monitoring.sh


# Ctrl x
# Y
# Enter