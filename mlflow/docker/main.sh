#!/usr/bin/env sh
set -eu

DB_HOST="${DB_HOST:-db}"
DB_PORT="${DB_PORT:-5432}"
POSTGRES_USER="${POSTGRES_USER:-mlflow}"
POSTGRES_DB="${POSTGRES_DB:-mlflow}"
MLFLOW_ARTIFACT_BUCKET="${MLFLOW_ARTIFACT_BUCKET:-mlflow-artifacts}"
AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"

if [ -z "${POSTGRES_PASSWORD:-}" ]; then
  echo "POSTGRES_PASSWORD is required"
  exit 1
fi

if [ -z "${MLFLOW_S3_ENDPOINT_URL:-}" ]; then
  echo "MLFLOW_S3_ENDPOINT_URL is required"
  exit 1
fi

if [ -z "${AWS_ACCESS_KEY_ID:-}" ]; then
  echo "AWS_ACCESS_KEY_ID is required"
  exit 1
fi

if [ -z "${AWS_SECRET_ACCESS_KEY:-}" ]; then
  echo "AWS_SECRET_ACCESS_KEY is required"
  exit 1
fi

BACKEND_STORE_URI="postgresql+psycopg2://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${DB_HOST}:${DB_PORT}/${POSTGRES_DB}"

export DB_HOST DB_PORT POSTGRES_USER POSTGRES_PASSWORD POSTGRES_DB
export MLFLOW_S3_ENDPOINT_URL AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION MLFLOW_ARTIFACT_BUCKET

echo "Waiting for PostgreSQL at ${DB_HOST}:${DB_PORT}..."
until python - <<'PY'
import os
import psycopg2
psycopg2.connect(
    host=os.environ["DB_HOST"],
    port=int(os.environ["DB_PORT"]),
    user=os.environ["POSTGRES_USER"],
    password=os.environ["POSTGRES_PASSWORD"],
    dbname=os.environ["POSTGRES_DB"],
).close()
PY
do
  sleep 3
done

echo "Waiting for MinIO bucket ${MLFLOW_ARTIFACT_BUCKET}..."
until python - <<'PY'
import os
import boto3
client = boto3.client(
    "s3",
    endpoint_url=os.environ["MLFLOW_S3_ENDPOINT_URL"],
    aws_access_key_id=os.environ["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key=os.environ["AWS_SECRET_ACCESS_KEY"],
    region_name=os.environ.get("AWS_DEFAULT_REGION", "us-east-1"),
)
client.head_bucket(Bucket=os.environ["MLFLOW_ARTIFACT_BUCKET"])
PY
do
  sleep 3
done

echo "Starting MLflow server..."
exec mlflow server \
  --host 0.0.0.0 \
  --port 5000 \
  --backend-store-uri "${BACKEND_STORE_URI}" \
  --serve-artifacts \
  --artifacts-destination "s3://${MLFLOW_ARTIFACT_BUCKET}"
