# Dify

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-dify)

Dify is an open-source platform for building AI applications, workflows, agents, and RAG pipelines.

## What this template deploys

This Akash SDL deploys a minimal self-hosted Dify stack:

- Dify API: `langgenius/dify-api:1.14.1`
- Dify worker: `langgenius/dify-api:1.14.1`
- Dify web UI: `langgenius/dify-web:1.14.1`
- PostgreSQL 15
- Redis 6
- Weaviate vector database
- Dify sandbox
- Dify plugin daemon
- Caddy reverse proxy

The public endpoint is exposed through the `caddy` service on port `80`.

## Before deployment

Change all placeholder values in `deploy.yaml` before using this template in production:

```bash
CHANGE_ME_GENERATE_WITH_OPENSSL_RAND_BASE64_42
CHANGE_ME_ADMIN_PASSWORD
CHANGE_ME_DB_PASSWORD
CHANGE_ME_REDIS_PASSWORD
CHANGE_ME_WEAVIATE_API_KEY
CHANGE_ME_SANDBOX_API_KEY
CHANGE_ME_PLUGIN_DAEMON_KEY
CHANGE_ME_PLUGIN_INNER_API_KEY
```

You can generate secrets with:

```bash
openssl rand -base64 42
```

Make sure that matching values are changed consistently across all services. For example, `DB_PASSWORD` in `api`, `worker`, `plugin-daemon`, and `POSTGRES_PASSWORD` in `db` must be identical.

## Deployment

Deploy `deploy.yaml` through Akash Console or Akash CLI.

After the lease starts, open the URI of the `caddy` service.

On first launch, Dify should run database migrations through the API service and allow initial setup using `INIT_PASSWORD`.

## Notes and limitations

This is an MVP template for `awesome-akash`, not a hardened production reference architecture.

Important limitations:

- The template uses local filesystem storage for Dify application files.
- For production usage, S3-compatible storage such as MinIO is recommended.
- The official Dify Docker Compose setup uses an SSRF proxy. This Akash MVP disables the SSRF proxy to avoid mounting external nginx/squid config files.
- The template uses Caddy instead of the official nginx container so routing can be defined inline inside SDL.
- If you add external OAuth providers, email links, or split domains, configure the public URL variables explicitly.

## Resource profile

Recommended minimum resources for this template:

- CPU: 10+ total units across services
- RAM: 18+ GiB total across services
- Persistent storage: 80+ GiB total

For small testing, you can reduce storage sizes, but Dify, Weaviate, and PostgreSQL should remain persistent.

## Useful links

- Dify documentation: https://docs.dify.ai/
- Dify Docker Compose deployment: https://docs.dify.ai/en/self-host/quick-start/docker-compose
- Dify GitHub repository: https://github.com/langgenius/dify
