# Claude Chat Workspace

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-claude-chat-workspace)

A self-hosted web interface for working with the Anthropic Claude API inside a Docker container.

## Description

Claude Workspace is a minimalist, fully functional web interface for Claude that runs in a single Docker container without requiring any additional privileges. The interface provides chat with Claude, file uploads, and a built-in terminal in the browser.

**Claude can fully interact with the container from within, installing services, creating scripts, and other applications.**

## Features

- **Chat with Claude** — full conversation support with history and multiple chats
- **Claude tools** — Claude can read/write files, browse directories, and run commands in `/workspace`
- **File uploads** — upload files directly from your computer into `/workspace`
- **Built-in terminal** — a full PTY terminal in the browser (xterm.js)
- **Shared shell context** — Claude’s commands are visible in the user’s terminal
- **Bilingual interface** — Russian and English
- **Basic Auth** — access protection with username and password
- **Single container** — does not require Docker Compose and does not require privileged mode

**Container directories:**

| Path | Purpose |
|------|---------|
| `/workspace` | Working directory: user files, scripts, project data |
| `/data` | Application service data: chat history (`/data/chats/*.json`) |

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `ANTHROPIC_API_KEY` | *(required)* | Anthropic API key |
| `CLAUDE_MODEL` | `claude-opus-4-5` | Claude model |
| `BASIC_AUTH_USERNAME` | `admin` | Login username |
| `BASIC_AUTH_PASSWORD` | `changeme` | Login password |
| `APP_HOST` | `0.0.0.0` | Server address |
| `APP_PORT` | `8000` | Server port |
| `DEFAULT_LOCALE` | `en` | Default language (`en` or `ru`) |
| `WORKSPACE_DIR` | `/workspace` | Working directory |
| `DATA_DIR` | `/data` | Application data directory |

## How to Open the Interface

After starting the container, open URL gettting from provider in LEASES tab.

Your browser will ask for a username and password (HTTP Basic Auth). Enter the values of `BASIC_AUTH_USERNAME` and `BASIC_AUTH_PASSWORD`.
___
## CREDITS
**[Decloud Nodes Lab team](https://github.com/DecloudNodesLab/Claude-Chat/blob/main/README.md)**
