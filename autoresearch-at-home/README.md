# Autoresearch-at-Home on Akash

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-autoresearch-at-home)

[Autoresearch-at-home](https://github.com/mutable-state-inc/autoresearch-at-home) is the collaborative, multi-agent fork of Andrej Karpathy's [autoresearch](https://github.com/karpathy/autoresearch). Instead of a single agent experimenting in isolation, multiple agents running on different GPUs form a research swarm — sharing results, avoiding duplicate work, and collectively optimizing a small LLM overnight.

Inspired by [Karpathy's vision](https://x.com/karpathy/status/2030705271627284816):

> *"The next step for autoresearch is that it has to be asynchronously massively collaborative for agents. The goal is not to emulate a single PhD student, it's to emulate a research community of them."*

## How It Works

The core loop is the same as vanilla autoresearch — an AI agent edits `train.py`, runs a 5-minute training experiment, keeps improvements, reverts failures, and repeats. What this fork adds is a coordination layer through [Ensue](https://ensue-network.ai) shared memory:

- **`prepare.py`** — One-time data prep: downloads training data and trains a BPE tokenizer. Never modified.
- **`train.py`** — The single file the agent edits. Full GPT model, optimizer, and training loop.
- **`program.md`** — Human-written instructions for the agent (solo mode).
- **`collab.md`** — Collaborative swarm protocol. Agents read this to join the community run.
- **`coordinator.py`** — Ensue integration: handles experiment claiming, result publishing, and global best syncing.

Training always runs for a **fixed 5-minute wall-clock budget** (~12 experiments/hour, ~100 overnight). The metric is **val_bpb** (validation bits per byte) — lower is better.

## Swarm Coordination

When `ENSUE_API_KEY` is set, your agent joins the shared research swarm:

1. **THINK** — pulls the global best config and reviews what others have already tried
2. **CLAIM** — claims an experiment before starting (semantic dedup prevents duplicates)
3. **RUN** — edits `train.py`, trains for 5 minutes, checks val_bpb
4. **PUBLISH** — publishes the full result including source so others can build on it

If the Ensue network is unreachable, agents fall back to solo mode automatically.

## Resources

- Project: https://github.com/mutable-state-inc/autoresearch-at-home
- Upstream: https://github.com/karpathy/autoresearch
- Ensue Network: https://ensue-network.ai
- Akash Deployments docs: https://akash.network/docs/deployments/overview/

## Prerequisites

- An Akash wallet with sufficient balance for GPU-enabled providers.
- A provider with NVIDIA H100 or A100 GPU availability.
- An SSH public key for connecting to the deployment.
- (Optional) An Ensue API key to join the community research swarm.

## What This Deployment Does

1. Pulls the `nvidia/cuda:12.6.3-devel-ubuntu24.04` base image.
2. Installs `openssh-server`, `uv` (Python package manager), and clones the autoresearch-at-home repo.
3. Runs `uv sync` to install all dependencies (PyTorch, etc.).
4. Runs `prepare.py` to download training data and train the BPE tokenizer (one-time, cached to persistent storage).
5. If `ENSUE_API_KEY` is set, writes it to `.autoresearch-key` and enables collaborative mode.
6. Starts an SSH server — you connect and run the agent loop yourself.

Monitor progress via deployment logs in the Akash Console.

## Deploying

1. Open [deploy.yaml](deploy.yaml) and paste your SSH public key into the `SSH_PUBKEY` environment variable.
2. (Optional) Get a free Ensue API key at [ensue-network.ai/autoresearch](https://www.ensue-network.ai/autoresearch) and paste it into `ENSUE_API_KEY`.
3. Deploy on Akash using the Console or CLI.
4. Once setup completes (watch logs for `Environment ready`), SSH into the deployment:
   ```bash
   ssh root@<PROVIDER_HOST> -p <EXPOSED_PORT>
   ```
5. Point your AI agent (Claude Code, Codex, etc.) at the environment and prompt it with:
   - **Solo mode:** `Have a look at program.md and let's kick off a new experiment!`
   - **Collaborative mode:** `Have a look at collab.md and join the research swarm.`
6. Edit `program.md` (or let the agent read `collab.md`) to steer research direction, then let it run.

## Notes

- The first startup takes several minutes as it installs dependencies and downloads training data.
- Subsequent restarts reuse persistent storage — data prep is skipped.
- The agent works on a git feature branch and accumulates commits as it finds improvements.
- Multiple Akash deployments with the same `ENSUE_API_KEY` will automatically collaborate as a swarm.
- You can adjust GPU model preferences, memory, and storage in the SDL as needed.