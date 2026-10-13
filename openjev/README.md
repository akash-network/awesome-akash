# OpenJev

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-openjev)

<!-- markdownlint-disable first-line-h1 -->
<!-- markdownlint-disable html -->
<!-- markdownlint-disable no-duplicate-header -->

<div align="center" style="line-height: 1;">
  <a href="https://github.com/cmcclellan79/openjev" target="_blank" style="margin: 2px;">
    <img alt="GitHub" src="https://img.shields.io/badge/GitHub-OpenJev-181717?logo=github&logoColor=white" style="display: inline-block; vertical-align: middle;"/>
  </a>
  <a href="https://huggingface.co/nvidia/diffusiongemma-26B-A4B-it-NVFP4" target="_blank" style="margin: 2px;">
    <img alt="Hugging Face" src="https://img.shields.io/badge/%F0%9F%A4%97%20Hugging%20Face-DiffusionGemma%2026B--A4B-ffc107?color=ffc107&logoColor=white" style="display: inline-block; vertical-align: middle;"/>
  </a>
  <a href="https://hub.docker.com/r/razorback16/openjev" target="_blank" style="margin: 2px;">
    <img alt="Docker Hub" src="https://img.shields.io/badge/Docker-razorback16%2Fopenjev-2496ed?logo=docker&logoColor=white" style="display: inline-block; vertical-align: middle;"/>
  </a>
</div>

<div align="center" style="line-height: 1;">
  <a href="https://codiv.ai" target="_blank" style="margin: 2px;">
    <img alt="Homepage" src="https://img.shields.io/badge/Homepage-Codiv-4c8bf5?color=4c8bf5&logoColor=white" style="display: inline-block; vertical-align: middle;"/>
  </a>
  <a href="https://github.com/cmcclellan79/openjev/blob/main/LICENSE" style="margin: 2px;">
    <img alt="License" src="https://img.shields.io/badge/License-Apache%202.0-f5de53?&color=f5de53" style="display: inline-block; vertical-align: middle;"/>
  </a>
</div>

<p align="center">
  <b>Fast, calibrated, typed decisions from an open model, running on your own Akash lease.</b>
</p>

## 1. Introduction

OpenJev is an open-source "System One" decision server. You give it a piece of state and a set of typed questions — yes/no, multiple choice, or a score — and it answers every one of them with a probability and a confidence value, usually in tens of milliseconds. Questions can also ask about images.

The answers are read straight off the model's token probabilities rather than written as text and parsed back, so a reply cannot come back off-schema and the confidence comes from the model's own distribution instead of a number it reports about itself.

OpenJev speaks the same wire API as TypeSafe's Jev, so SDKs written against that API work unchanged. It serves text generation too, on an OpenAI-compatible `/v1/chat/completions`, from the same GPU memory. It is an independent project, not affiliated with or endorsed by TypeSafe AI.

This template deploys the prebuilt `razorback16/openjev:0.3.0` image, which carries vLLM and the API server in one container and serves DiffusionGemma 26B-A4B (NVFP4, Apache-2.0).

## 2. API Summary

---

| Endpoint | What it does |
| --- | --- |
| `POST /v1/systemone` | `{state, model, questions}` in, `{model, answers, usage}` out |
| `POST /v1/chat/completions` | OpenAI-style text generation with model `diffusiongemma-26b` |
| `GET /v1/models` | lists `openjev-0.1` and `openjev-latest`; also accepts `jev-latest` and `jev-preview` so TypeSafe SDK defaults work |

**Question types**

- **`noul`** — yes/no. Optional `criteria: {true, false}`. Returns the probability of yes.
- **`choice`** — takes `criteria: {name: description}` and returns the chosen name, the full distribution, and a confidence.
- **`score`** — takes an ordered list of 2 to 10 levels and returns the expected level, the legend, the distribution, and a confidence.

Confidence is `1 − H(p)/ln K`: 1 when the model is certain, 0 when the distribution is flat.

