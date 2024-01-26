import os

S3_ENDPOINT_URL = os.environ['S3_ENDPOINT_URL']
print(f"using init S3_ENDPOINT_URL: {S3_ENDPOINT_URL }")
S3_ENDPOINT_URL = f"{os.environ['S3_ENDPOINT_URL']}:9000"
os.environ['S3_ENDPOINT_URL'] = S3_ENDPOINT_URL
print(f"using S3_ENDPOINT_URL: {S3_ENDPOINT_URL }")
os.system(f"ray start  --head --port=6380 --dashboard-port=8265 --dashboard-host=0.0.0.0 --object-manager-port=8076 --node-manager-port=8077 --dashboard-agent-grpc-port=8078 --dashboard-agent-listen-port=8079 --min-worker-port=10002 --max-worker-port=10005 --block")
