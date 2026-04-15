# Hermes Agent on Akash Console

This template deploys [Hermes Agent](https://github.com/NousResearch/hermes-agent) on Akash as an SSH-first workspace with persistent storage.

Unlike the OpenClaw template, Hermes does not require a dedicated web setup UI. The Akash-friendly pattern is:

1. Deploy a container with SSH access and a persistent volume.
2. Bootstrap Hermes from the official GitHub repository on first boot.
3. SSH into the instance and run `hermes-akash setup` (CLI) or `hermes-akash gateway setup` (Telegram/Discord/etc.).

## What this template does

- Exposes port `22` for SSH access.
- Clones `NousResearch/hermes-agent` into `/workspace/hermes-agent`.
- Installs Hermes in a local virtualenv with the extras most useful for remote agent hosting:
  - `messaging`
  - `cron`
  - `pty`
  - `mcp`
  - `honcho`
  - `web`
- Persists `HERMES_HOME` at `/workspace/hermes-home`.
- Creates a helper command: `hermes-akash`.

## Required configuration

Before deploying, replace these environment values in Akash Console:

- `SSH_PUBKEY` — your SSH public key (required).
- `HERMES_REF` — optional Git ref to deploy (`main`, a tag, or a release branch).

## Deploy steps

1. Open the template in Akash Console.
2. Set `SSH_PUBKEY` to your public key.
3. Optionally pin `HERMES_REF` to a release tag instead of `main`.
4. Deploy the SDL.
5. Wait for the container to finish the first-boot bootstrap.
   - First boot can take several minutes because Ubuntu packages and Python dependencies are installed inside the container.
6. SSH into the instance.
7. Run one of:

```bash
hermes-akash setup
```

For messaging gateway usage:

```bash
hermes-akash gateway setup
hermes-akash gateway start
```

## Persistent paths

- Hermes repo: `/workspace/hermes-agent`
- Hermes profile home: `/workspace/hermes-home`
- Provider keys / tokens: `/workspace/hermes-home/.env`
- Main config: `/workspace/hermes-home/config.yaml`
- Sessions, skills, memories, logs: under `/workspace/hermes-home/`

## Typical Telegram bot flow

After SSH login:

```bash
hermes-akash gateway setup
# add Telegram token + provider keys when prompted
hermes-akash gateway start
```

Once the gateway is running, Hermes can answer in Telegram while the state stays on the Akash persistent volume.

## Notes and caveats

- This template is SSH-based because Hermes is primarily a CLI + messaging agent runtime, not a fixed web app.
- The default resources are sized for a general-purpose remote assistant, not GPU inference. Hermes is designed to call external model providers (OpenAI, Anthropic, OpenRouter, etc.).
- If you want a reproducible production rollout, set `HERMES_REF` to a tagged release.
- If you need browser automation with Playwright or additional system packages, install them after SSH login based on your workflow.

## Why this differs from OpenClaw

The OpenClaw Akash template exposes a setup UI over HTTP and uses a prebuilt application image. Hermes currently fits Akash better as a persistent remote agent workspace: install once, configure through SSH, then keep using Telegram/Discord/CLI as the interface.
