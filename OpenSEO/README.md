# OpenSEO on Akash Network

[OpenSEO](https://github.com/every-app/open-seo) is an open-source alternative to Semrush and Ahrefs: keyword research, domain overview, backlinks, rank tracking, site audits and an MCP server for AI agents. This template runs the official OpenSEO image on Akash with a Caddy proxy in front that adds a login.

## Requirements

- An Akash wallet with funds for the deployment.
- **A DataForSEO account and API credentials** ([dataforseo.com](https://dataforseo.com/)). OpenSEO gets all its SEO data from DataForSEO, which is pay-as-you-go and billed to you directly. New accounts include $1 of free credit; the minimum top-up is $50.

## Two credentials to set

Both live in `deploy.yaml` and both must be changed before you deploy:

| Variable | What it is | Where to get it |
|---|---|---|
| `DATAFORSEO_API_KEY` | Base64 credential for DataForSEO | DataForSEO > [API Access](https://app.dataforseo.com/api-access) > **Send by email**, copy the **Base64** value |
| `BASIC_AUTH_PASSWORD` | Password for the OpenSEO web login | You choose it. Username is `admin` (`BASIC_AUTH_USER`) |

## Why a proxy?

OpenSEO's Docker mode runs with no login (`AUTH_MODE=local_noauth`). On a public Akash URL anyone could open it and spend your DataForSEO credit. The SDL exposes only the Caddy proxy (HTTP basic auth); OpenSEO itself is reachable only inside the deployment.

## Deploy

1. Open `deploy.yaml`, set the two credentials above.
2. Deploy it with Akash Air, Akash Console or the Akash CLI, choose a provider and accept the bid.
3. The first start takes 1-2 minutes while the app builds. Watch the `open-seo` logs.
4. Open the URL of the `proxy` service and sign in as `admin` with your `BASIC_AUTH_PASSWORD`.
5. Run a keyword search to confirm DataForSEO is connected.

## Persistence

Data is stored in `/app/.wrangler` on a persistent volume (5Gi). Updating the deployment (for example changing a key) keeps your data. Closing the deployment deletes it.

## Optional settings

- **AI features (SAM in-app agent):** uncomment `OPENROUTER_API_KEY` (and optionally `OPENROUTER_MODEL`) in the `open-seo` env. Not needed for anything else.
- **Google Search Console / Analytics:** add `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET` and `BETTER_AUTH_SECRET` (32+ random characters). See the upstream docs.
- Telemetry is off by default (`OPENSEO_TELEMETRY_DISABLED=1`).

## Notes and limits

- Image versions are pinned (`open-seo:v0.1.6`, `caddy:2.10.0-alpine`). To upgrade, change the tag and update the deployment.
- Rank-tracking schedules do not run in Docker mode; trigger checks from the Rank Tracking page.
- Basic auth is a single shared login, not multi-user auth. OpenSEO documents Cloudflare as its recommended setup for team use.
- Upstream also documents `/api/health` for configuration and database status.

## Troubleshooting

- **"DataForSEO rejected the API key":** `DATAFORSEO_API_KEY` must be the Base64 of `email:password` (the Base64 value from DataForSEO's email). Fix it and update the deployment.
- **Login fails:** use username `admin` and the value of `BASIC_AUTH_PASSWORD`.
- **Page not ready right after deploy:** the app is still building; wait 1-2 minutes.

License: OpenSEO is MIT licensed.