---

**Optional extensions**

These fields are OpenJev's own additions. Leave them out and a request behaves exactly like Jev.

| Field | What it does |
| --- | --- |
| `images` | up to 8 images the questions ask about, as data URLs |
| `steps` | 1 to 8 denoise steps per read, so answers settle against each other |
| `samples` | read N times with different noise and average |
| `think` | let the model write a thought first, up to a hard token cap, then read |
| `sequential` | answer long question lists in order, each chunk seeing earlier answers |

## 3. How It Works

DiffusionGemma is a discrete diffusion model: it denoises a whole canvas of tokens per forward pass instead of generating left to right. OpenJev builds a canvas where the only masked tokens are the answer slots, one per question, and every possible label is a single token.

```
canvas in              one read-only pass       answer out
  q1: [?]      ──►     P(yes) 0.001      ──►    noul  0.001
  q2: [?]              P(A) 0.000               choice "billing"
                       P(B) 0.999               confidence 0.997
                       P(C) 0.000
  q3: [?]              P(0) 0.000               score 1.00
                       P(1) 0.996
                       P(2) 0.004
```

The model never writes into those slots. One read-only pass returns a probability distribution over each of them, and that distribution is the answer. If any slot comes back uncertain, the server re-reads with fresh noise and averages, up to four times. Your question ids never reach the model; it sees `q1`, `q2`, `q3`.

## 4. Deploy on Akash

### Before you deploy

**Pick a Blackwell GPU.** The checkpoint is NVFP4, and native FP4 is a Blackwell feature. The SDL asks for `pro6000se`, `pro6000we`, or `pro6000mq` — the RTX PRO 6000 Blackwell Server, Workstation, and Max-Q editions, 96 GB each. An H100 or A100 can win the bid and then fail to load the quantization, so don't widen the list to older cards. A 32 GB RTX 5090 is also Blackwell: add `- model: rtx5090` and lower `OPENJEV_MAX_MODEL_LEN` to around `16384`.

**Check the driver.** The image is built on CUDA 13, which needs a host driver in the r580 line or newer, and you can't see a provider's driver version before leasing. If it's too old the logs show a CUDA driver error within the first minute — close the lease and try another provider rather than debugging it.

**Get a Hugging Face token.** Accept the model licence on Hugging Face and put a token in `HF_TOKEN`. Without it the weight download fails with a 401 and vLLM never finishes starting.

**Set an API key.** Your lease gets a public URI and the server is open by default. Put a long random string in `OPENJEV_API_KEY` before deploying.

### Steps

