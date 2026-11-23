# Stable Diffusion UI (Easy Diffusion)

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-stable-diffusion-ui)

[Easy Diffusion](https://github.com/easydiffusion/easydiffusion) is the simplest way to generate images with Stable Diffusion and SDXL: a clean web UI with a task queue, inpainting, ControlNet, LoRAs, upscaling and face restoration, without needing to wire up node graphs.

Easy Diffusion and CUDA PyTorch are preinstalled in the image, so a deployment only downloads models before the UI starts. It uses Easy Diffusion's **v3.0 engine**, which supports SD 1.5 and SDXL models.

## Models

| Model | Type | Good for | Size |
|---|---|---|---|
| Juggernaut XL v9 | SDXL | Photorealistic images, people, products | 7.1 GB |
| GFPGAN, RealESRGAN x4 / x4 anime, SD VAE | Helpers | Face restoration, 4x upscaling (downloaded by Easy Diffusion) | 0.8 GB |

Optional, one uncomment away in `deploy.yaml`: the **SDXL VAE (fp16 fix)** (0.3 GB), for cleaner colors with SDXL models.

Easy Diffusion only downloads **SD 1.5** (2 GB) when no other Stable Diffusion model is present, so you get it if you empty `MODELS`.

**Recommended settings for Juggernaut XL:** 1024x1024, 30-40 steps, guidance 4-6, sampler DPM++ 2M (Karras).

## First start

The first start takes a few minutes, mostly downloading Juggernaut XL. In the deployment logs:

- `[models] ...` lines show the model downloads, which run first.
- `Launching uvicorn` means the UI is up. Open the deployment URL.

## Configuration

All configuration is done through environment variables in `deploy.yaml`:

| Variable | Description |
|---|---|
| `MODELS` | Models to download on start, as `folder\|url` entries separated by spaces or commas. Folders: `stable-diffusion`, `vae`, `lora`, `embeddings`, `controlnet`, `text-encoder`, `realesrgan`. Files that are already present are skipped. |
| `HF_TOKEN` | Hugging Face token, only needed for gated repos. |
| `ED_BACKEND` | `ed_diffusers` = v3.0 engine (default, SD 1.5 / SDXL, most reliable). `webui` = v3.5 engine (Forge; adds Flux, SD 3.5 and Chroma; experimental, installs ~10 GB on first start). |

Example: add a LoRA next to Juggernaut XL:

```yaml
- >-
  MODELS=
  stable-diffusion|https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors
  lora|https://huggingface.co/<user>/<repo>/resolve/main/<lora>.safetensors
```

### Keeping models across restarts (optional)

Models are stored in `/data/models`. By default that is ephemeral storage, so models are downloaded again if the deployment restarts. To keep them, mount a persistent volume at `/data`:

```yaml
services:
  stable-diffusion-ui:
    # ...
    params:
      storage:
        data:
          mount: /data
          readOnly: false

profiles:
  compute:
    stable-diffusion-ui:
      resources:
        # ...
        storage:
          - size: 10Gi
          - name: data
            size: 100Gi
            attributes:
              persistent: true
              class: beta3
```

## Resources

- **GPU:** 1x NVIDIA GPU with 16 GB+ VRAM. The template accepts RTX 4090, 5090, 3090, 4080, 4080 Super, A5000, RTX A6000, A100 and H100 to maximize bids; remove models you don't want.
- **CPU:** 8 units (generation runs on the GPU).
- **Memory:** 32Gi (use 48Gi for Flux on the v3.5 engine).
- **Storage:** 50Gi. Add ~25Gi per Flux / SD 3.5 checkpoint and ~20Gi for the v3.5 engine.

## Building the image

The image is built from the `Dockerfile` and `entrypoint.sh` in this folder:

```bash
docker build -t <your-dockerhub-user>/easy-diffusion:1.0.0 .
docker push <your-dockerhub-user>/easy-diffusion:1.0.0
```

The build takes about 15 minutes and produces a ~9 GB image (~4.7 GB compressed). To ship a newer Easy Diffusion, change `ED_COMMIT` in the `Dockerfile` to a newer commit from the [Easy Diffusion repository](https://github.com/easydiffusion/easydiffusion/commits/main) and rebuild. To test locally with an NVIDIA GPU:

```bash
docker run --gpus all -p 9000:9000 <your-dockerhub-user>/easy-diffusion:1.0.0
```

## Licenses

Easy Diffusion uses an MIT-style license. Juggernaut XL and SD 1.5 use CreativeML Open RAIL licenses. Check each model's license before commercial use, especially for any models you add.

## Reference

- Easy Diffusion: https://github.com/easydiffusion/easydiffusion
- Easy Diffusion user guide: https://github.com/easydiffusion/easydiffusion/wiki
