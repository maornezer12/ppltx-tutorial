
from google.cloud import bigquery

# Construct a BigQuery client object.
client = bigquery.Client(project="ppltx-m--tutorial-dev")
print(client.project)
datasets = list(client.list_datasets())  # Make an API request.
project = client.project

if datasets:
    print("Datasets in project {}:".format(project))
    for dataset in datasets[:3]:
        print("\t{}".format(dataset.dataset_id))
else:
    print("{} project does not contain any datasets.".format(project))

