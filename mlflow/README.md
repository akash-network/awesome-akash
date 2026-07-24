# MLflow

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-mlflow)

MLflow is an open-source AI and ML platform for experiment tracking, model registry, artifact storage, and model lifecycle workflows.

## What this template deploys

This Akash SDL deploys:

- MLflow Tracking Server
- PostgreSQL backend store
- MinIO S3-compatible artifact store
- Caddy reverse proxy
- Persistent storage for PostgreSQL, MinIO, and MLflow working data

Public port:

- `80` — MLflow UI and Tracking API

Internal services:

- `mlflow:5000`
- `db:5432`
- `minio:9000`

## Architecture

MLflow uses PostgreSQL as the backend store for experiments, runs, metrics, params, tags, traces, and model registry metadata.

MinIO is used as an S3-compatible artifact store for run artifacts, models, plots, and other files.

The MLflow server runs with:

```bash
mlflow server \
  --backend-store-uri postgresql+psycopg2://mlflow:<password>@db:5432/mlflow \
  --serve-artifacts \
  --artifacts-destination s3://mlflow-artifacts
```

With `--serve-artifacts`, MLflow clients can upload artifacts through the MLflow Tracking Server instead of connecting directly to MinIO.

## Before deployment

Change these placeholder values in `deploy.yaml` before deploying:

```bash
CHANGE_ME_POSTGRES_PASSWORD
CHANGE_ME_MINIO_ACCESS_KEY
CHANGE_ME_MINIO_SECRET_KEY
```

Generate strong values, for example:

```bash
openssl rand -base64 32
```

Use the same MinIO values in both places:

```bash
AWS_ACCESS_KEY_ID=CHANGE_ME_MINIO_ACCESS_KEY
AWS_SECRET_ACCESS_KEY=CHANGE_ME_MINIO_SECRET_KEY
MINIO_ROOT_USER=CHANGE_ME_MINIO_ACCESS_KEY
MINIO_ROOT_PASSWORD=CHANGE_ME_MINIO_SECRET_KEY
```

## Storage

Default persistent storage sizes:

```bash
PostgreSQL data: 20Gi
MinIO artifacts: 50Gi
MLflow working data: 10Gi
```

The MinIO setup container creates this private bucket:

```bash
mlflow-artifacts
```

Artifacts are stored at:

```bash
s3://mlflow-artifacts
```

## Using MLflow

After deployment, open the public Akash URI in your browser.

To connect from Python:

```python
import mlflow

mlflow.set_tracking_uri("http://<akash-host>")
mlflow.set_experiment("akash-test")

with mlflow.start_run():
    mlflow.log_param("provider", "akash")
    mlflow.log_metric("score", 0.95)
```

To log a file artifact:

```python
import mlflow

mlflow.set_tracking_uri("http://<akash-host>")

with mlflow.start_run():
    with open("example.txt", "w") as f:
        f.write("hello from Akash")
    mlflow.log_artifact("example.txt")
```

## Notes

The MLflow container installs `psycopg2-binary` and `boto3` on startup so the official MLflow image can connect to PostgreSQL and MinIO.

The MinIO API and console are not exposed publicly in this template. MLflow is the public entrypoint.

For production deployments, consider adding authentication or placing MLflow behind a secured ingress/proxy.

