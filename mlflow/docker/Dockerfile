FROM ghcr.io/mlflow/mlflow:v3.3.2

RUN python -m pip install --no-cache-dir psycopg2-binary boto3
COPY main.sh /usr/local/bin/start-mlflow.sh
RUN chmod +x /usr/local/bin/start-mlflow.sh

ENTRYPOINT ["/usr/local/bin/start-mlflow.sh"]
