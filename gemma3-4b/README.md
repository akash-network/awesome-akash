# Gemma 3 4B

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-gemma3-4b)

Deploy Google's `gemma3:4b` on Akash with [Ollama](https://ollama.com) and expose the Ollama API on port `11434` (OpenAI-compatible at `/v1/chat/completions`).

## Model

- Ollama model tag: `gemma3:4b`
- Upstream: [google/gemma-3-4b-it](https://huggingface.co/google/gemma-3-4b-it)
- Size: ~3.3 GB (Q4_0 GGUF)
- Runtime: `ollama/ollama:0.13.4`
- API endpoints:
  - Native Ollama: `http://<your-akash-uri>:11434/api/generate`
  - OpenAI-compatible: `http://<your-akash-uri>:11434/v1/chat/completions`

## Why this template

Gemma 3 4B is in the sweet spot for low-cost Akash inference: small enough to fit on entry-level GPUs (or run on CPU), useful enough for agent workflows, JSON extraction, summarisation, and routing tasks. Ollama's built-in OpenAI-compatible endpoint lets you point any OpenAI SDK at this deployment with no code changes.

## Deployment

The included SDL uses:

- `1` NVIDIA GPU
- `4` vCPU
- `16Gi` RAM
- `50Gi` storage

Gemma 3 4B runs comfortably on consumer GPUs (e.g. RTX 2070 8GB, RTX 3060 12GB). Any Akash provider offering a single NVIDIA GPU with ≥6GB VRAM is sufficient.

The deployment runs:

```shell
ollama serve & while ! ollama pull gemma3:4b; do sleep 2.5; done
ollama list
pkill ollama
ollama serve
```

(pull-then-restart pattern ensures the model is in the blob cache before serving.)

## Customising the model

To deploy a different Ollama model, change the `MODEL` env var in `deploy.yaml` (e.g. `gemma3:12b`, `gemma3:27b`, `qwen2.5:7b`). Adjust `memory`, `storage`, and GPU VRAM accordingly.

## Files

- [deploy.yaml](deploy.yaml)
