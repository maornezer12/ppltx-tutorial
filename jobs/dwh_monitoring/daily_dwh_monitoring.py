#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Reference
https://cloud.google.com/bigquery/docs/listing-datasets
https://cloud.google.com/bigquery/docs/tables#get_information_about_tables
https://cloud.google.com/bigquery/docs/samples/bigquery-load-table-dataframe


Run Commands
python jobs/dwh_monitoring/daily_dwh_monitoring.py ppltx-m--tutorial-dev --etl-name dwh_monitoring --etl-action daily --days-back 1
python jobs/dwh_monitoring/daily_dwh_monitoring.py ppltx-m--tutorial-dev --etl-name dwh_monitoring --etl-action daily --dry-run


SELECT
    *
FROM
    logs.daily_logs
    ORDER BY ts DESC
    LIMIT 100

"""
from pathlib import Path
import os

import requests
import re
import sys
from datetime import datetime, timedelta, date
from google.cloud import bigquery
import argparse
import uuid
import platform
import pandas as pd

# adapt the env to Mac or windows
home = Path(os.path.expanduser("C:" if os.name == 'nt' else "~") + "/workspace")

# get repository name
repo_name = re.search(r"(.*)[/\\]workspace[/\\]([^/\\]+)", __file__).group(2)
repo_tail = re.search(r".*[/\\]" + repo_name + r"[/\\](.+)[/\\]", __file__).group(1)
sys.path.insert(0, str(home / f"{repo_name}/utilities/"))

from my_etl_files import readJsonFile, ensureDirectory, writeFile, readFile, header, get_paths, write_json_file
from df_to_string_table import format_dataframe_for_slack

bi_path, bi_auth, data_path, logs_path, folder_name = get_paths(repo_name, home, __file__, repo_tail)



def process_command_line(argv):
    if argv is None:
        argv = sys.argv[1:]
    # initialize the parser object:
    parser = argparse.ArgumentParser(description=__doc__,formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("project_id", choices=["ppltx-m--tutorial-dev", "bigquery-public-data","ppltx-m-tutorial-prod"],
                        help="Operation to perform. The arguments for each option are:Full_Load:   --date",
                        default="ppltx-m--tutorial-dev")
    parser.add_argument("--etl-action", choices=["init", "daily", "delete"], help="The action the etl job")
    parser.add_argument("--etl-name", help="The name of the etl job")
    parser.add_argument("--dry-run", help="if True don't execute the queries", action="store_true")
    parser.add_argument("--days-back", help="The number of days we want to go back",default=0)

    return parser, argparse.Namespace()


parser, flags = process_command_line(sys.argv[1:])
x = sys.argv[1:]
parser.parse_args(x, namespace=flags)

# define the project_id
project_id = flags.project_id
etl_name = flags.etl_name
etl_action = flags.etl_action
days_back = int(flags.days_back)

ensureDirectory(logs_path)
ensureDirectory(data_path)

# Construct a BigQuery client object.
client = bigquery.Client(project=project_id)

# Get dates
date_today = date.today()
run_time = datetime.now()
y_m_d = (date_today + timedelta(days=-days_back)).strftime("%Y-%m-%d")
ymd = y_m_d.replace("-", "")

step_id = 0
env_type = 'daily'
log_table = f"{project_id}.logs.daily_logs"
monitor_table = f"{project_id}.fp_daily_dwh_monitor.all_tables"

# init log dict
log_dict = {
    'ts': datetime.now(),
    'dt': datetime.now().strftime("%Y-%m-%d"),
    'uid': str(uuid.uuid4())[:8],
    'username': platform.node(),
    'job_name': etl_name,
    'job_type': etl_action,
    'file_name': os.path.basename(__file__),
    'step_name': 'start',
    'step_id': step_id,
    'log_type': env_type,
    'message': str(x)
}

# functions
def set_log(log_dict, step, log_table=log_table):
    log_dict['step_name'] = step
    log_dict['step_id'] += 1
    log_dict['ts'] = datetime.now()
    log_dict['dt'] = datetime.now().strftime("%Y-%m-%d")
    job = client.load_table_from_dataframe(pd.DataFrame(log_dict, index=[0]), log_table)
    job.result()  # Wait for the job to complete.


if not flags.dry_run:
    set_log(log_dict, "start")

# list for a project metadata
project_list = []

datasets = list(client.list_datasets())  # Make an API request.
if datasets:
    header(f"Datasets in project`{project_id}`:")
    for dataset in datasets:
        print(f"\n📁 '{dataset.dataset_id}'")

        dataset_id = f"{project_id}.{dataset.dataset_id}"
        tables = list(client.list_tables(dataset_id))  # Make an API request.

        if not tables:
            print(f"📍 ️No tables found in dataset '{dataset.dataset_id}'.")
            continue  # Move to the next dataset

        # Iterate all the Tables in the project
        print(f"📊 Tables contained in '{dataset.dataset_id}':")
        for table in tables:
            table_id = f"{table.project}.{table.dataset_id}.{table.table_id}"
            print(f"- {table.table_id}")

            table_info = client.get_table(table_id)  # Make an API request.

            table_dict = {
                "run_time": run_time,
                "date": y_m_d,
                "name": table_id,
                "project": table.project,
                "dataset_id": table.dataset_id,
                "table_id": table.table_id,
                "created": table_info.created,
                "modified": table_info.modified,
                "location": table_info.location,
                "table_type": table_info.table_type,
                "num_rows": table_info.num_rows,
                "num_bytes": table_info.num_bytes
            }
            project_list.append(table_dict)
else:
    print(f"📍️'{project_id}'project does not contain any datasets.")

# create dataframe from a list
header("project_list")
tables_metadata = pd.DataFrame(project_list)

write_json_file(project_list,data_path / f"{project_id}_all_tables.json" )

# Load data into table
header("Load data into table")
if not flags.dry_run:
    set_log(log_dict, "load")

job = client.load_table_from_dataframe(tables_metadata, monitor_table)
job.result()  # Wait for the job to complete.


if not flags.dry_run:
    set_log(log_dict, "end")