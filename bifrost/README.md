# Bifrost AI Gateway

Bifrost is an open-source, OpenAI-compatible AI gateway for routing requests to multiple providers from a self-hosted service.

## Deployment

Deploy `deploy.yaml` with the [Akash deployment workflow](https://akash.network/docs/developers/deployment/). The template uses the official `maximhq/bifrost:v1.3.9` image and exposes port `8080`. Bifrost stores its local state under `/app/data` in the container filesystem.

The template intentionally contains no provider credentials. After deployment, open the assigned Bifrost URL and configure providers in the web interface, or mount a declarative configuration as described in the [Bifrost deployment documentation](https://github.com/maximhq/bifrost/blob/dev/docs/quickstart/gateway/setting-up.mdx).

## Using the gateway

Use the assigned Akash URL as the OpenAI-compatible base URL:

```bash
curl -X POST http://<akash-host>:8080/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "openai/gpt-4o-mini",
    "messages": [{"role": "user", "content": "Hello from Akash"}]
  }'
```

See the [Bifrost overview](https://docs.getbifrost.ai/overview) for provider routing, governance, MCP, and observability features.

## Notes

For production use, review the image version, configure authentication and TLS, use an external Bifrost store or a provider-tested persistent-volume setup, and keep provider credentials out of the SDL and source control. The included template uses ephemeral storage because Akash persistent-volume mounts are root-owned while this image runs as a non-root user, which prevents Bifrost from creating its local database and logs.
