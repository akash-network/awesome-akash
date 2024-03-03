import os
# ray_address = os.environ['RAY_ADDRESS']
# ray_address = f"ray://{os.environ['RAY_ADDRESS_HOST']}:6380"
ray_address = f"{os.environ['RAY_ADDRESS_HOST']}:6380"
ray_address = f"{os.environ['RAY_ADDRESS_HOST']}:6380"
os.environ['RAY_ADDRESS'] = ray_address
print(f"using ray address: {ray_address }")
os.system(f"ray start --address={ray_address} --object-manager-port=8076 --node-manager-port=8077 --dashboard-agent-grpc-port=8078 --dashboard-agent-listen-port=8079 --min-worker-port=10002 --max-worker-port=10007 --block")
