# Qwen3.5-27B

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-Qwen3.5-27B)

Deploy `Qwen/Qwen3.5-27B` on Akash with `vllm/vllm-openai:nightly-c86b17cfe663afb46a46b8081e9fd4c81dc920a2` and expose an OpenAI-compatible API on port `8000`.

## Model

- Hugging Face model: `Qwen/Qwen3.5-27B`
- Runtime: `vllm/vllm-openai:nightly-c86b17cfe663afb46a46b8081e9fd4c81dc920a2`
- API endpoint: `http://<your-akash-uri>:8000/v1`

## Deployment

This template runs the following command:

```shell
vllm serve Qwen/Qwen3.5-27B --host 0.0.0.0 --port 8000 --dtype bfloat16 --max-model-len 8192 --gpu-memory-utilization 0.92 --trust-remote-code
```

The included SDL uses:

- `1` NVIDIA GPU
- `8` vCPU
- `32Gi` RAM
- `200Gi` storage

Use an `H100` or `A100` provider when deploying this template.

## Files

- [deploy.yaml](deploy.yaml)
- [config.json](config.json)
