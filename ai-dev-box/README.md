# AI Dev Box

A cloud dev box with Claude Code, Codex, OpenCode and Gemini CLI ready to go.

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-ai-dev-box)

## Inside

- Claude Code, Codex, OpenCode, Gemini CLI
- Node LTS, Python 3.13, uv, pm2, git, gh, tmux
- Caddy and cloudflared for putting apps online

## Use it

1. Deploy and accept a bid.
2. In the **Shell** tab, run `addkey` with your public key or GitHub username.
3. Connect: `ssh -p <port> root@<host>`, using the address forwarded to port 22.
4. Run `claude` and log in.
5. Serve your app on port 3000 and it's live at the deployment URL, or run `share <port>` for a quick HTTPS link.

Only `/root` is kept across restarts. Closing the deployment, or letting it run out of funds, deletes everything. Push your work.

Source, full docs and tutorial: https://github.com/costa2400/ai-dev-box
