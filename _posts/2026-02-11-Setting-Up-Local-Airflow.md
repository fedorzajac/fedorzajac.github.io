
---
layout: post
title:  "💨 Setting Up Airflow for local development"
date:   2026-02-11 10:05:53 +0100
categories: airflow python automation
---

### Setting up Airflow

Basically it is easy to just follow instructions on airflow [website](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html#docker-compose-env-variables).

```bash
# fetch docker compose
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/3.1.7/docker-compose.yaml'
# init dirs and airflow UID
mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env
# initialize airflow config
docker compose run airflow-cli airflow config list

# optional (if you are on linux)
volumes:
  - ${AIRFLOW_PROJ_DIR:-.}/dags:/opt/airflow/dags:z
  - ${AIRFLOW_PROJ_DIR:-.}/logs:/opt/airflow/logs:z
  - ${AIRFLOW_PROJ_DIR:-.}/config:/opt/airflow/config:z
  - ${AIRFLOW_PROJ_DIR:-.}/plugins:/opt/airflow/plugins:z
# no need on mac:
sudo chmod -R 777 ./config

# and initialize db
docker compose up airflow-init

# running:
docker compose up
# stopping
docker compose down --volumes --remove-orphans
```
However, this might not be sufficient. You might want to have your own dependencies, so update compose file:
```yaml
x-airflow-common:
  &airflow-common
    #...
    _PIP_ADDITIONAL_REQUIREMENTS: 'matplotlib pandas numpy rasterio geopandas'
    # jwt secret, to the services will communicato to each other
    AIRFLOW__API_AUTH__JWT_SECRET: '715b414d09ef6791693fbd9668e17323'
    #...
```

I believe no additional changes are necessary
