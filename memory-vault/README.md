# Memory Vault

One memory for all your AI tools. This is a lightweight MCP server with a shadcn interface, built to run on Akash.

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-memory-vault)

## Quick start

1. Click **Deploy on Akash**. Optionally set a `VAULT_PASSWORD` environment variable to secure your deployment;
2. Open the deployment URL to verify;
3. Connect your AI tools to `https://<deployment-url>/mcp`:
   - **Claude.ai**: Settings → Connectors → Add custom connector;
   - **Claude Code**: `claude mcp add --transport http vault https://<deployment-url>/mcp`, then `/mcp` to log in;
   - **No OAuth support?** Send the password as a bearer token: `Authorization: Bearer <password>`.

Connected apps are listed in **Settings** (the gear icon), where you can revoke them.

## Do not lose your vault

Closing the deployment, or letting it run out of funds, deletes everything on it.

- **Git backup:** Set `BACKUP_REPO` and `BACKUP_TOKEN` to sync to any Git repo;
- **Export / Import:** A full ZIP of your vault. Import overwrites notes with the same path, but does not fully overwrite your vault.

Source and docs: https://github.com/costa2400/memory-vault
