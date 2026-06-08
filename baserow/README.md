# Baserow on Akash

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-baserow)


Baserow is an open-source no-code database platform and Airtable alternative.

This template deploys the official all-in-one Baserow Docker image on Akash.
It keeps the SDL simple by using a single service and one persistent volume.

## Services

- Baserow all-in-one container
- Internal PostgreSQL and Redis managed by the Baserow image
- Persistent storage mounted at `/baserow/data`

## Before deployment

Replace `CHANGE_ME_PUBLIC_URL` with the public URL of your Akash deployment.

Example:

```yaml
- BASEROW_PUBLIC_URL=http://your-akash-hostname.example.com
```

Use the same URL that you open in the browser. Include `http://` or `https://`.
Do not add a trailing slash.

## Persistent storage

This template uses one persistent volume:

```text
baserow-data -> /baserow/data
```

This keeps provider availability higher than a multi-container deployment with multiple persistent volumes.

## Notes

This is a minimal self-hosted Baserow template for Akash. It is intended as a simple starting point.

For more advanced production deployments, consider using external PostgreSQL, external Redis, backups, SMTP configuration, and a custom domain with HTTPS.
