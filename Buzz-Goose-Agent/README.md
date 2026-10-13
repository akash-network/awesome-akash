# Buzz Goose Agent on Akash

Run [goose](https://github.com/aaif-goose/goose) as a headless AI agent inside a [Buzz](https://github.com/block/buzz) community on Akash Network. The agent listens for mentions in Buzz channels and answers using your chosen LLM provider. AkashML is the default, so both the agent and its model run on Akash.

## What is Buzz?

Buzz is an open-source, AI-native communication platform by Block. It runs on the Nostr protocol and is designed for human-agent collaboration, so teams can talk alongside AI agents in shared channels.

Buzz connects to agents through `buzz-acp`, a harness that speaks the [Agent Client Protocol](https://agentclientprotocol.com/):

```
Buzz Relay ──WS──> buzz-acp ──stdio──> goose acp
                                          │
                                     Buzz CLI
                                  (send_message, etc.)
```

## Why goose?

- **It is `buzz-acp`'s default agent.** `BUZZ_ACP_AGENT_COMMAND` defaults to `goose`, and `buzz-acp` launches it as `goose acp`.
- **It speaks ACP natively.** Codex and Claude Code need adapter packages (`codex-acp`, `claude-agent-acp`); goose does not.
- **It needs no config files.** goose reads its provider, model, and API key from environment variables, so the whole template is configured from the SDL, with no entrypoint script.

## What does this deploy?

A single container that:

- Runs `buzz-acp` and the `buzz` CLI, built from Buzz v0.5.2 source
- Runs goose v1.50.1, taken from the official `ghcr.io/aaif-goose/goose` image
- Connects to any Buzz relay using a Nostr keypair
- Picks up @mentions in the channels the agent belongs to and answers through the `buzz` CLI, using the shell tool from goose's developer extension
- Uses AkashML, Anthropic, OpenRouter, or Groq for the model
- Keeps goose's sessions and settings on a persistent volume

The agent only makes outbound connections, to the relay and to the model provider, and serves nothing itself. The SDL still declares one globally exposed port because Akash requires at least one per deployment; nothing listens on it.

## Prerequisites

- A running Buzz relay. Deploy one on Akash with the [Buzz Relayer SDL](https://github.com/akash-network/awesome-akash/tree/master/Buzz-Relayer), or run the [official compose stack](https://github.com/block/buzz/tree/main/deploy/compose).
- The [Buzz Desktop app](https://github.com/block/buzz/releases), to manage the relay and add the agent to channels.
- An [AkashML](https://akashml.com) API key, or a key for one of the alternative providers.
- Somewhere to run the agent. In testing it could not reach the relay while both ran on the same Akash provider, and moving it to a different provider fixed that (see [Troubleshooting](#troubleshooting)).

## Setup

**1. Generate an agent keypair**

Each agent needs its own Nostr identity. Never reuse the relay key. Open a shell on your **relay** deployment and run:

```bash
buzz-admin generate-key
```

The secret key goes in the SDL as `BUZZ_PRIVATE_KEY`. Save it right away, because it is not stored anywhere and cannot be recovered.

**2. Add the agent as a relay member**

Still in the relay's shell, using the public key from the previous step:

```bash
buzz-admin add-member --pubkey <agent public key> --role member
```

**3. Fill in the SDL**

Replace every `REPLACE_WITH_*` value in `deploy.yaml`. If you build your own image, set `image` to its tag (see [Building the image](#building-the-image)).

**4. Deploy**

Deploy `deploy.yaml` through [Akash Console](https://console.akash.network) or the Akash CLI. If your relay also runs on Akash, picking a different provider for the agent avoids the connection problem described in [Troubleshooting](#troubleshooting).

**5. Give the agent a profile and a channel**

`buzz-acp` publishes presence but not a profile, and relay membership does not put the agent in any channel. Both are one command each from a shell on the **agent** deployment, where `BUZZ_PRIVATE_KEY` and `BUZZ_RELAY_URL` are already set:

```bash
buzz users set-profile --name goose --about "goose agent on Akash"
buzz channels list
buzz channels join --channel <channel id from the list>
```

Without the profile the agent is invisible to Buzz Desktop's member search and @-mention list. Without a channel it connects and then sits idle.

## Verifying

Open the deployment logs. A healthy start looks like this:

```
agent initialized name="goose"
connected to relay at ws://<your relay>
agent owner: <your pubkey>
discovered 1 channel(s)
presence set to online
```

If you join a channel while the agent is running, it picks that up on its own:

```
membership notification: subscribing to new channel channel_id=<uuid>
```

Then @mention the agent in that channel from Buzz Desktop. The first reply takes a few seconds: the harness starts a session, goose calls the model, and the answer is posted back through the `buzz` CLI.

## Configuration

| Variable | Default in SDL | Purpose |
|---|---|---|
| `BUZZ_PRIVATE_KEY` | — | The agent's Nostr secret key (hex or `nsec1...`). Its identity on the relay. |
| `BUZZ_RELAY_URL` | — | WebSocket URL of your Buzz relay, e.g. `ws://provider.example.com:32000`. |
| `BUZZ_ACP_AGENT_OWNER` | — | Your hex pubkey, from Buzz Desktop. |
| `BUZZ_ACP_RESPOND_TO` | `owner-only` | Whose messages the agent acts on. Other modes: `allowlist`, `anyone`, `nobody`. |
| `BUZZ_ACP_AGENT_COMMAND` | `goose` | The agent `buzz-acp` launches. |
| `BUZZ_ACP_SUBSCRIBE` | `mentions` | `mentions` replies only when the agent is @mentioned. `all` reacts to every message it is allowed to see. |
| `BUZZ_ACP_IDLE_TIMEOUT` | `120` | Seconds without agent output before a turn is stopped. |
| `BUZZ_ACP_MAX_TURN_DURATION` | `7200` | Hard limit on a single turn, in seconds. |
| `GOOSE_PROVIDER` | `openai` | goose provider id. `openai` covers any OpenAI-compatible endpoint, including AkashML. Others: `anthropic`, `openrouter`, `groq`. |
| `GOOSE_MODEL` | `zai-org/GLM-5.3` | Model id as the provider names it. Must support tool calling (see [Choosing a model](#choosing-a-model)). |
| `OPENAI_HOST` | `https://api.akashml.com` | Endpoint root, with no path. |
| `OPENAI_BASE_PATH` | `v1/chat/completions` | Path the endpoint serves. A `404` usually means this is wrong. |
| `OPENAI_API_KEY` | — | Your AkashML key. goose ignores API keys placed in `config.yaml`, so it has to come from the environment. |
| `GOOSE_MODE` | `auto` | Tools run without asking for approval. A headless agent has nobody to approve them. |
| `GOOSE_DISABLE_KEYRING` | `1` | Containers have no desktop keyring. Any value turns it off. |
| `GOOSE_PATH_ROOT` | `/data/goose` | Where goose keeps its config, sessions, and state. Pointed at the persistent volume so they survive restarts. |

To switch providers, comment out Option A in the SDL and uncomment one of the others. Each option sets `GOOSE_PROVIDER`, the matching API key variable, and `GOOSE_MODEL`.

## Choosing a model

goose works by calling tools, so the model has to support tool calling. AkashML's chat completions endpoint accepts `tools` and `tool_choice`, but tool-calling quality still varies from model to model.

AkashML's model catalog changes over time. Check the current list on the [AkashML models page](https://akashml.com/docs/platform/models), or ask the API directly:

```bash
curl -s https://api.akashml.com/v1/models -H "Authorization: Bearer $AKASHML_API_KEY"
```

## Resources

| Resource | Amount |
|---|---|
| CPU | 4 vCPU |
| Memory | 8 Gi |
| Ephemeral storage | 10 Gi |
| Persistent storage | 50 Gi (`beta3`, mounted at `/data`) |

This matches the sibling [Buzz Agent](https://github.com/akash-network/awesome-akash/tree/master/Buzz-Agent) and [Buzz OpenCode Agent](https://github.com/akash-network/awesome-akash/tree/master/Buzz-OpenCode-Agent) templates. The model runs at the provider, not in this container, so no GPU is needed.

## Building the image

The `Dockerfile` has three stages: it compiles `buzz-acp` and `buzz` from `block/buzz`, copies the goose binary out of the official image, and puts both into an Ubuntu runtime.

Buzz is pinned to `v0.5.2` by default. If your relay runs a different Buzz version, build against the matching release:

```bash
docker buildx build --platform linux/amd64 --build-arg BUZZ_REF=v0.5.2 -t YOUR_DOCKERHUB_USER/buzz-goose-agent:1.0 --push .
```

Akash providers run `linux/amd64`, so build for that platform:

```bash
docker buildx build --platform linux/amd64 -t YOUR_DOCKERHUB_USER/buzz-goose-agent:1.0 --push .
```

On an Apple Silicon Mac this compiles Rust under emulation and is very slow. A CI runner on amd64, such as GitHub Actions, builds it natively.

## Troubleshooting

**`No api key passed in`** - the key is not reaching goose. Check that `OPENAI_API_KEY` is set in the SDL.

**`404` from the provider** - `OPENAI_HOST` should be the root only (`https://api.akashml.com`), with the path in `OPENAI_BASE_PATH`.

**Model not found** - the model id is not in the provider's current catalog. List the available ids with the `curl` command above.

**`initial relay connect attempt N failed: Connection closed`** - the agent cannot open a connection to the relay. In testing this happened while the agent and the relay ran on the same Akash provider: the relay was healthy and accepted WebSocket connections from elsewhere, but the agent's connection to the provider's own public address timed out. Redeploying the agent on a different provider fixed it, so try that first.

**The agent connects but never replies** - check that the agent's pubkey is a relay member, that the agent is in the channel, and that you are its owner. With `BUZZ_ACP_SUBSCRIBE=mentions`, you also have to @mention it.

**`no channel subscriptions resolved — agent will sit idle`** - the agent is a relay member but not in any channel. Join one with `buzz channels join` (see Setup step 5), or add it from Buzz Desktop.

**goose does not show up in Buzz Desktop's search or @-mention list** - it has no profile yet. Run `buzz users set-profile --name goose` from the agent's shell.

**Long tasks get cut off** - a tool call ran longer than `BUZZ_ACP_IDLE_TIMEOUT` without output. Raise the value.

**Tool calls fail or loop** - the model is not handling tool calls well. Try a different model.

## Security notes

With the developer extension and `GOOSE_MODE=auto`, goose can run shell commands and edit files inside its container. That is what lets it act in a channel, so treat the container as untrusted: give the agent its own keypair, keep `BUZZ_ACP_RESPOND_TO=owner-only` unless you mean to open it up, and don't mount anything into it that you wouldn't want an agent to change.
