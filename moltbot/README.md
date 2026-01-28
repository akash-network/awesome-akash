# 🦞 Moltbot (Previously Clawdbot) — Personal AI Assistant

<p align="center">
  <img src="https://raw.githubusercontent.com/moltbot/moltbot/main/docs/whatsapp-clawd.jpg" alt="Clawdbot" width="400">
</p>

<p align="center">
  <strong>EXFOLIATE! EXFOLIATE!</strong>
</p>

<p align="center">
  <a href="https://github.com/moltbot/moltbot/actions/workflows/ci.yml?branch=main"><img src="https://img.shields.io/github/actions/workflow/status/moltbot/moltbot/ci.yml?branch=main&style=for-the-badge" alt="CI status"></a>
  <a href="https://github.com/moltbot/moltbot/releases"><img src="https://img.shields.io/github/v/release/moltbot/moltbot?include_prereleases&style=for-the-badge" alt="GitHub release"></a>
  <a href="https://deepwiki.com/moltbot/moltbot"><img src="https://img.shields.io/badge/DeepWiki-moltbot-111111?style=for-the-badge" alt="DeepWiki"></a>
  <a href="https://discord.gg/clawd"><img src="https://img.shields.io/discord/1456350064065904867?label=Discord&logo=discord&logoColor=white&color=5865F2&style=for-the-badge" alt="Discord"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge" alt="MIT License"></a>
</p>

**Moltbot** is a *personal AI assistant* you run on your own devices.
It answers you on the channels you already use (WhatsApp, Telegram, Slack, Discord, Google Chat, Signal, iMessage, Microsoft Teams, WebChat), plus extension channels like BlueBubbles, Matrix, Zalo, and Zalo Personal. It can speak and listen on macOS/iOS/Android, and can render a live Canvas you control. The Gateway is just the control plane — the product is the assistant.

If you want a personal, single-user assistant that feels local, fast, and always-on, this is it.

