# 🤖 Akash Trainer

**An openclaw-powered agent that let you train any ML/AI model on Akash GPUs with just a message. The agent would automate the whole training process. No setup. Just deploy.**

Point it at a GitHub repo → it clones, installs, trains on a GPU, and pushes results back to your repo + close the deployment automatically. 

---

## Quick Start

1. Go to [Akash Console](https://console.akash.network) → **New Deployment** → paste the `deploy.yaml`
2. Set three env vars:

| Variable | Example |
|----------|---------|
| `REPO_URL` | `https://github.com/you/your-project.git` |
| `TRAIN_CMD` | `python3 train.py` |
| `GITHUB_TOKEN` | Your token with `repo` scope ([create one here](https://github.com/settings/tokens)) |

3. Deploy → accept a bid → done

Your trained model and outputs appear on GitHub as a new branch: `trained-output/YYYYMMDD-HHMMSS`

---

## How It Works

```
You deploy on Akash
        ↓
  Clone your repo
        ↓
  Install all dependencies (auto-detected)
        ↓
  Verify GPU + CUDA works
        ↓
  Run your training command
        ↓
  Collect all new files (models, logs, metrics)
        ↓
  Push to GitHub as a new branch
        ↓
  Done. Close deployment.
```

**Supports:** PyTorch, TensorFlow, HuggingFace, JAX, and any Python ML framework. Private repos via `GITHUB_TOKEN`. Custom setup commands for anything else.

---

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `REPO_URL` | ✅ | GitHub repo URL |
| `TRAIN_CMD` | ✅ | Training command (e.g. `python3 train.py --epochs 50`) |
| `GITHUB_TOKEN` | Recommended | For auto-pushing results to GitHub |
| `REPO_BRANCH` | No | Branch to clone (default: `main`, falls back to `master`) |
| `SETUP_CMD` | No | Run before training (e.g. `pip3 install -e . && python3 download_data.py`) |
| `REQUIREMENTS` | No | Custom requirements file (default: `requirements.txt`) |

---

## Resource Guide

Pick the right size for your project:

| Project | CPU | RAM | GPU | Storage | Est. Cost |
|---------|-----|-----|-----|---------|-----------|
| MNIST / CIFAR demo | 4 | 8Gi | 1x any | 20Gi | ~$0.20-0.50 |
| ResNet / YOLO / standard CV | 8 | 16Gi | 1x RTX4090+ | 50Gi | ~$1-5 |
| LLM fine-tuning (LoRA) | 16 | 32Gi | 1x A100/H100 | 100Gi | ~$5-20 |

Edit the `profiles.compute` section in `deploy.yaml` to adjust.

---

## Optional: `akash.yaml`

Drop an `akash.yaml` in your repo root to customize training without changing the deployment:

```yaml
# All fields optional — only set what you need
train_cmd: python3 scripts/train.py --epochs 50 --lr 0.001
setup_cmd: pip3 install -e . && python3 scripts/download_data.py
requirements: requirements-gpu.txt
exclude:
  - data/raw/
  - "*.gz"
env:
  WANDB_API_KEY: "your-key"
  HF_TOKEN: "hf_xxx"
```

Without `akash.yaml`, the trainer auto-detects everything from your repo.

---

## What Gets Pushed to GitHub

A new branch `trained-output/YYYYMMDD-HHMMSS` containing:

- **`TRAINING_REPORT.md`** — duration, GPU used, files collected
- **`models/`** — saved model files
- **`output/`** — training outputs
- **All new files** created during training (except downloaded datasets and caches)

If training fails → `TRAINING_FAILED.md` with the last 20 lines of error log is pushed instead, so you can debug without opening the Akash dashboard.

Files over 100MB are auto-excluded (GitHub limit).

---

## Pre-installed

PyTorch 2.5.1 (CUDA 12.4) · TensorFlow · NumPy · Pandas · scikit-learn · matplotlib · OpenCV · W&B · TensorBoard · tqdm · rich

Your `requirements.txt` can add or override anything.

---

## Links

- **Docker Image:** [andyhuynh24/akash-trainer](https://hub.docker.com/r/andyhuynh24/akash-trainer)
- **Source:** [github.com/AndyHuynh24/AkashTrainer](https://github.com/AndyHuynh24/AkashTrainer)
- **Built by:** Andy Huynh — Akash Network Ambassador, UMass Amherst
