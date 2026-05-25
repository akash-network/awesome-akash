# Langfuse

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-langfuse)

Langfuse is an open-source LLM engineering and observability platform for tracing, prompt management, evaluations, metrics, datasets, and debugging LLM applications.

This template deploys a self-hosted Langfuse v3 stack on Akash.

## Services

- Langfuse Web
- Langfuse Worker
- PostgreSQL
- ClickHouse
- Redis
- MinIO
- Caddy reverse proxy

## Exposed ports

- `80` - Langfuse Web UI and API through Caddy

## Before deployment

Replace all `CHANGE_ME_*` values in `deploy.yaml`.

Required values:

| Variable | Description |
| --- | --- |
| `CHANGE_ME_PUBLIC_URL` | Public Akash URL for the Langfuse web service, for example `https://example.com` or the provider URI |
| `CHANGE_ME_NEXTAUTH_SECRET` | Random secret for NextAuth |
| `CHANGE_ME_SALT` | Random salt used by Langfuse |
| `CHANGE_ME_ENCRYPTION_KEY_64_HEX` | 64-character hex encryption key |
| `CHANGE_ME_POSTGRES_PASSWORD` | PostgreSQL password |
| `CHANGE_ME_CLICKHOUSE_PASSWORD` | ClickHouse password |
| `CHANGE_ME_REDIS_PASSWORD` | Redis password |
| `CHANGE_ME_MINIO_ACCESS_KEY` | MinIO access key |
| `CHANGE_ME_MINIO_SECRET_KEY` | MinIO secret key |

Example secret generation:

```bash
openssl rand -base64 32   # NEXTAUTH_SECRET
openssl rand -base64 16   # SALT
openssl rand -hex 32      # ENCRYPTION_KEY
```

## Optional initial user

The SDL leaves the `LANGFUSE_INIT_*` variables empty. You can either create the first user through the UI or fill these variables before deployment.

Optional variables:

```yaml
LANGFUSE_INIT_ORG_ID=
LANGFUSE_INIT_ORG_NAME=
LANGFUSE_INIT_PROJECT_ID=
LANGFUSE_INIT_PROJECT_NAME=
LANGFUSE_INIT_PROJECT_PUBLIC_KEY=
LANGFUSE_INIT_PROJECT_SECRET_KEY=
LANGFUSE_INIT_USER_EMAIL=
LANGFUSE_INIT_USER_NAME=
LANGFUSE_INIT_USER_PASSWORD=
```

## Storage

This template uses persistent storage for:

- PostgreSQL data
- ClickHouse data
- Redis data
- MinIO data

Langfuse stores event uploads and media in the MinIO bucket named `langfuse`.

## Notes

Langfuse v3 uses more infrastructure than Langfuse v2. The stack includes PostgreSQL, ClickHouse, Redis, and object storage. Make sure the selected provider has enough CPU, memory, and persistent storage capacity.

All infrastructure components should use UTC time. This template sets `TZ=UTC` and `PGTZ=UTC` where applicable.

## References

- [Langfuse self-hosting documentation](https://langfuse.com/self-hosting)
- [Langfuse Docker Compose deployment](https://langfuse.com/self-hosting/deployment/docker-compose)
