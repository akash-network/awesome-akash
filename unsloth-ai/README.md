# Unsloth AI on Akash

This folder contains an example Akash SDL to deploy Unsloth AI with GPU acceleration.

Resources
- Project: https://unsloth.ai/
- Akash Deployments docs: https://akash.network/docs/deployments/overview/

Prerequisites
- Akash CLI installed and configured for your wallet and network (see Akash docs).
- A funded Akash wallet with enough balance to bid and lease GPU-enabled providers.
- Provider(s) that advertise GPU capacity (NVIDIA recommended).
- (Optional) Persistent storage for model weights (Akash persistent volumes or external S3-compatible bucket).

Files
- `deploy.yaml` — Example Akash SDL (GPU-enabled) for Unsloth AI.
- `config.json` — Optional metadata (logo, name) used by the showcase.

Quick deployment steps
1. Review `deploy.yaml` and adjust resources, pricing, and image tag as needed.
2. If you need persistent model storage, mount a persistent volume and set `MODEL_CACHE_PATH` accordingly.
3. Create a deployment with the Akash CLI (adapt to your CLI version):

   akash tx deployment create deploy.yaml --from <WALLET> --fees <fees>

   Follow the normal Akash workflow to accept provider bids and create a lease.
4. Once the lease is active you can reach the service on the exposed port (default: 8080). Use port forwarding or the provider's public endpoint if available.

Environment variables used in `deploy.yaml`
- `PORT` — HTTP port Unsloth listens on (default: `8080`).
- `UNSLOTH_MODEL` — Model selection (example: `auto` or a specific model name).
- `UNSLOTH_WORKERS` — Number of worker processes.
- `MODEL_CACHE_PATH` — Path used by Unsloth to cache/persist model weights. Mount to persistent storage if desired.

Best practices
- Use GPU-enabled providers and ensure placement attributes match (e.g., `vendor: nvidia`).
- Pin container image tags (avoid `:latest`) for reproducible deployments in production.
- Place large model weights on persistent storage to avoid repeated downloads.
- Start with conservative CPU/memory requests and scale up after profiling.
- Use secure network gateways or reverse proxies if exposing the service publicly.

Troubleshooting
- If the deployment does not match any provider, list providers and filter by GPU attributes.
- Inspect lease logs to debug model download or runtime issues.

Notes
- The provided SDL is an example. Adjust resource sizes, pricing, and environment variables to match your workload and provider marketplace.

Acknowledgements
- Thanks to the Akash community and Unsloth AI project for open tooling and guidance.

