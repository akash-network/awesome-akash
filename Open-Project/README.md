# OpenProject on Akash Network

[OpenProject](https://www.openproject.org) is an open source project management tool. This template deploys it on [Akash Network](https://akash.network) with automatic database backups to Cloudflare R2 and file attachment storage directly to R2.

## What gets deployed

- **db** - PostgreSQL 16 database
- **cache** - Memcached for performance
- **seeder** - runs database migrations on startup then exits
- **web** - the main OpenProject app (port 80)
- **worker** - background job processor (emails, notifications, exports)
- **cron** - scheduled tasks
- **hocuspocus** - real-time collaborative document editing
- **backup** - automatic database backup to S3/R2 on every change

## Before you deploy

You need three things ready before touching the SDL:

**1. A Cloudflare R2 bucket** (or any S3-compatible storage like AWS S3 or Backblaze B2)

Log in to Cloudflare, go to R2 and create a bucket. Then under R2 settings create an API token with read and write permissions. You will get an Account ID, Access Key and Secret Key.

**2. A SendGrid account with a verified sender** (optional but recommended for email)

Create a free SendGrid account, verify a sender email address and create an API key with Mail Send permissions.

**3. Three generated secrets**

Run this command three times and save each output separately:

```bash
openssl rand -hex 64
```

These are random secure strings. Keep them private and do not lose them. If you change them after deploying all sessions will be invalidated and encrypted data may break.

## Placeholders in the SDL

Find and replace every placeholder before deploying. Here is what each one means:

| Placeholder | What to put here |
|---|---|
| `REPLACE_WITH_64_BYTE_HEX_SECRET` | First output from `openssl rand -hex 64` - used by SECRET_KEY_BASE on all services |
| `REPLACE_WITH_64_BYTE_HEX_SECRET_2` | Second output from `openssl rand -hex 64` - used by hocuspocus only |
| `REPLACE_WITH_STRONG_DB_PASSWORD` | Third output from `openssl rand -hex 64` - or any strong password you choose |
| `REPLACE_WITH_R2_ACCOUNT_ID` | Your Cloudflare Account ID (found in R2 dashboard URL) |
| `REPLACE_WITH_R2_BUCKET_NAME` | The name of your R2 bucket |
| `REPLACE_WITH_R2_ACCESS_KEY` | R2 API token Access Key ID |
| `REPLACE_WITH_R2_SECRET_KEY` | R2 API token Secret Key |
| `REPLACE_WITH_SENDGRID_API_KEY` | Your SendGrid API key (starts with SG.) |
| `REPLACE_WITH_YOUR_DOMAIN` | Your sending domain e.g. yourcompany.com |
| `REPLACE_WITH_VERIFIED_SENDER_EMAIL` | Verified sender address e.g. noreply@yourcompany.com |
| `REPLACE_AFTER_DEPLOY_WITH_INGRESS_HOSTNAME` | Leave as `localhost` for now. After deploying you will get a URL like `abc123.ingress.yourprovider.com` for the `web` service. Come back and replace this with that URL then click Update Deployment. |
| `REPLACE_AFTER_DEPLOY_WITH_HOCUSPOCUS_INGRESS_HOSTNAME` | Same as above but for the `hocuspocus` service. You get a separate URL for it. Replace this after deploying then click Update Deployment. |

Note: `SECRET_KEY_BASE` appears on multiple services (seeder, web, worker, cron). They must all have the same value. Use find and replace to update all at once.

Note: `REPLACE_WITH_STRONG_DB_PASSWORD` also appears inside `DATABASE_URL` on multiple services. Use find and replace to update all at once.

## Deploy steps

**Step 1 - First deploy**

Fill in all placeholders except the two ingress hostnames (you do not have them yet). For those two put any placeholder like `localhost` for now. Deploy to Akash Console and accept a bid from a provider.

**Step 2 - Get your URLs and update**

Once deployed and running, open your lease in Akash Console. Look for the **Forwarded Ports** or **URI** section. You will see two public URLs that look like `abc123.ingress.yourprovider.com`. One belongs to the `web` service and one to `hocuspocus`.

Open your SDL and find these two lines:

- Find `REPLACE_AFTER_DEPLOY_WITH_INGRESS_HOSTNAME` (it appears on seeder, web, worker and cron) and replace all four with the `web` URL. Use the bare hostname only, for example `abc123.ingress.yourprovider.com`. Do not include `https://` and do not add a slash at the end.
- Find `REPLACE_AFTER_DEPLOY_WITH_HOCUSPOCUS_INGRESS_HOSTNAME` and replace it with the `hocuspocus` URL in the same format.

Then click **Update Deployment** in Akash Console. Do NOT close and redeploy. Updating keeps the same lease and your data is preserved. Redeploying creates a new lease and wipes everything.

**Step 3 - First login**

Go to your web URL and log in with `admin` / `admin`. You will be forced to set a new password immediately.

## Storage note

This SDL uses ephemeral storage for the database. Ephemeral deployments attract significantly more bids on the Akash marketplace than persistent storage deployments, meaning lower costs and more provider choice. The trade-off is that any Update Deployment action or redeployment will wipe your database. This is why having both backup options set up before you start using the platform in production is important. File attachments are safe regardless since they go directly to R2.

## Backups

There are two backup options included. Here is when to use each:

- **OpenProject built-in** = full snapshot including database and attachments, triggered manually or via the API when you want a complete point-in-time backup
- **postgres-s3-backup** = always-on automatic database protection, zero human action needed

Note: the built-in backup has a daily request limit so do not rely on it as your only automated solution. The postgres-s3-backup sidecar handles that gap.

**Full backup via OpenProject UI or API (database and attachments)**

OpenProject has a built-in backup feature that covers both the database and all file attachments.

The easiest way is through the UI: go to **Administration -> Backup**, generate a backup token (starts with `opbk-`) and click **Backup OpenProject**. You will receive an email with a download link when it is ready. Check the **Include attachments** option to get everything.

You can also trigger a backup from your terminal using the API. Go to **My Account -> Access Tokens** and generate an API access token, then run:

```bash
curl -X POST https://YOUR_INGRESS_URL/api/v3/backups -H "Authorization: Bearer YOUR_API_TOKEN" -H "Content-Type: application/json" -d '{"backupToken": "opbk-YOURTOKEN", "includeAttachments": true}'
```

You will receive an email with a download link when it is ready. This is the safest full backup option since it includes file attachments that the automatic database backup does not cover.

You can also schedule this command as a cron job on your local machine or inside the `web` container shell on Akash to automate full backups on a schedule.

**Automatic database backup (postgres-s3-backup)**

The `backup` service uses the [postgres-s3-backup](https://github.com/akash-network/awesome-akash/tree/master/postgres-s3-backup) image from the official Akash awesome-akash repository. It watches for any database change and automatically uploads a compressed `pg_dump` to your R2 bucket. No action needed after deployment. Check your R2 bucket to confirm backups are landing there after you first log in and set your password.

The image (`rodrirr/nebula-sync:0.0.3`) was built specifically for Akash deployments where the backup service runs as a sidecar alongside the database in the same SDL. It supports any S3-compatible storage including Cloudflare R2, Backblaze B2 and AWS S3.

## Custom domain (optional)

If you want to use your own domain instead of the Akash-assigned URL, point a CNAME record at your ingress hostname and uncomment the `accept` block in the `web` service:

```yaml
# accept:
#   - projects.yourcompany.com
```

Then update `OPENPROJECT_HOST__NAME` to your custom domain and push an Update Deployment.

## R2 CORS configuration

For file attachment uploads to work correctly without a page refresh, add this CORS policy to your R2 bucket under Settings -> CORS Policy:

```json
[
  {
    "AllowedOrigins": ["*"],
    "AllowedMethods": ["GET", "PUT", "POST", "DELETE", "HEAD"],
    "AllowedHeaders": ["*"],
    "ExposeHeaders": ["ETag"],
    "MaxAgeSeconds": 3600
  }
]
```

## Resources

- [OpenProject documentation](https://www.openproject.org/docs/)
- [Akash Console](https://console.akash.network)
- [Cloudflare R2](https://developers.cloudflare.com/r2/)
- [postgres-s3-backup on awesome-akash](https://github.com/akash-network/awesome-akash/tree/master/postgres-s3-backup)
