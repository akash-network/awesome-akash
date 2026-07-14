# Postgres S3 Backup

Automated PostgreSQL backups for apps running on Akash Network, shipped
straight to any S3-compatible storage provider (Backblaze B2, Cloudflare
R2, AWS S3, MinIO, Storj, etc).

It's a small Alpine container that:

1. Waits for your Postgres to be reachable
2. Runs `pg_dump`, compresses the result
3. Uploads it to your bucket via `rclone`
4. Cleans up old local and remote backups on a retention schedule
5. Repeats automatically on a cron schedule (every 6 hours by default)

No code to write, no host to manage, it's just another service in your
Akash SDL.

## Why

Akash deployments are ephemeral by nature: providers can change, leases
end, deployments get redeployed with a new (random) URL. Persistent
storage on Akash protects you from *container* restarts, but not from
accidental `deployment close`, provider issues, or fat-fingering an SDL
update. Postgres S3 Backup gives you an off-chain, off-provider copy of your
data on a schedule, with zero manual steps after the first deploy.

## How it works

Postgres S3 Backup is just `pg_dump` + `gzip` + `rclone`, wrapped in a container
with a cron job. All configuration is environment variables, there's
nothing to build or customize unless you want a different schedule.

It's designed to be deployed as **one more service inside an SDL you
already have**, alongside your app and its Postgres database. Akash's
internal DNS lets it reach Postgres at `postgres:5432` (or whatever you
name the service) without exposing the database publicly at all.

Postgres is never exposed to the internet for this to work, it backups
travel entirely over Akash's internal pod network and only the final
encrypted-in-transit upload to your S3-compatible bucket leaves the
deployment.

See `sdl/deploy.yaml` for a full example (database + backup service in one
file). To add it to an existing app's SDL instead, copy just the
`postgres-s3-backup` block from the `services`, `profiles.compute`,
`profiles.placement.dcloud.pricing`, and `deployment` sections into
your own SDL. The Quick Start below walks through it.

## Quick start

1. Build and push the image (or use a published one, if available):

   ```bash
   docker build -t YOUR_DOCKERHUB_USERNAME/postgres-s3-backup:latest .
   docker push YOUR_DOCKERHUB_USERNAME/postgres-s3-backup:latest
   ```

2. Open `sdl/deploy.yaml`. If you're starting fresh, deploy it as-is,
   it includes both Postgres and Postgres S3 Backup. If you already have an
   app + Postgres SDL, copy the `postgres-s3-backup` block from each of these
   sections into your existing file instead:
   - `services.postgres-s3-backup`
   - `profiles.compute.postgres-s3-backup`
   - `profiles.placement.dcloud.pricing.postgres-s3-backup`
   - `deployment.postgres-s3-backup`

   Then add `postgres-s3-backup` to your Postgres service's `expose.to` list
   so it's reachable internally:

   ```yaml
   postgres:
     expose:
       - port: 5432
         to:
           - service: web        # your existing service(s)
           - service: postgres-s3-backup  # add this line
   ```

3. Fill in the env vars on the `postgres-s3-backup` service, at minimum:

   | Variable | Description |
   |---|---|
   | `POSTGRES_HOST` | Postgres service name (e.g. `postgres`) |
   | `POSTGRES_DB` | Database name to back up |
   | `POSTGRES_USER` | Postgres user |
   | `POSTGRES_PASSWORD` | Postgres password |
   | `S3_ENDPOINT` | Your storage provider's S3-compatible endpoint |
   | `S3_BUCKET` | Bucket name |
   | `S3_ACCESS_KEY` | Access key ID |
   | `S3_SECRET_KEY` | Secret access key |

4. Deploy. Postgres S3 Backup runs a backup immediately, then every 6 hours.

## Optional configuration

| Variable | Default | Description |
|---|---|---|
| `POSTGRES_PORT` | `5432` | Postgres port |
| `BACKUP_PREFIX` | `backups` | Folder inside the bucket |
| `BACKUP_NAME` | value of `POSTGRES_DB` | Filename prefix for dumps |
| `LOCAL_RETENTION_COUNT` | `3` | Local `.sql.gz` files kept inside the container |
| `REMOTE_RETENTION_DAYS` | `30` | Age (days) after which remote backups are deleted |

## Changing the backup schedule

The cron schedule is baked into the image at build time via the
`CRON_SCHEDULE` build arg (standard 5-field cron syntax):

```bash
docker build --build-arg CRON_SCHEDULE="0 */1 * * *" \
  -t YOUR_DOCKERHUB_USERNAME/postgres-s3-backup:hourly .
```

Examples:
- `0 */6 * * *` — every 6 hours (default)
- `0 */1 * * *` — every hour
- `0 0 * * *` — once a day at midnight
- `0 0 * * 0` — once a week on Sunday

## Restoring a backup

Postgres S3 Backup only handles the backup side. To restore:

```bash
# Download the backup from your bucket via rclone, the provider's
# web console, or any S3-compatible client, then:
gunzip mydatabase_20260613_075408.sql.gz
psql -h YOUR_HOST -U YOUR_USER -d YOUR_DB -f mydatabase_20260613_075408.sql
```

## Security notes

- Credentials are passed via environment variables in the SDL, never
  baked into the image, the Docker image itself contains no secrets
  and is safe to make public.
- Postgres never needs to be exposed publicly, Postgres S3 Backup only talks
  to it over Akash's internal pod network, in the same deployment.
- The only traffic that leaves the deployment is the final backup
  upload to your S3-compatible bucket.
- Backups are stored with `acl = private` on the destination bucket by
  default.
