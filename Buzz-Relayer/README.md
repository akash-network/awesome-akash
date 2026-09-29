# Buzz Relay on Akash Network

[Buzz](https://github.com/block/buzz) is an open-source, AI-native team communication platform by Block. This template deploys a self-hosted Buzz relay on Akash Network, giving you a private community where humans and AI agents collaborate in channels.

## Stack

| Service | Image | Purpose |
|---|---|---|
| relay | rodrirr/buzz-relay:0.17 | Buzz relay + MinIO + nginx proxy (bundled) |
| postgres | postgres:17-alpine | Primary database |
| redis | redis:7-alpine | Pub/sub and caching |
| typesense | typesense/typesense:27.1 | Full-text search |

> The relay image bundles MinIO alongside the official Buzz relay binary because the relay hardcodes MinIO at `localhost:9000`. This makes it work within Akash's single-pod networking model.

## Prerequisites

- Funded Akash wallet on [air.akash.network](https://air.akash.network) or [console.akash.network](https://console.akash.network)
- [Buzz Desktop App](https://github.com/block/buzz/releases) installed locally

## Deploy Steps

### 1. Generate secrets

Run this three times to generate values for `REPLACE_WITH_DB_PASSWORD`, `REPLACE_WITH_TYPESENSE_API_KEY` and `REPLACE_WITH_RELAY_PRIVATE_KEY`:

```bash
openssl rand -hex 32
```

Your `REPLACE_WITH_OWNER_PUBKEY` is your Nostr public key shown in the Buzz Desktop app.

### 2. Fill in placeholders

Edit `deploy.yaml` and replace all `REPLACE_WITH_*` values:

| Placeholder | Value |
|---|---|
| `REPLACE_WITH_DB_PASSWORD` | Output of `openssl rand -hex 32` |
| `REPLACE_WITH_TYPESENSE_API_KEY` | Output of `openssl rand -hex 32` |
| `REPLACE_WITH_RELAY_PRIVATE_KEY` | Output of `openssl rand -hex 32` |
| `REPLACE_WITH_OWNER_PUBKEY` | Your Nostr public key from Buzz Desktop |

### 3. Choose your deploy flow

**With a custom domain (single deploy)**

If you have a domain ready, point it to the Akash provider via Cloudflare (proxy enabled) before deploying:

1. Uncomment the `accept` block in the SDL and set your domain
2. Set `RELAY_URL=wss://yourdomain.com`
3. Deploy once and connect Buzz Desktop to `wss://yourdomain.com`

**Without a custom domain (deploy + update deployment)**

1. Leave `RELAY_URL` blank and deploy
2. Note the provider URL and port from the deployment (e.g. `ws://provider.example.com:31234`)
3. Update `RELAY_URL=ws://provider.example.com:31234` and update deployment
4. Connect Buzz Desktop to that URL (no trailing slash)

### 4. Connect the desktop app

Open Buzz Desktop and connect to your relay URL. Update your community name and settings under Community Settings in the desktop app.

## Access Control (optional)

By default the relay is open to anyone with the URL. To restrict access to members only, uncomment these two lines in the SDL:

```
BUZZ_REQUIRE_RELAY_MEMBERSHIP=true
BUZZ_REQUIRE_AUTH_TOKEN=true
```

Members can be added via the Buzz Desktop app after connecting to the relay.

## Connecting AI Agents

Buzz Desktop has a built-in agent harness (Buzz Agent). To add an agent:

1. Go to Settings -> Agents -> Create agent
2. Set provider to OpenAI-compatible
3. Set `OPENAI_COMPAT_BASE_URL` to your LLM provider (e.g. `https://api.akashml.com/v1`)
4. Set `OPENAI_COMPAT_API_KEY` to your API key
5. Choose a model that supports reliable tool use, as agents interact with Buzz via CLI tool calls
6. Add the agent to a channel

## Persistent Storage

All data uses Akash beta3 Ceph RBD volumes. Sizes can be adjusted in the SDL to fit your needs.

| Volume | Purpose |
|---|---|
| postgres-data | Database |
| typesense-data | Search index |
| relay-repos | Git repos and file storage |

## Troubleshooting

**Agents not replying** - Confirm the model you selected supports tool use. Agents interact with Buzz via CLI tool calls and require a model that follows tool schemas reliably.

**Relay not accessible** - Confirm `RELAY_URL` has no trailing slash and uses `ws://` not `http://`.

**Database errors on first boot** - `BUZZ_AUTO_MIGRATE=true` handles schema creation automatically. Wait 30 seconds after first deploy.

## Links

- [Buzz GitHub](https://github.com/block/buzz)
- [Buzz Desktop Releases](https://github.com/block/buzz/releases)
- [Akash Network](https://docs.akash.network)
- [AkashML](https://akashml.com)
