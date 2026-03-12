# Autoresearch on Akash

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-autoresearch)

[Autoresearch](https://github.com/karpathy/autoresearch) by Andrej Karpathy is an autonomous AI research framework. It gives an AI agent a small but real LLM training setup and lets it experiment autonomously — modifying code, training for 5 minutes, checking if the result improved, keeping or discarding, and repeating.

## How It Works

- **`prepare.py`** — One-time data prep: downloads training data and trains a BPE tokenizer.
- **`train.py`** — The single file the agent edits. Contains the full GPT model, optimizer, and training loop.
- **`program.md`** — Instructions for the AI agent.

Training runs for a **fixed 5-minute wall-clock budget**. The metric is **val_bpb** (validation bits per byte) — lower is better.

## Resources

- Project: https://github.com/karpathy/autoresearch
- Akash Deployments docs: https://akash.network/docs/deployments/overview/

## Prerequisites

- An Akash wallet with sufficient balance for GPU-enabled providers.
- A provider with NVIDIA H100 or A100 GPU availability.

## What This Deployment Does

1. Pulls the `nvidia/cuda:12.6.3-devel-ubuntu24.04` base image.
2. Installs `uv` (Python package manager) and clones the autoresearch repo.
3. Runs `uv sync` to install all dependencies (PyTorch, etc.).
4. Runs `prepare.py` to download and prepare training data.
5. Runs `train.py` to execute a single 5-minute training experiment.

Monitor progress via deployment logs in the Akash Console.

## Deploying

Use the [deploy.yaml](deploy.yaml) SDL to deploy on Akash. You can adjust GPU model preferences, memory, and storage in the SDL as needed.

## Notes

- The first startup takes several minutes as it installs dependencies and downloads training data.
- Subsequent runs on persistent storage will be faster since the data is cached.
- For autonomous agent mode, you would connect an AI agent (Claude, Codex, etc.) to the running environment and point it at `program.md`.
