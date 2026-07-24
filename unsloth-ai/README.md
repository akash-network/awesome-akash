# Unsloth AI on Akash

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-unsloth-ai)

Deploy [Unsloth AI](https://unsloth.ai/) with GPU acceleration on Akash Network. This template runs Unsloth Studio (web UI for training and inference) alongside Jupyter Lab.

## Resources

- **Project:** https://unsloth.ai/
- **Docker Image:** https://hub.docker.com/r/unsloth/unsloth
- **Akash Deployments docs:** https://akash.network/docs/deployments/overview/

## Prerequisites

- Akash CLI installed and configured, or an Akash Console account.
- A funded Akash wallet with enough balance to bid and lease GPU-enabled providers.
- Provider(s) that advertise GPU capacity (NVIDIA A100/H100 recommended).
- (Optional) Persistent storage for model weights and datasets.

## Files

- `deploy.yaml` — Akash SDL for Unsloth AI with GPU support.
- `config.json` — Template metadata (logo).

## Quick Deployment Steps

1. Review `deploy.yaml` and adjust resources, pricing, and image tag as needed.
2. Deploy via Akash CLI:

   ```bash
   provider-services tx deployment create deploy.yaml --from <WALLET> --fees <fees>
   ```

   Or deploy via [Akash Console](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-unsloth-ai).

3. Once the lease is active, access the services:

| Endpoint | Service | Auth |
|----------|---------|------|
| `http://<akash-uri>:8888` | Jupyter Lab | Password: value of `JUPYTER_PASSWORD` |
| `http://<akash-uri>:8000` | Unsloth Studio | Setup on first visit |

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `JUPYTER_PASSWORD` | `unsloth` | Jupyter Lab login password |
| `JUPYTER_PORT` | `8888` | Jupyter Lab port |
| `USER_PASSWORD` | `unsloth2024` | Container user sudo password |
| `UNSLOTH_DOCKER` | `1` | Docker environment flag |
| `UNSLOTH_VLLM_STANDBY` | `1` | Enable vLLM standby mode |
| `HF_HOME` | `/workspace/.cache/huggingface` | HuggingFace cache directory |

**Change `JUPYTER_PASSWORD` and `USER_PASSWORD` before production use.**

## Architecture Notes

The SDL overrides the container's default `entrypoint.sh` with a custom command that:

1. Starts Jupyter Lab in the background on port 8888
2. Starts Unsloth Studio in the foreground on port 8000 (as PID 1)

This bypasses the image's sudo-based entrypoint, which is incompatible with Akash's `no-new-privileges` security policy. SSH is intentionally disabled for the same reason.

## Best Practices

- Pin container image tags for reproducible deployments. This template uses a specific version tag.
- Place persistent storage at `/workspace/work` for notebooks, datasets, and model exports.
- Start with 1 GPU and scale up after profiling your workload.
- Monitor GPU utilization and adjust CPU/memory accordingly.

## Troubleshooting

- **No providers match:** List providers and filter by GPU attributes (`vendor: nvidia`, model `a100`/`h100`).
- **Container crash loops:** Check lease logs for errors. The most common issue is missing GPU on the provider.
- **Can't access UI:** Verify both ports 8888 and 8000 are exposed and the lease endpoints resolve.

## Acknowledgements

- Thanks to the Akash community and Unsloth AI project for open tooling and guidance.