1. Open the [Akash Console](https://console.akash.network) and create a new deployment, or use the Deploy on Akash button above.
2. Paste in `deploy.yaml` and edit the values marked `CHANGE ME`.
3. Accept a bid from a provider offering an RTX PRO 6000 Blackwell.
4. Watch the logs. The weights are about 18 GB and download on first start, so expect 10 to 20 minutes before the API answers. The line `openjev: waiting for vLLM to load` means it is still starting, not stuck.

General instructions for deploying SDL files are in the [deployment overview](https://akash.network/docs/developers/deployment/#overview).

### Resources

| Resource | Amount | Notes |
| --- | --- | --- |
| GPU | 1 × RTX PRO 6000 Blackwell | `pro6000se`, `pro6000we`, or `pro6000mq` |
| CPU | 8 | |
| Memory | 64Gi | |
| Ephemeral storage | 100Gi | the image itself is large |
| Persistent storage | 300Gi at `/root/.cache` | model weights and vLLM compile cache |
| Shared memory | 16Gi at `/dev/shm` | stands in for compose's `ipc: host` |

The persistent volume saves a redeploy from downloading and recompiling everything again, but it narrows the pool of providers. If no bids arrive, remove the `data` volume from the compute profile and its entry under `params.storage`.

## 5. Using It

```bash
export OPENJEV_URL=https://<your-lease-uri>
export OPENJEV_KEY=<the key you set>

curl $OPENJEV_URL/v1/models -H "Authorization: Bearer $OPENJEV_KEY"
```

Ask a question:

```bash
curl $OPENJEV_URL/v1/systemone \
  -H "Authorization: Bearer $OPENJEV_KEY" -H "Content-Type: application/json" \
  -d '{"model": "openjev-latest", "state": "I was charged twice this month.",
       "questions": {"is_billing": {"type": "noul", "instructions": "Is this a billing issue?"}}}'
```

Or point the TypeSafe SDK at your lease:

```bash
pip install typesafe-sdk
export TYPESAFE_BASE_URL=$OPENJEV_URL
export TYPESAFE_API_KEY=$OPENJEV_KEY
```

The same lease answers OpenAI-style requests with model `diffusiongemma-26b`:

```python
from openai import OpenAI

client = OpenAI(base_url="https://<your-lease-uri>/v1", api_key="<the key you set>")
r = client.chat.completions.create(
    model="diffusiongemma-26b",
    messages=[{"role": "user", "content": "Summarize: 3 nonstop flights, cheapest $212 on Delta."}],
)
print(r.choices[0].message.content)
```

Generation denoises in 64-token blocks, so it costs far more GPU time than a decision read. At most 8 generations run at once, so they never crowd out reads.

## 6. Settings

The SDL sets a handful of environment variables. The image supports more; these are the ones worth knowing.

| Variable | In this SDL | Meaning |
| --- | --- | --- |
| `OPENJEV_API_KEY` | you set it | require `Authorization: Bearer <key>` |
| `HF_TOKEN` | you set it | Hugging Face token for the weight download |
| `OPENJEV_MAX_MODEL_LEN` | `32768` | vLLM `--max-model-len`; lower it on smaller cards |
| `OPENJEV_GPU_UTIL` | `0.9` | vLLM `--gpu-memory-utilization` |
| `OPENJEV_MAX_NUM_SEQS` | `64` | concurrent sequences in vLLM |
| `OPENJEV_CANVAS` | `64` | diffusion canvas length |
| `OPENJEV_MAX_INFLIGHT` | `64` | reads in flight before requests queue |
| `OPENJEV_UPSTREAM` | unset | point at a vLLM server you already run; the container then skips its own |
| `OPENJEV_WARMUP` | `1` | `0` opens the API before the warmup requests finish |

## 7. Running Your Own Build

Akash pulls prebuilt images, so if you change anything under `openjev/` in the repo, build and push to a public registry, then swap the tag in `deploy.yaml`:

```bash
git clone https://github.com/cmcclellan79/openjev && cd openjev
docker build -f docker/Dockerfile -t ghcr.io/<you>/openjev:dev .
docker push ghcr.io/<you>/openjev:dev
```

## 8. Troubleshooting

| Symptom | Likely cause |
| --- | --- |
| CUDA driver error at startup | the provider's driver is older than CUDA 13 needs; try another provider |
| 401 or a stalled download | `HF_TOKEN` missing, or the model licence not accepted on that account |
| `openjev: vLLM exited during startup` | not enough GPU memory; lower `OPENJEV_MAX_MODEL_LEN` or `OPENJEV_GPU_UTIL` |
| No bids | few providers have Blackwell cards; raise the price or drop the persistent volume |
| Requests hang right after deploy | still loading and warming up; check `/health` before sending traffic |

## 9. License

OpenJev is [Apache-2.0](https://github.com/cmcclellan79/openjev/blob/main/LICENSE). The DiffusionGemma weights are Apache-2.0 (NVIDIA / Google). Answer quality is the quality of DiffusionGemma used this way, so evaluate it on your own tasks before relying on it.

## 10. Contact

Questions about OpenJev itself go to its [GitHub repository](https://github.com/cmcclellan79/openjev). Questions about deploying on Akash are welcome in the [Akash Discord](https://discord.akash.network).
