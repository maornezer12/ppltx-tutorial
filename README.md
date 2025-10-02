# Daily KPIs ETL & Monitoring

This project is a complete **data engineering training pipeline**, designed as a hands-on exercise for BI developers.  
It demonstrates how to build a professional-grade ETL and monitoring framework, running on **Google Cloud Platform (GCP)**.

The pipeline covers the full lifecycle of **daily KPI management**:
- **ETL Layer**: Extracts data from source tables, transforms it into business-ready KPIs, and loads it into BigQuery datasets.  
- **Monitoring Layer**: Continuously validates the integrity of KPIs, identifying anomalies such as spikes or drops in daily metrics.  
- **Logs Monitoring Layer**: Ensures the ETL process itself is healthy and runs as expected.

### 🌐 Deployment & Automation
- The project is deployed in a **GCP development environment** (`ppltx-tutorial-dev`).  
- Tables are stored and maintained in **BigQuery**, serving as the central data warehouse.  
- A **cron-based scheduler (crontab)** is used to trigger the ETL and monitoring jobs automatically on a **daily basis**.  
- Each job execution is logged into a dedicated `logs.daily_logs` table for full transparency and debugging.  

---

This setup simulates a **real-world production-like workflow**: from raw data ingestion, through transformation and monitoring, to automated scheduling in the cloud.

---

##  Project Structure

```
jobs/
└── daily_kpis_etl/
    ├── daily_kpis_etl.py          # ETL runner
    ├── kpis_monitoring.py         # Monitoring runner (KPI anomalies)
    ├── logs_monitoring.py         # Monitoring runner (process health)
    ├── config/
    │   ├── daily_kpis_config.json # Config for ETL layer
    │   ├── kpis_config.json       # Config for Monitoring layer
    │   └── log_config.json        # Config for Logs Monitoring layer
    └── queries/
        ├── installs_etl.sql
        ├── last_activity_etl.sql
        ├── daily_user_panel_etl.sql
        ├── installs_monitor.sql
        ├── dau_monitor.sql
        ├── last_activity_monitor.sql
        └── etl_logs_monitor.sql
```

---

##  ETL Layer

The **ETL** layer creates the required KPI tables in BigQuery.

- **Config file:** `daily_kpis_config.json`  
- **SQL files:**  
  - `installs_etl.sql` → Creates the **installs** table (`install_date`).  
  - `last_activity_etl.sql` → Creates the **last_activity** table (`last_activity`).  
  - `daily_user_panel_etl.sql` → Creates the **daily_user_panel** table (`date`, `total_events`, `total_coins_added`).  

**Runner script:**  
```bash
python jobs/daily_kpis_etl/daily_kpis_etl.py <project_id> --etl-name daily_kpis --etl-action daily --days-back 1
```

---

##  Monitoring Layer

The **Monitoring** layer validates KPI data quality and detects anomalies (sudden changes).

- **Config file:** `kpis_config.json`  
- **SQL files:**  
  - `dau_monitor.sql` → Detects anomalies in DAU (daily active users).  
  - `installs_monitor.sql` → Detects anomalies in daily installs.  
  - `last_activity_monitor.sql` → Detects anomalies in last activity.  

Each query calculates a flag (`raise_flag`) if the KPI deviates by more than `{thresh_in_percent}` from the previous day.

**Runner script:**  
```bash
python jobs/daily_kpis_etl/kpis_monitoring.py <project_id> --etl-name kpis --etl-action daily
```

With `--dry-run`, the SQL files are generated but not executed.

---

##  Logs Monitoring Layer

The **Logs Monitoring** layer validates that ETL jobs actually run (process-level monitoring).  
It checks the job’s execution status inside the **`logs.daily_logs`** table.

- **Config file:** `log_config.json`  
- **SQL file:** `etl_logs_monitor.sql`  

**Runner script:**  
```bash
python jobs/daily_kpis_etl/logs_monitoring.py <project_id> --etl-name log --etl-action daily --days-back 2
```

---

##  Setup

1. Ensure Python 3.11+ is installed:
   ```bash
   python3 --version
   ```

2. Install required packages:
   ```bash
   pip install -r requirements.txt
   ```

3. Authenticate with Google Cloud:
   ```bash
   gcloud auth application-default login
   ```

---

##  Key Features

- **ETL automation**: Creates and maintains daily KPI tables in BigQuery.  
- **Monitoring**: Detects data anomalies (spikes/drops in DAU, installs, last activity).  
- **Logs validation**: Ensures the ETL jobs themselves are running regularly.  
- **Config-driven**: JSON config files define datasets, thresholds, and monitoring rules.  
- **Error handling**: Failures are logged into markdown files under `/temp/logs/`.  

---

##  Example Workflow

1. Run ETL job to build daily tables:
   ```bash
   python jobs/daily_kpis_etl/daily_kpis_etl.py ppltx-m--tutorial-dev --etl-name daily_kpis --etl-action daily
   ```

2. Run monitoring to validate KPIs:
   ```bash
   python jobs/daily_kpis_etl/kpis_monitoring.py ppltx-m--tutorial-dev --etl-name kpis --etl-action daily
   ```

3. Run logs monitoring to validate pipeline execution:
   ```bash
   python jobs/daily_kpis_etl/logs_monitoring.py ppltx-m--tutorial-dev --etl-name log --etl-action daily --days-back 2
   ```
