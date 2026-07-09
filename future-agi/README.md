# Future AGI

[Future AGI](https://github.com/future-agi/future-agi) is an open-source, self-hostable platform to simulate, evaluate, trace, guardrail, route, and optimize LLM and AI agent applications in one feedback loop, so agents don't just get monitored, they self-improve. Apache-2.0.

This template deploys the core Future AGI stack on Akash:

- **frontend** — web UI (`futureagi/frontend`)
- **backend** — API server with OpenTelemetry-native tracing, 70+ eval metrics, and LLM-as-judge (`futureagi/future-agi`)
- **worker** — Temporal workflow worker for evals and background jobs (`futureagi/future-agi`)
- **serving** — model-serving service (`futureagi/serving`)
- **code-executor** — sandboxed code execution (`futureagi/code-executor`)
- **Data stores** — Postgres, ClickHouse, Redis, RabbitMQ, MinIO, and Temporal

It is adapted from the official `deploy/docker-compose.production.yml` (default profile; the optional PeerDB CDC stack is omitted).

## Deploy

1. Open the [Akash Console](https://console.akash.network/) (or use the Akash CLI) and paste `deploy.yaml`.
2. Replace every `CHANGE_ME_*` value with a strong secret:
   - `CHANGE_ME_SECRET_KEY` — Django secret key (use the same value across `backend`, `worker`, `serving`).
   - `CHANGE_ME_PG_PASSWORD`, `CHANGE_ME_CH_PASSWORD`, `CHANGE_ME_RABBITMQ_PASSWORD`, `CHANGE_ME_MINIO_PASSWORD` — data-store passwords (keep them consistent across services).
3. Create the deployment, accept a bid, and wait for the lease to start. First boot pulls images from Docker Hub.
4. After the lease is live, copy the public URL of the **backend** service (port `8000`), set `VITE_HOST_API` on the **frontend** service to that URL, and update the lease so the UI can reach the API.
5. Open the **frontend** lease URL to access Future AGI.

> Minimum recommended resources: ~8 GB RAM and ~20 GB disk across the deployment (16 GB RAM recommended for production use).

## Optional: agentcc-gateway (LLM proxy)

Future AGI's LLM-routing/guardrail proxy (`futureagi/agentcc-gateway`) is published as a minimal `scratch` image that reads its configuration from a mounted `/app/config.yaml`. Akash SDL has no file-mount mechanism and the image has no shell, so the gateway is not included in this template. To enable it, build a thin image that bakes in your config:

```dockerfile
FROM futureagi/agentcc-gateway:latest
COPY config.yaml /app/config.yaml
```

Publish that image, add it as a `agentcc-gateway` service (expose port `8080` to `backend`), and set `AGENTCC_INTERNAL_URL=http://agentcc-gateway:8080` on `backend` and `worker`. See [agentcc-gateway/config.example.yaml](https://github.com/future-agi/future-agi/blob/main/agentcc-gateway/config.example.yaml) for the config schema.

## Links

- GitHub: https://github.com/future-agi/future-agi
- Website: https://futureagi.com/
- Self-hosting guide: https://github.com/future-agi/future-agi/blob/main/INSTALLATION.md
