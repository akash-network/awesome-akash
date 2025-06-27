# n8n - Workflow Automation on Akash

This guide explains how to deploy n8n, a powerful workflow automation tool, on the Akash Network. n8n enables you to connect different services and automate workflows with a beautiful, user-friendly interface.

## About n8n

n8n is a free and open-source workflow automation tool that allows you to connect various services and automate repetitive tasks. With its node-based approach, you can create complex workflows by connecting different services like databases, APIs, cloud services, and more.

**Key Features:**
- 🔗 Connect 400+ different services
- 🎨 Visual workflow editor
- 🔓 Self-hosted and open-source
- 📊 Custom nodes and integrations
- 🔒 Secure execution environment
- 📈 Scalable architecture

Learn more: https://n8n.io/

---

## Deployment Options

There are two SDL files provided for deploying n8n on Akash:

### 1. Basic (Ephemeral) Deployment
- Use [`deploy.yml`](./deploy.yml)
- All n8n data is stored in the container (ephemeral)
- Good for testing, demos, or workflows where you do not need to persist data after redeploy/restart
- **No persistent storage** is used

### 2. Production Deployment with PostgreSQL
- Use [`deploy-with-postgres.yml`](./deploy-with-postgres.yml)
- n8n uses a dedicated PostgreSQL database for all workflow, credential, and execution data
- **Persistent storage** is enabled for PostgreSQL, so your data is safe across restarts and redeployments
- Recommended for all real-world and production use

#### Persistent Storage Notes
- **PostgreSQL persistent storage is required** to avoid data loss (all workflows, credentials, and history are stored here)
- **n8n persistent storage is optional**. With Postgres, you do not need persistent storage for n8n unless you use custom nodes or need to store files on disk
- If you do not use persistent storage for n8n, you will not lose workflows or credentials, but you will lose any custom files or local-only changes if the container restarts
- **If your lease ends or your provider goes offline, your data in PostgreSQL persistent storage remains safe and can be recovered by redeploying to the same provider with the same persistent volume.**
- **If you switch to a different provider, you will not have access to your previous persistent storage/data.** Always back up your database regularly if you need to migrate or recover from provider loss.
- For maximum safety, schedule regular database backups and store them in a location you control (cloud storage, another server, etc.).

---

## Environment Variables

Some environment variables are unique and should be customized for your deployment:

- **N8N_ENCRYPTION_KEY**: Used to encrypt credentials in the database. You should set this to a unique, secure value. If you do not set it, n8n will generate one on first start and print it in the logs. You can then update your SDL with this value for future redeployments to avoid losing access to encrypted credentials.
- **GENERIC_TIMEZONE / TZ**: Set your preferred timezone.
- **N8N_HOST / WEBHOOK_URL**: Set these to match your deployment domain if you want to use webhooks or expose the UI externally.
- **DB_POSTGRESDB_* variables**: Set your own database name, user, and password for security.

**Tip:**
- After your first deployment, check the n8n logs for the generated `N8N_ENCRYPTION_KEY` if you did not set one. Update your SDL with this value and redeploy to ensure you can always decrypt credentials.

---

## How to Deploy

1. Choose the SDL file that matches your needs (`deploy.yml` for ephemeral, `deploy-with-postgres.yml` for production/persistent)
2. Edit environment variables as needed (see above)
3. Deploy using the Akash Console or CLI
4. After deployment, access your n8n instance via the provided Akash URL
5. (Optional) Update your SDL with the generated `N8N_ENCRYPTION_KEY` from the logs and redeploy

---

## Resource Recommendations

Choose your resources based on your use case and budget:

- **Testing / Personal Use:**
  - n8n: 0.5 CPU, 768Mi–1Gi RAM
  - Postgres: 0.25–0.5 CPU, 512Mi–1Gi RAM, 2–5Gi storage
- **Small Team / Light Production:**
  - n8n: 1 CPU, 2Gi RAM
  - Postgres: 0.5 CPU, 1Gi RAM, 5–10Gi storage
- **Heavy Workloads / Many Users:**
  - n8n: 2+ CPU, 4Gi+ RAM
  - Postgres: 1+ CPU, 2Gi+ RAM, 10Gi+ storage

For best pricing, start with the minimum for your use case and scale up only if you see performance issues (slow UI, failed executions, or high resource usage in logs).

---

## License Notice

n8n is licensed under the [Sustainable Use License](https://github.com/n8n-io/n8n/blob/master/LICENSE.md) (SUL). **You may use n8n for personal, internal, or company use, but you may NOT offer n8n as a service to others (SaaS, workflow automation for clients, etc.) without a commercial license from n8n.io.**

- You can self-host n8n for your own workflows or for your organization.
- You cannot resell, rebrand, or offer n8n as a paid service to third parties without permission.
- For more details, see the [n8n license FAQ](https://docs.n8n.io/hosting/licensing/).

---

## Using the Latest n8n Version

To use the latest features and updates, you can set the image in your SDL to:

```
image: n8nio/n8n:latest
```

You can find all available n8n image tags and versions here: [n8nio/n8n Docker Hub](https://hub.docker.com/r/n8nio/n8n/tags)

> **Note:** Using `:latest` will always pull the newest version, which may include breaking changes. For production, consider pinning to a specific version tag for stability.

---

For more details on n8n features and configuration, see the [n8n documentation](https://docs.n8n.io/).

If you need to persist custom files or use custom nodes, see the n8n docs for advanced persistent storage options and custom Docker images.
