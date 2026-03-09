# Akash Music AI

AI-powered music generation on decentralized GPU compute. Deploy a fully functional music generation service to Akash Network with a modern web UI.

## Features

- **ACE-Step 1.5 Music AI** — State-of-the-art music generation from text descriptions
- **Decentralized Deployment** — Run on Akash Network's distributed GPU compute
- **Custom Web UI** — Modern, responsive interface for generating music
- **CPU Fallback** — Graceful degradation if GPU VRAM is constrained
- **Multiple Output Formats** — Generate MP3, WAV, or FLAC

## Quick Start

### Prerequisites

- Docker installed locally
- Akash CLI (`akash`) configured
- Docker Hub account (or similar registry)

### Deployment

1. **Build & Push Docker Image**

```bash
docker build -t YOUR_DOCKER_USERNAME/acestep-api:latest -f Dockerfile . --no-cache
docker push YOUR_DOCKER_USERNAME/acestep-api:latest
```

2. **Update `deploy.yml`**

Replace `YOUR_DOCKER_USERNAME` in `deploy.yml` with your Docker Hub username.

3. **Deploy to Akash**

```bash
akash tx deployment create deploy.yml --from <your-key> --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID
# Follow prompts to accept a provider bid
```

4. **Access the UI**

Once deployed, navigate to your provider's endpoint:
```
http://<provider-ip>:<exposed-port>/
```

## Customization

### Custom UI

Edit `studio-akash-final.html` to customize colors, layout, or add features:

```bash
# Edit the HTML file
nano studio-akash-final.html

# Rebuild the Docker image
docker build -t YOUR_DOCKER_USERNAME/acestep-api:latest -f Dockerfile . --no-cache
docker push YOUR_DOCKER_USERNAME/acestep-api:latest

# Redeploy using updated `deploy.yml`
```

### GPU Selection

Modify `deploy.yml` to target specific GPU types:

```yaml
gpu:
  units: 1
  attributes:
    vendor:
      nvidia: true
    model:
      a100: true  # or rtx4090, l40s, etc.
```

### Pricing

Adjust the bid in `deploy.yml` to attract higher-end providers:

```yaml
placement:
  akash:
    pricing:
      acestep-api:
        denom: uakt
        amount: 50000  # Higher = better GPUs
```

## Architecture

```
┌─────────────────────────────────────┐
│    Browser (Web UI)                 │
└──────────────────┬──────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │   Nginx (Port 80)    │
        │   - Serves HTML      │
        │   - Proxies /api/*   │
        └──────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │   FastAPI Server     │
        │  (Port 8001, local)  │
        │  - /release_task     │
        │  - /query_result     │
        │  - /health           │
        └──────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │  ACE-Step 1.5 Models │
        │  - DiT (Music Gen)   │
        │  - LM (Enhancement)  │
        │  - VAE (Codec)       │
        └──────────────────────┘
```

## Tips for Success

- **Start with shorter durations** (30-60 seconds) to avoid VRAM issues
- **Use descriptive prompts** — "upbeat electronic dance music with heavy bass" works better than "good song"
- **Monitor logs** — Check provider logs for generation status and any VRAM warnings
- **Upgrade if needed** — If generation times are slow, deploy to a provider with RTX 4090, A100, or H100

## References

- [ACE-Step 1.5 GitHub](https://github.com/ACE-Step/ACE-Step-1.5.git)
- [Akash Network Docs](https://akash.network/docs)
- [Akash Discord](https://discord.gg/akashnetwork)

## License

This project wraps [ACE-Step 1.5](https://github.com/ACE-Step/ACE-Step-1.5.git) — refer to their repository for licensing details.

## Support

Issues or questions? Check the logs in your Akash deployment console or open an issue on GitHub.

---

**Built with ❤️ on Akash Network**
