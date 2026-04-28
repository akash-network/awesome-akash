# Razer AIKit

[![GitHub release](https://img.shields.io/github/v/release/razerofficial/aikit)](https://github.com/razerofficial/aikit/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/razerofficial/aikit)](https://hub.docker.com/r/razerofficial/aikit)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/razerofficial/aikit/blob/main/LICENSE)

**An open-source AI development toolkit with fast LLM inferencing, fine-tuning, and a plug-and-play notebook environment - delivered as a one-click GPU deployment.**

Razer AIKit is built for engineers and researchers who want cloud-grade AI tooling without the local setup. This template packages the full AIKit stack — vLLM engine, Jupyter Lab notebooks, and the Razer AIKit web UI — into a single GPU container. Deploy it and start generating images and text or running any of the 300,000+ models on Hugging Face.

> Full toolkit, CLI reference, and architecture docs: [github.com/razerofficial/aikit](https://github.com/razerofficial/aikit).

---

## What's inside

| Service          | Port | Purpose                                                       |
| ---------------- | ---- | ------------------------------------------------------------- |
| Jupyter Lab      | 8888 | Full AIKit notebook environment (password: `RazerAI`)     
| Razer AIKit UI   | 7860 | Web UI for image and audio generation (Gradio front end)      |    |
| vLLM / API       | 8000 | OpenAI-compatible inference endpoint                          |

---

## Quick start

### 1. Deploy the template

Click **Deploy**, accept a bid, and wait for the lease to go active. The deployment panel will show three forwarded ports — one each for the Jupyter Lab, AIKit UI, and the vLLM API:

![Active deployment with forwarded ports 7860, 8000, and 8888](https://raw.githubusercontent.com/akash-network/awesome-akash/master/Razer-AIKit/images/akash-deployment-ports.png)

### 2. Open Jupyter Lab (port 8888)

Click the external-link icon next to **port 8888**. Jupyter will prompt for a password — enter:

```
RazerAI
```

![Jupyter Lab password prompt](https://raw.githubusercontent.com/akash-network/awesome-akash/master/Razer-AIKit/images/jupyter-login.png)

> The password is set at container start from the SDL. To change it, fork the SDL and replace the `RazerAI` string in the `jupyter lab` command.

### 3. Pick a notebook

After logging in, Jupyter opens on the AIKit notebooks. Everything runs out of the box inside the container:

![AIKit Jupyter Lab home with bundled notebooks](https://raw.githubusercontent.com/akash-network/awesome-akash/master/Razer-AIKit/images/jupyter-home.png)

Notebooks grouped by use case:

- **Inferencing** — On-Device Inferencing, Distributed Inferencing (Head / Node)
- **Image generation** — On-Device Image Generation
- **Fine-tuning** — On-Device Fine-Tuning (LoRA), Distributed Fine-Tuning LoRA (Head / Node)
- **Integrations** — Integrating AIKit with the OpenAI API, Semantic Search

For a first run, open **`3_On_Device_Image_Generation.ipynb`** and step through the cells. The notebook walks through pulling a diffusion model from Hugging Face and generating an image locally on the rented GPU:

![On-device image generation notebook](https://raw.githubusercontent.com/akash-network/awesome-akash/master/Razer-AIKit/images/notebook-image-generation.png)

### 4. Or jump straight to the AIKit UI (port 7860)

Click the external-link icon next to **port 7860** to open the Razer AIKit web UI.

> **Deploy a model first.** The UI hooks into whatever model is currently loaded, so before it can generate anything you need to run the relevant download/serve cells from Jupyter (e.g. `3_On_Device_Image_Generation.ipynb` for diffusion models). Once a model is live, the UI picks it up automatically.

Then just type a prompt and click **Generate Image**:

![Razer AIKit UI generating a cat with Razer headphones](https://raw.githubusercontent.com/akash-network/awesome-akash/master/Razer-AIKit/images/aikit-ui-cat.png)

---

## What to do next

Once the core flow works, the same deployment is a full AIKit workstation. A few directions to explore:

- **Run any vLLM-supported LLM from Hugging Face** — use notebook **1 (On-Device Inferencing)** to pull and serve a model, e.g. `deepseek-ai/deepseek-coder-1.3b-instruct`. Browse the catalogue at [vLLM-compatible models on Hugging Face](https://huggingface.co/models?apps=vllm&sort=trending).
- **Fine-tune with LoRA** — notebook **4** (On-Device Fine-Tuning LoRA) runs end-to-end on the single provisioned GPU.
- **Use the OpenAI-compatible endpoint** on port 8000 — point any OpenAI SDK at `http://<provider-host>:<8000-forwarded-port>/v1` and treat the deployment as your private LLM API. Notebook **6** has a worked example.

> Distributed (multi-node) inferencing and fine-tuning notebooks (`2a`, `2b`, `5a`, `5b`) are present in the image but are **out of scope for this single-service template** — they require a head + worker topology and inter-node networking that isn't wired up here.

---

## Links

- Razer AIKit on GitHub — [github.com/razerofficial/aikit](https://github.com/razerofficial/aikit)
- AIKit on Docker Hub — [hub.docker.com/r/razerofficial/aikit](https://hub.docker.com/r/razerofficial/aikit)
- vLLM-compatible models on Hugging Face — [huggingface.co/models?apps=vllm](https://huggingface.co/models?apps=vllm&sort=trending)
- Hugging Face — [huggingface.co/models](https://huggingface.co/models)

---

## License

Razer AIKit is released under the **Apache License 2.0**. See the upstream repository for full terms.
