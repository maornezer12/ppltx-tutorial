# VM set up
Follow the instructions step by step


## Connect VM via ssh
[Go to the VM menu](https://console.cloud.google.com/compute/instances)<br>
Turn the VM on (Start)
Click on the SSH connection

## Set up crontab
run the command and<br> 
select 1
```dtd
crontab -e
```


## Set up credentials
for gcloud environment
```dtd
gcloud auth login
```


## Your identity can be used as a proxy to test code calling APIs from that machine.
Credentials saved to file: [/home/your_username/.config/gcloud/application_default_credentials.json]
```dtd
gcloud auth application-default login
```

## View server config:
```dtd
gcloud config list
```


## Install pip3
Preferred Installer Program
```dtd
sudo apt-get -y install python3-pip
```


## Install git
```dtd
sudo apt-get update
sudo apt-get install git
```
where can we find our git
```dtd
which git
```

## Git Configuration
```dtd
git config --global alias.co commit
git config --global alias.br branch
git config --global alias.ch checkout
git config --global alias.st status
```
To save Git credentials
```dtd
git config --global credential.helper cache
```

## Review all programs version
```dtd
pip3 list
```


## Update python api client
```dtd
sudo pip3 install --upgrade google-api-python-client
```

## Install BigQuery & Cloud Storage
```dtd
sudo pip3 install --upgrade google-cloud-bigquery
sudo pip3 install --upgrade google-cloud-storage
```

## in case of errors use  --break-system-packages
```dtd
sudo pip3 install --upgrade google-api-python-client --break-system-packages
sudo pip3 install --upgrade google-cloud-bigquery --break-system-packages
sudo pip3 install --upgrade google-cloud-storage --break-system-packages
```

## Create directories
```dtd
mkdir -p workspace/auth
mkdir -p workspace/temp/data
mkdir -p workspace/temp/logs
```

## pip3 install packages
```dtd
pip3 install pandas --break-system-packages
pip3 install numpy --break-system-packages
pip3 install boto3 --break-system-packages
pip3 install db-dtypes --break-system-packages
```

## Copy python-bigquery repository
```dtd
cd workspace
git clone https://github.com/googleapis/python-bigquery.git
```

[Tutorial on creating a token and clone you repository to VM](https://youtu.be/6s_iMLHUvCI?si=LWOqWRnF6ZU0Swvc)