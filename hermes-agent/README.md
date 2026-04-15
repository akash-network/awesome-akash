# Hermes Agent on Akash Console

This template deploys [Hermes Agent](https://github.com/NousResearch/hermes-agent) on Akash as a persistent remote workspace.

It now supports a hybrid flow:

1. SSH always remains available on port `22`.
2. If you set only the minimal Telegram variables, Hermes auto-configures a default Telegram home channel and starts the gateway automatically.
3. If you leave those variables empty, the deployment behaves like a plain SSH workspace and you can finish setup manually later.

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
- Optionally bootstraps a minimal Telegram config on first start.
- Optionally auto-starts `hermes gateway` when minimal Telegram env vars are present.

## Minimal zero-SSH Telegram setup

Set these in Akash Console:

- `TELEGRAM_BOT_TOKEN` — your bot token
- `TELEGRAM_HOME_CHANNEL` — your Telegram user/chat ID

Optional display name:

- `TELEGRAM_HOME_CHANNEL_NAME=Home`

With just those values set, the container will:

- keep SSH available
- write `TELEGRAM_BOT_TOKEN` into `/workspace/hermes-home/.env`
- write a default Telegram `home_channel` into `/workspace/hermes-home/config.yaml`
- start `hermes gateway` automatically

No topics or advanced Telegram settings are prefilled. Those can be configured later from inside Hermes if you want.

## Optional model/provider env vars

You can also prefill the runtime model selection:

- `HERMES_MODEL` — for example `openai/gpt-5.4` or `anthropic/claude-sonnet-4-6`
- `HERMES_PROVIDER` — for example `openrouter`, `anthropic`, `openai-codex`, `auto`

And whichever provider keys you use, for example:

- `OPENROUTER_API_KEY`
- `OPENAI_API_KEY`
- `ANTHROPIC_API_KEY`

## SSH-first fallback mode

If `TELEGRAM_BOT_TOKEN` or `TELEGRAM_HOME_CHANNEL` is left empty, the container does not auto-start the gateway. It behaves like a normal SSH workspace instead.

After SSH login, you can still run:

```bash
hermes-akash setup
hermes-akash gateway setup
hermes-akash gateway start
```

## Persistent paths

- Hermes repo: `/workspace/hermes-agent`
- Hermes profile home: `/workspace/hermes-home`
- Provider keys / tokens: `/workspace/hermes-home/.env`
- Main config: `/workspace/hermes-home/config.yaml`
- Sessions, skills, memories, logs: under `/workspace/hermes-home/`

## Notes about the default Telegram config

The auto-generated config is intentionally minimal:

- Telegram is enabled
- a default `home_channel` is set from `TELEGRAM_HOME_CHANNEL`
- `reply_to_mode` defaults to `first`
- no topics are preconfigured
- no advanced mention / reaction / free-response settings are forced

This keeps the Akash template simple while still giving you a working bot immediately after deploy.

## First boot behavior

On the first boot, if the Telegram autostart env vars are present, the template writes the default Telegram config once and drops a marker file in the persistent volume so later restarts do not overwrite your manual config edits.

## Why this differs from OpenClaw

The OpenClaw Akash template exposes a setup UI over HTTP and stores configuration through that UI. Hermes is better suited to an SSH + messaging workflow, so this template uses environment-driven bootstrap for the minimal path and still leaves the full SSH workflow available.
