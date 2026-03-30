# Autoresearch on Akash

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-autoresearch)

[Autoresearch](https://github.com/karpathy/autoresearch) by Andrej Karpathy is an autonomous AI research framework. It gives an AI agent a small but real LLM training setup and lets it experiment autonomously — modifying code, training for 5 minutes, checking if the result improved, keeping or discarding, and repeating.

## How It Works

- **`prepare.py`** — One-time data prep: downloads training data and trains a BPE tokenizer.
- **`train.py`** — The single file the agent edits. Contains the full GPT model, optimizer, and training loop.
- **`program.md`** — Instructions for the AI agent. The human iterates on this file.

Training runs for a **fixed 5-minute wall-clock budget**. The metric is **val_bpb** (validation bits per byte) — lower is better.

## Resources

- Project: https://github.com/karpathy/autoresearch
- Akash Deployments docs: https://akash.network/docs/deployments/overview/

## Prerequisites

- An Akash wallet with sufficient balance for GPU-enabled providers.
- A provider with NVIDIA H100 or A100 GPU availability.
- An SSH public key for connecting to the deployment.

## What This Deployment Does

1. Pulls the `nvidia/cuda:12.6.2-devel-ubuntu22.04` base image.
2. Installs `openssh-server`, `uv` (Python package manager), and clones the autoresearch repo.
3. Runs `uv sync` to install all dependencies (PyTorch, etc.).
4. Runs `prepare.py` to download and prepare training data.
5. Starts an SSH server — you connect and run the agent loop yourself.

## Deploying

1. Open [deploy.yaml](deploy.yaml) and paste your SSH public key into the `SSH_PUBKEY` environment variable.
2. Deploy on Akash using the Console or CLI.
3. Once the lease is active and setup completes (watch logs for `Environment ready`), SSH into the deployment:

   ```bash
   ssh root@<PROVIDER_HOST> -p <EXPOSED_PORT>
   ```

4. Start the autonomous agent loop:

   ```bash
   cd /workspace/autoresearch
   uv run train.py  # single manual run to verify setup
   ```

5. To run the full autonomous loop, point your AI agent (Claude Code, Codex, etc.) at the environment and prompt it with:

   ```
   Hi have a look at program.md and let's kick off a new experiment! let's do the setup first.
   ```

6. Edit `program.md` to steer the agent's research direction, then let it continue experimenting.

## Notes

- The first startup takes several minutes as it installs dependencies and downloads training data.
- Subsequent runs on persistent storage will be faster since the data is cached.
- The agent works on a git feature branch and accumulates commits as it finds improvements.
- You can adjust GPU model preferences, memory, and storage in the SDL as needed.
