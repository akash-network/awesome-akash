# LiteLLM Proxy

LiteLLM Proxy is a self-hosted OpenAI-compatible AI gateway.

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-litellm)

## Before deployment

Change these placeholder values in `deploy.yaml` before deploying:

```bash
CHANGE_ME_LITELLM_MASTER_KEY
CHANGE_ME_LITELLM_SALT_KEY
CHANGE_ME_POSTGRES_PASSWORD
CHANGE_ME_OPENAI_API_KEY
CHANGE_ME_UI_PASSWORD
```

Generate strong values for the master key, salt key, database password, and UI password.

Examples:

```bash
openssl rand -base64 32
```

The `LITELLM_SALT_KEY` is used to encrypt and decrypt stored LLM API keys. Do not change it after adding models in LiteLLM.

## Default model

The template includes one example model:

```yaml
model_name: gpt-4o-mini
model: openai/gpt-4o-mini
api_key: os.environ/OPENAI_API_KEY
```

You can change this section in the inline `config.yaml` inside `deploy.yaml`.

Example for an OpenAI-compatible endpoint, such as vLLM or Ollama behind an OpenAI-compatible API:

```yaml
model_list:
  - model_name: local-model
    litellm_params:
      model: openai/local-model
      api_base: http://your-openai-compatible-endpoint:8000/v1
      api_key: none
```

## Using the proxy

Use the Akash URIs assigned to port `4000` as your OpenAI-compatible base URL.

Example:

```bash
curl http://<akash-host>:4000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer CHANGE_ME_LITELLM_MASTER_KEY" \
  -d '{
    "model": "gpt-4o-mini",
    "messages": [
      {"role": "user", "content": "Hello from Akash"}
    ]
  }'
```

For OpenAI SDK-compatible clients:

```bash
OPENAI_BASE_URL=http://<akash-host>:4000/v1
OPENAI_API_KEY=CHANGE_ME_LITELLM_MASTER_KEY
```

## PostgreSQL

The database data is stored in a persistent volume mounted at:

```bash
/var/lib/postgresql/data
```

Default persistent storage size:

```bash
10Gi
```

You can increase it in the `profiles.compute.db.resources.storage` section.

## Logs

Check LiteLLM logs:

```bash
akash provider lease-logs \
  --dseq <DSEQ> \
  --gseq 1 \
  --oseq 1 \
  --provider <PROVIDER_ADDRESS> \
  --service litellm
```

Check PostgreSQL logs:

```bash
akash provider lease-logs \
  --dseq <DSEQ> \
  --gseq 1 \
  --oseq 1 \
  --provider <PROVIDER_ADDRESS> \
  --service db
```

## Troubleshooting

### LiteLLM starts but model calls fail

Check that the model config and provider API key are correct:

```bash
OPENAI_API_KEY=CHANGE_ME_OPENAI_API_KEY
```

Also check that the request uses the model name from `config.yaml`:

```bash
gpt-4o-mini
```

### Unauthorized requests

Requests must include the master key:

```bash
Authorization: Bearer CHANGE_ME_LITELLM_MASTER_KEY
```

### Database connection errors

Make sure this value uses the same PostgreSQL password as the `db` service:

```bash
DATABASE_URL=postgresql://litellm:CHANGE_ME_POSTGRES_PASSWORD@db:5432/litellm
```

## Notes

This template is intended as a simple LiteLLM Proxy deployment for Akash.
For production use, consider adding your own domain, TLS termination, stricter access controls, Redis for caching/rate limits, and a more complete model configuration.
