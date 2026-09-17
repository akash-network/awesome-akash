# YuE2 — AI Music Generator

YuE2 is an open-source AI model for full-song generation from lyrics and a style prompt. Give it lyrics and a genre description and it generates a complete song with vocals and accompaniment.

- **Model:** [m-a-p/YuE2-3B](https://huggingface.co/m-a-p/YuE2-3B)
- **License:** Apache 2.0 (code) · CC BY-NC 4.0 (model weights)
- **Output:** 48kHz stereo FLAC audio

## Deploy on Akash

Deploy `deploy.yaml` using [Akash Console](https://console.akash.network) or [Akash Air](https://air.akash.network).

On first boot the container installs dependencies and downloads the YuE2 model from Hugging Face (~6GB). This takes approximately 10-15 minutes. Persistent storage keeps the model cached across restarts.

Once deployed, open the provider URL in your browser to access the web UI.

## Usage

1. Enter a **Style / Genre** description (e.g. `english pop, female vocal, upbeat, acoustic guitar`)
2. Enter your **Lyrics** using `[verse]`, `[chorus]`, `[bridge]` section tags
3. Select a **Generation Mode**:
   - **Full** — generates a melody and chord plan first, then renders audio (recommended)
   - **Melody** — melody plan only, free accompaniment
   - **Direct** — no planning step, faster but lower quality
4. Click **Generate Song** and wait 2-5 minutes
5. Play the result in the browser or download as FLAC

## REST API

The deployment also exposes a JSON API at port 80:

```bash
# Health check
curl http://YOUR_AKASH_URL/health

# Generate a song
curl -X POST http://YOUR_AKASH_URL/generate \
  -H "Content-Type: application/json" \
  -d '{
    "style": "english pop, female vocal, upbeat",
    "lyrics": "[verse]\nYour lyrics here\n\n[chorus]\nYour chorus here",
    "cot": "full"
  }' \
  --output song.flac
```

## Hardware Requirements

| Resource | Minimum |
|---|---|
| GPU | 1x NVIDIA (any model) |
| VRAM | 24GB recommended |
| RAM | 32GB |
| Storage | 80GB (20GB base + 60GB model cache) |

## Resources

- [YuE2 GitHub](https://github.com/multimodal-art-projection/YuE)
- [YuE2 Model on Hugging Face](https://huggingface.co/m-a-p/YuE2-3B)
- [Akash Console](https://console.akash.network)
- [Akash Air](https://air.akash.network)