[Website](https://molt.bot) · [Docs](https://docs.molt.bot) · [Getting Started](https://docs.molt.bot/start/getting-started) · [Updating](https://docs.molt.bot/install/updating) · [Showcase](https://docs.molt.bot/start/showcase) · [FAQ](https://docs.molt.bot/start/faq) · [Wizard](https://docs.molt.bot/start/wizard) · [Nix](https://github.com/moltbot/nix-clawdbot) · [Docker](https://docs.molt.bot/install/docker) · [Discord](https://discord.gg/clawd)

Preferred setup: run the onboarding wizard (`moltbot onboard`). It walks through gateway, workspace, channels, and skills. The CLI wizard is the recommended path and works on **macOS, Linux, and Windows (via WSL2; strongly recommended)**.
Works with npm, pnpm, or bun.
New install? Start here: [Getting started](https://docs.molt.bot/start/getting-started)

**Subscriptions (OAuth):**
- **[Anthropic](https://www.anthropic.com/)** (Claude Pro/Max)
- **[OpenAI](https://openai.com/)** (ChatGPT/Codex)

Model note: while any model is supported, I strongly recommend **Anthropic Pro/Max (100/200) + Opus 4.5** for long‑context strength and better prompt‑injection resistance. See [Onboarding](https://docs.molt.bot/start/onboarding).

## Models (selection + auth)

- Models config + CLI: [Models](https://docs.molt.bot/concepts/models)
- Auth profile rotation (OAuth vs API keys) + fallbacks: [Model failover](https://docs.molt.bot/concepts/model-failover)

## Install (recommended)

Runtime: **Node ≥22**.

```bash
npm install -g moltbot@latest
# or: pnpm add -g moltbot@latest

moltbot onboard --install-daemon
```

The wizard installs the Gateway daemon (launchd/systemd user service) so it stays running.
Legacy note: `clawdbot` remains available as a compatibility shim.

## Quick start (TL;DR)

Runtime: **Node ≥22**.

Full beginner guide (auth, pairing, channels): [Getting started](https://docs.molt.bot/start/getting-started)

```bash
moltbot onboard --install-daemon

moltbot gateway --port 18789 --verbose

# Send a message
moltbot message send --to +1234567890 --message "Hello from Moltbot"

# Talk to the assistant (optionally deliver back to any connected channel: WhatsApp/Telegram/Slack/Discord/Google Chat/Signal/iMessage/BlueBubbles/Microsoft Teams/Matrix/Zalo/Zalo Personal/WebChat)
moltbot agent --message "Ship checklist" --thinking high
```

Upgrading? [Updating guide](https://docs.molt.bot/install/updating) (and run `moltbot doctor`).

## Development channels

- **stable**: tagged releases (`vYYYY.M.D` or `vYYYY.M.D-<patch>`), npm dist-tag `latest`.
- **beta**: prerelease tags (`vYYYY.M.D-beta.N`), npm dist-tag `beta` (macOS app may be missing).
- **dev**: moving head of `main`, npm dist-tag `dev` (when published).

Switch channels (git + npm): `moltbot update --channel stable|beta|dev`.
Details: [Development channels](https://docs.molt.bot/install/development-channels).

## From source (development)

Prefer `pnpm` for builds from source. Bun is optional for running TypeScript directly.

```bash
git clone https://github.com/moltbot/moltbot.git
cd moltbot

pnpm install
pnpm ui:build # auto-installs UI deps on first run
pnpm build

pnpm moltbot onboard --install-daemon

# Dev loop (auto-reload on TS changes)
pnpm gateway:watch
```

Note: `pnpm moltbot ...` runs TypeScript directly (via `tsx`). `pnpm build` produces `dist/` for running via Node / the packaged `moltbot` binary.

## Security defaults (DM access)

Moltbot connects to real messaging surfaces. Treat inbound DMs as **untrusted input**.

Full security guide: [Security](https://docs.molt.bot/gateway/security)

Default behavior on Telegram/WhatsApp/Signal/iMessage/Microsoft Teams/Discord/Google Chat/Slack:
- **DM pairing** (`dmPolicy="pairing"` / `channels.discord.dm.policy="pairing"` / `channels.slack.dm.policy="pairing"`): unknown senders receive a short pairing code and the bot does not process their message.
- Approve with: `moltbot pairing approve <channel> <code>` (then the sender is added to a local allowlist store).
- Public inbound DMs require an explicit opt-in: set `dmPolicy="open"` and include `"*"` in the channel allowlist (`allowFrom` / `channels.discord.dm.allowFrom` / `channels.slack.dm.allowFrom`).

Run `moltbot doctor` to surface risky/misconfigured DM policies.

## Highlights

- **[Local-first Gateway](https://docs.molt.bot/gateway)** — single control plane for sessions, channels, tools, and events.
- **[Multi-channel inbox](https://docs.molt.bot/channels)** — WhatsApp, Telegram, Slack, Discord, Google Chat, Signal, iMessage, BlueBubbles, Microsoft Teams, Matrix, Zalo, Zalo Personal, WebChat, macOS, iOS/Android.
- **[Multi-agent routing](https://docs.molt.bot/gateway/configuration)** — route inbound channels/accounts/peers to isolated agents (workspaces + per-agent sessions).
- **[Voice Wake](https://docs.molt.bot/nodes/voicewake) + [Talk Mode](https://docs.molt.bot/nodes/talk)** — always-on speech for macOS/iOS/Android with ElevenLabs.
- **[Live Canvas](https://docs.molt.bot/platforms/mac/canvas)** — agent-driven visual workspace with [A2UI](https://docs.molt.bot/platforms/mac/canvas#canvas-a2ui).
- **[First-class tools](https://docs.molt.bot/tools)** — browser, canvas, nodes, cron, sessions, and Discord/Slack actions.
- **[Companion apps](https://docs.molt.bot/platforms/macos)** — macOS menu bar app + iOS/Android [nodes](https://docs.molt.bot/nodes).
- **[Onboarding](https://docs.molt.bot/start/wizard) + [skills](https://docs.molt.bot/tools/skills)** — wizard-driven setup with bundled/managed/workspace skills.

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=moltbot/moltbot&type=date&legend=top-left)](https://www.star-history.com/#moltbot/moltbot&type=date&legend=top-left)

## Everything we built so far

### Core platform
- [Gateway WS control plane](https://docs.molt.bot/gateway) with sessions, presence, config, cron, webhooks, [Control UI](https://docs.molt.bot/web), and [Canvas host](https://docs.molt.bot/platforms/mac/canvas#canvas-a2ui).
- [CLI surface](https://docs.molt.bot/tools/agent-send): gateway, agent, send, [wizard](https://docs.molt.bot/start/wizard), and [doctor](https://docs.molt.bot/gateway/doctor).
- [Pi agent runtime](https://docs.molt.bot/concepts/agent) in RPC mode with tool streaming and block streaming.
- [Session model](https://docs.molt.bot/concepts/session): `main` for direct chats, group isolation, activation modes, queue modes, reply-back. Group rules: [Groups](https://docs.molt.bot/concepts/groups).
- [Media pipeline](https://docs.molt.bot/nodes/images): images/audio/video, transcription hooks, size caps, temp file lifecycle. Audio details: [Audio](https://docs.molt.bot/nodes/audio).

### Channels
- [Channels](https://docs.molt.bot/channels): [WhatsApp](https://docs.molt.bot/channels/whatsapp) (Baileys), [Telegram](https://docs.molt.bot/channels/telegram) (grammY), [Slack](https://docs.molt.bot/channels/slack) (Bolt), [Discord](https://docs.molt.bot/channels/discord) (discord.js), [Google Chat](https://docs.molt.bot/channels/googlechat) (Chat API), [Signal](https://docs.molt.bot/channels/signal) (signal-cli), [iMessage](https://docs.molt.bot/channels/imessage) (imsg), [BlueBubbles](https://docs.molt.bot/channels/bluebubbles) (extension), [Microsoft Teams](https://docs.molt.bot/channels/msteams) (extension), [Matrix](https://docs.molt.bot/channels/matrix) (extension), [Zalo](https://docs.molt.bot/channels/zalo) (extension), [Zalo Personal](https://docs.molt.bot/channels/zalouser) (extension), [WebChat](https://docs.molt.bot/web/webchat).
- [Group routing](https://docs.molt.bot/concepts/group-messages): mention gating, reply tags, per-channel chunking and routing. Channel rules: [Channels](https://docs.molt.bot/channels).

### Apps + nodes
- [macOS app](https://docs.molt.bot/platforms/macos): menu bar control plane, [Voice Wake](https://docs.molt.bot/nodes/voicewake)/PTT, [Talk Mode](https://docs.molt.bot/nodes/talk) overlay, [WebChat](https://docs.molt.bot/web/webchat), debug tools, [remote gateway](https://docs.molt.bot/gateway/remote) control.
- [iOS node](https://docs.molt.bot/platforms/ios): [Canvas](https://docs.molt.bot/platforms/mac/canvas), [Voice Wake](https://docs.molt.bot/nodes/voicewake), [Talk Mode](https://docs.molt.bot/nodes/talk), camera, screen recording, Bonjour pairing.
- [Android node](https://docs.molt.bot/platforms/android): [Canvas](https://docs.molt.bot/platforms/mac/canvas), [Talk Mode](https://docs.molt.bot/nodes/talk), camera, screen recording, optional SMS.
- [macOS node mode](https://docs.molt.bot/nodes): system.run/notify + canvas/camera exposure.

### Tools + automation
- [Browser control](https://docs.molt.bot/tools/browser): dedicated moltbot Chrome/Chromium, snapshots, actions, uploads, profiles.
- [Canvas](https://docs.molt.bot/platforms/mac/canvas): [A2UI](https://docs.molt.bot/platforms/mac/canvas#canvas-a2ui) push/reset, eval, snapshot.
- [Nodes](https://docs.molt.bot/nodes): camera snap/clip, screen record, [location.get](https://docs.molt.bot/nodes/location-command), notifications.
- [Cron + wakeups](https://docs.molt.bot/automation/cron-jobs); [webhooks](https://docs.molt.bot/automation/webhook); [Gmail Pub/Sub](https://docs.molt.bot/automation/gmail-pubsub).
- [Skills platform](https://docs.molt.bot/tools/skills): bundled, managed, and workspace skills with install gating + UI.

### Runtime + safety
- [Channel routing](https://docs.molt.bot/concepts/channel-routing), [retry policy](https://docs.molt.bot/concepts/retry), and [streaming/chunking](https://docs.molt.bot/concepts/streaming).
- [Presence](https://docs.molt.bot/concepts/presence), [typing indicators](https://docs.molt.bot/concepts/typing-indicators), and [usage tracking](https://docs.molt.bot/concepts/usage-tracking).
- [Models](https://docs.molt.bot/concepts/models), [model failover](https://docs.molt.bot/concepts/model-failover), and [session pruning](https://docs.molt.bot/concepts/session-pruning).
- [Security](https://docs.molt.bot/gateway/security) and [troubleshooting](https://docs.molt.bot/channels/troubleshooting).

### Ops + packaging
- [Control UI](https://docs.molt.bot/web) + [WebChat](https://docs.molt.bot/web/webchat) served directly from the Gateway.
- [Tailscale Serve/Funnel](https://docs.molt.bot/gateway/tailscale) or [SSH tunnels](https://docs.molt.bot/gateway/remote) with token/password auth.
- [Nix mode](https://docs.molt.bot/install/nix) for declarative config; [Docker](https://docs.molt.bot/install/docker)-based installs.
- [Doctor](https://docs.molt.bot/gateway/doctor) migrations, [logging](https://docs.molt.bot/logging).

## How it works (short)

```
WhatsApp / Telegram / Slack / Discord / Google Chat / Signal / iMessage / BlueBubbles / Microsoft Teams / Matrix / Zalo / Zalo Personal / WebChat
               │
               ▼
┌───────────────────────────────┐
│            Gateway            │
│       (control plane)         │
│     ws://127.0.0.1:18789      │
└──────────────┬────────────────┘
               │
               ├─ Pi agent (RPC)
               ├─ CLI (moltbot …)
               ├─ WebChat UI
               ├─ macOS app
               └─ iOS / Android nodes
```

## Key subsystems

- **[Gateway WebSocket network](https://docs.molt.bot/concepts/architecture)** — single WS control plane for clients, tools, and events (plus ops: [Gateway runbook](https://docs.molt.bot/gateway)).
- **[Tailscale exposure](https://docs.molt.bot/gateway/tailscale)** — Serve/Funnel for the Gateway dashboard + WS (remote access: [Remote](https://docs.molt.bot/gateway/remote)).
- **[Browser control](https://docs.molt.bot/tools/browser)** — moltbot‑managed Chrome/Chromium with CDP control.
- **[Canvas + A2UI](https://docs.molt.bot/platforms/mac/canvas)** — agent‑driven visual workspace (A2UI host: [Canvas/A2UI](https://docs.molt.bot/platforms/mac/canvas#canvas-a2ui)).
- **[Voice Wake](https://docs.molt.bot/nodes/voicewake) + [Talk Mode](https://docs.molt.bot/nodes/talk)** — always‑on speech and continuous conversation.
- **[Nodes](https://docs.molt.bot/nodes)** — Canvas, camera snap/clip, screen record, `location.get`, notifications, plus macOS‑only `system.run`/`system.notify`.

## Tailscale access (Gateway dashboard)

Moltbot can auto-configure Tailscale **Serve** (tailnet-only) or **Funnel** (public) while the Gateway stays bound to loopback. Configure `gateway.tailscale.mode`:

- `off`: no Tailscale automation (default).
- `serve`: tailnet-only HTTPS via `tailscale serve` (uses Tailscale identity headers by default).
- `funnel`: public HTTPS via `tailscale funnel` (requires shared password auth).

Notes:
- `gateway.bind` must stay `loopback` when Serve/Funnel is enabled (Moltbot enforces this).
- Serve can be forced to require a password by setting `gateway.auth.mode: "password"` or `gateway.auth.allowTailscale: false`.
- Funnel refuses to start unless `gateway.auth.mode: "password"` is set.
- Optional: `gateway.tailscale.resetOnExit` to undo Serve/Funnel on shutdown.

Details: [Tailscale guide](https://docs.molt.bot/gateway/tailscale) · [Web surfaces](https://docs.molt.bot/web)

## Remote Gateway (Linux is great)

It’s perfectly fine to run the Gateway on a small Linux instance. Clients (macOS app, CLI, WebChat) can connect over **Tailscale Serve/Funnel** or **SSH tunnels**, and you can still pair device nodes (macOS/iOS/Android) to execute device‑local actions when needed.

- **Gateway host** runs the exec tool and channel connections by default.
- **Device nodes** run device‑local actions (`system.run`, camera, screen recording, notifications) via `node.invoke`.
In short: exec runs where the Gateway lives; device actions run where the device lives.

Details: [Remote access](https://docs.molt.bot/gateway/remote) · [Nodes](https://docs.molt.bot/nodes) · [Security](https://docs.molt.bot/gateway/security)

## macOS permissions via the Gateway protocol

The macOS app can run in **node mode** and advertises its capabilities + permission map over the Gateway WebSocket (`node.list` / `node.describe`). Clients can then execute local actions via `node.invoke`:

- `system.run` runs a local command and returns stdout/stderr/exit code; set `needsScreenRecording: true` to require screen-recording permission (otherwise you’ll get `PERMISSION_MISSING`).
- `system.notify` posts a user notification and fails if notifications are denied.
- `canvas.*`, `camera.*`, `screen.record`, and `location.get` are also routed via `node.invoke` and follow TCC permission status.

Elevated bash (host permissions) is separate from macOS TCC:

- Use `/elevated on|off` to toggle per‑session elevated access when enabled + allowlisted.
- Gateway persists the per‑session toggle via `sessions.patch` (WS method) alongside `thinkingLevel`, `verboseLevel`, `model`, `sendPolicy`, and `groupActivation`.

Details: [Nodes](https://docs.molt.bot/nodes) · [macOS app](https://docs.molt.bot/platforms/macos) · [Gateway protocol](https://docs.molt.bot/concepts/architecture)

## Agent to Agent (sessions_* tools)

- Use these to coordinate work across sessions without jumping between chat surfaces.
- `sessions_list` — discover active sessions (agents) and their metadata.
- `sessions_history` — fetch transcript logs for a session.
- `sessions_send` — message another session; optional reply‑back ping‑pong + announce step (`REPLY_SKIP`, `ANNOUNCE_SKIP`).

Details: [Session tools](https://docs.molt.bot/concepts/session-tool)

## Skills registry (ClawdHub)

ClawdHub is a minimal skill registry. With ClawdHub enabled, the agent can search for skills automatically and pull in new ones as needed.

[ClawdHub](https://ClawdHub.com)

## Chat commands

Send these in WhatsApp/Telegram/Slack/Google Chat/Microsoft Teams/WebChat (group commands are owner-only):

- `/status` — compact session status (model + tokens, cost when available)
- `/new` or `/reset` — reset the session
- `/compact` — compact session context (summary)
- `/think <level>` — off|minimal|low|medium|high|xhigh (GPT-5.2 + Codex models only)
- `/verbose on|off`
- `/usage off|tokens|full` — per-response usage footer
- `/restart` — restart the gateway (owner-only in groups)
- `/activation mention|always` — group activation toggle (groups only)

## Apps (optional)

The Gateway alone delivers a great experience. All apps are optional and add extra features.

If you plan to build/run companion apps, follow the platform runbooks below.

### macOS (Moltbot.app) (optional)

- Menu bar control for the Gateway and health.
- Voice Wake + push-to-talk overlay.
- WebChat + debug tools.
- Remote gateway control over SSH.

Note: signed builds required for macOS permissions to stick across rebuilds (see `docs/mac/permissions.md`).

### iOS node (optional)

- Pairs as a node via the Bridge.
- Voice trigger forwarding + Canvas surface.
- Controlled via `moltbot nodes …`.

Runbook: [iOS connect](https://docs.molt.bot/platforms/ios).

### Android node (optional)

- Pairs via the same Bridge + pairing flow as iOS.
- Exposes Canvas, Camera, and Screen capture commands.
- Runbook: [Android connect](https://docs.molt.bot/platforms/android).

## Agent workspace + skills

- Workspace root: `~/clawd` (configurable via `agents.defaults.workspace`).
- Injected prompt files: `AGENTS.md`, `SOUL.md`, `TOOLS.md`.
- Skills: `~/clawd/skills/<skill>/SKILL.md`.

## Configuration

Minimal `~/.clawdbot/moltbot.json` (model + defaults):

```json5
{
  agent: {
    model: "anthropic/claude-opus-4-5"
  }
}
```

[Full configuration reference (all keys + examples).](https://docs.molt.bot/gateway/configuration)

## Security model (important)

- **Default:** tools run on the host for the **main** session, so the agent has full access when it’s just you.
- **Group/channel safety:** set `agents.defaults.sandbox.mode: "non-main"` to run **non‑main sessions** (groups/channels) inside per‑session Docker sandboxes; bash then runs in Docker for those sessions.
- **Sandbox defaults:** allowlist `bash`, `process`, `read`, `write`, `edit`, `sessions_list`, `sessions_history`, `sessions_send`, `sessions_spawn`; denylist `browser`, `canvas`, `nodes`, `cron`, `discord`, `gateway`.

Details: [Security guide](https://docs.molt.bot/gateway/security) · [Docker + sandboxing](https://docs.molt.bot/install/docker) · [Sandbox config](https://docs.molt.bot/gateway/configuration)

### [WhatsApp](https://docs.molt.bot/channels/whatsapp)

- Link the device: `pnpm moltbot channels login` (stores creds in `~/.clawdbot/credentials`).
- Allowlist who can talk to the assistant via `channels.whatsapp.allowFrom`.
- If `channels.whatsapp.groups` is set, it becomes a group allowlist; include `"*"` to allow all.

### [Telegram](https://docs.molt.bot/channels/telegram)

- Set `TELEGRAM_BOT_TOKEN` or `channels.telegram.botToken` (env wins).
- Optional: set `channels.telegram.groups` (with `channels.telegram.groups."*".requireMention`); when set, it is a group allowlist (include `"*"` to allow all). Also `channels.telegram.allowFrom` or `channels.telegram.webhookUrl` as needed.

```json5
{
  channels: {
    telegram: {
      botToken: "123456:ABCDEF"
    }
  }
}
```

### [Slack](https://docs.molt.bot/channels/slack)

- Set `SLACK_BOT_TOKEN` + `SLACK_APP_TOKEN` (or `channels.slack.botToken` + `channels.slack.appToken`).

### [Discord](https://docs.molt.bot/channels/discord)

- Set `DISCORD_BOT_TOKEN` or `channels.discord.token` (env wins).
- Optional: set `commands.native`, `commands.text`, or `commands.useAccessGroups`, plus `channels.discord.dm.allowFrom`, `channels.discord.guilds`, or `channels.discord.mediaMaxMb` as needed.

```json5
{
  channels: {
    discord: {
      token: "1234abcd"
    }
  }
}
```

### [Signal](https://docs.molt.bot/channels/signal)

- Requires `signal-cli` and a `channels.signal` config section.

### [iMessage](https://docs.molt.bot/channels/imessage)

- macOS only; Messages must be signed in.
- If `channels.imessage.groups` is set, it becomes a group allowlist; include `"*"` to allow all.

### [Microsoft Teams](https://docs.molt.bot/channels/msteams)

- Configure a Teams app + Bot Framework, then add a `msteams` config section.
- Allowlist who can talk via `msteams.allowFrom`; group access via `msteams.groupAllowFrom` or `msteams.groupPolicy: "open"`.

### [WebChat](https://docs.molt.bot/web/webchat)

- Uses the Gateway WebSocket; no separate WebChat port/config.

Browser control (optional):

```json5
{
  browser: {
    enabled: true,
    color: "#FF4500"
  }
}
```

## Docs

Use these when you’re past the onboarding flow and want the deeper reference.
- [Start with the docs index for navigation and “what’s where.”](https://docs.molt.bot)
- [Read the architecture overview for the gateway + protocol model.](https://docs.molt.bot/concepts/architecture)
- [Use the full configuration reference when you need every key and example.](https://docs.molt.bot/gateway/configuration)
- [Run the Gateway by the book with the operational runbook.](https://docs.molt.bot/gateway)
- [Learn how the Control UI/Web surfaces work and how to expose them safely.](https://docs.molt.bot/web)
- [Understand remote access over SSH tunnels or tailnets.](https://docs.molt.bot/gateway/remote)
- [Follow the onboarding wizard flow for a guided setup.](https://docs.molt.bot/start/wizard)
- [Wire external triggers via the webhook surface.](https://docs.molt.bot/automation/webhook)
- [Set up Gmail Pub/Sub triggers.](https://docs.molt.bot/automation/gmail-pubsub)
- [Learn the macOS menu bar companion details.](https://docs.molt.bot/platforms/mac/menu-bar)
- [Platform guides: Windows (WSL2)](https://docs.molt.bot/platforms/windows), [Linux](https://docs.molt.bot/platforms/linux), [macOS](https://docs.molt.bot/platforms/macos), [iOS](https://docs.molt.bot/platforms/ios), [Android](https://docs.molt.bot/platforms/android)
- [Debug common failures with the troubleshooting guide.](https://docs.molt.bot/channels/troubleshooting)
- [Review security guidance before exposing anything.](https://docs.molt.bot/gateway/security)

## Advanced docs (discovery + control)

- [Discovery + transports](https://docs.molt.bot/gateway/discovery)
- [Bonjour/mDNS](https://docs.molt.bot/gateway/bonjour)
- [Gateway pairing](https://docs.molt.bot/gateway/pairing)
- [Remote gateway README](https://docs.molt.bot/gateway/remote-gateway-readme)
- [Control UI](https://docs.molt.bot/web/control-ui)
- [Dashboard](https://docs.molt.bot/web/dashboard)

## Operations & troubleshooting

- [Health checks](https://docs.molt.bot/gateway/health)
- [Gateway lock](https://docs.molt.bot/gateway/gateway-lock)
- [Background process](https://docs.molt.bot/gateway/background-process)
- [Browser troubleshooting (Linux)](https://docs.molt.bot/tools/browser-linux-troubleshooting)
- [Logging](https://docs.molt.bot/logging)

## Deep dives

- [Agent loop](https://docs.molt.bot/concepts/agent-loop)
- [Presence](https://docs.molt.bot/concepts/presence)
- [TypeBox schemas](https://docs.molt.bot/concepts/typebox)
- [RPC adapters](https://docs.molt.bot/reference/rpc)
- [Queue](https://docs.molt.bot/concepts/queue)

## Workspace & skills

- [Skills config](https://docs.molt.bot/tools/skills-config)
- [Default AGENTS](https://docs.molt.bot/reference/AGENTS.default)
- [Templates: AGENTS](https://docs.molt.bot/reference/templates/AGENTS)
- [Templates: BOOTSTRAP](https://docs.molt.bot/reference/templates/BOOTSTRAP)
- [Templates: IDENTITY](https://docs.molt.bot/reference/templates/IDENTITY)
- [Templates: SOUL](https://docs.molt.bot/reference/templates/SOUL)
- [Templates: TOOLS](https://docs.molt.bot/reference/templates/TOOLS)
- [Templates: USER](https://docs.molt.bot/reference/templates/USER)

## Platform internals

- [macOS dev setup](https://docs.molt.bot/platforms/mac/dev-setup)
- [macOS menu bar](https://docs.molt.bot/platforms/mac/menu-bar)
- [macOS voice wake](https://docs.molt.bot/platforms/mac/voicewake)
- [iOS node](https://docs.molt.bot/platforms/ios)
- [Android node](https://docs.molt.bot/platforms/android)
- [Windows (WSL2)](https://docs.molt.bot/platforms/windows)
- [Linux app](https://docs.molt.bot/platforms/linux)

## Email hooks (Gmail)

- [docs.molt.bot/gmail-pubsub](https://docs.molt.bot/automation/gmail-pubsub)

## Molty

Moltbot was built for **Molty**, a space lobster AI assistant. 🦞
by Peter Steinberger and the community.

- [clawd.me](https://clawd.me)
- [soul.md](https://soul.md)
- [steipete.me](https://steipete.me)
- [@moltbot](https://x.com/moltbot)

## Community

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines, maintainers, and how to submit PRs.
AI/vibe-coded PRs welcome! 🤖

Special thanks to [Mario Zechner](https://mariozechner.at/) for his support and for
[pi-mono](https://github.com/badlogic/pi-mono).