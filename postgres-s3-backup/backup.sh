#!/bin/bash
set -e

# ============================================================
# Postgres S3 Backup - Generic PostgreSQL backup to S3-compatible storage
# ============================================================

# Postgres connection (override via env vars)
POSTGRES_HOST=${POSTGRES_HOST:-postgres}
POSTGRES_PORT_RAW=${POSTGRES_PORT:-5432}
# Strip any tcp://host:port prefix some orchestrators inject into env vars
POSTGRES_PORT=$(echo "$POSTGRES_PORT_RAW" | sed 's|tcp://[^:]*:||')
POSTGRES_DB=${POSTGRES_DB:?POSTGRES_DB is required}
POSTGRES_USER=${POSTGRES_USER:-postgres}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:?POSTGRES_PASSWORD is required}

# S3-compatible storage (Backblaze B2, Cloudflare R2, AWS S3, MinIO, etc.)
S3_ENDPOINT=${S3_ENDPOINT:?S3_ENDPOINT is required}
S3_BUCKET=${S3_BUCKET:?S3_BUCKET is required}
S3_ACCESS_KEY=${S3_ACCESS_KEY:?S3_ACCESS_KEY is required}
S3_SECRET_KEY=${S3_SECRET_KEY:?S3_SECRET_KEY is required}

# Backup behavior (all optional, sensible defaults)
BACKUP_PREFIX=${BACKUP_PREFIX:-backups}         # folder inside the bucket
BACKUP_NAME=${BACKUP_NAME:-$POSTGRES_DB}        # filename prefix
LOCAL_RETENTION_COUNT=${LOCAL_RETENTION_COUNT:-3}   # how many local backups to keep
REMOTE_RETENTION_DAYS=${REMOTE_RETENTION_DAYS:-30}  # how many days of remote backups to keep

BACKUP_DIR="/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/${BACKUP_NAME}_${TIMESTAMP}.sql"

mkdir -p "$BACKUP_DIR"

echo "[$(date)] Starting backup of '${POSTGRES_DB}'..."

echo "Waiting for PostgreSQL to be ready..."
until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q' 2>/dev/null; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 2
done
echo "PostgreSQL is ready!"

echo "Creating database dump..."
PGPASSWORD=$POSTGRES_PASSWORD pg_dump \
  -h "$POSTGRES_HOST" \
  -p "$POSTGRES_PORT" \
  -U "$POSTGRES_USER" \
  -d "$POSTGRES_DB" \
  --no-owner \
  --no-acl \
  -f "$BACKUP_FILE"

echo "Compressing backup..."
gzip "$BACKUP_FILE"
BACKUP_FILE="${BACKUP_FILE}.gz"

BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
echo "Backup created: $BACKUP_FILE ($BACKUP_SIZE)"

echo "Configuring rclone..."
mkdir -p ~/.config/rclone
cat > ~/.config/rclone/rclone.conf <<EOF
[storage]
type = s3
provider = Other
access_key_id = ${S3_ACCESS_KEY}
secret_access_key = ${S3_SECRET_KEY}
endpoint = ${S3_ENDPOINT}
acl = private
EOF

echo "Uploading to storage..."
rclone copy "$BACKUP_FILE" "storage:${S3_BUCKET}/${BACKUP_PREFIX}/" --progress

if [ $? -eq 0 ]; then
    echo "[$(date)] Backup uploaded successfully: $(basename "$BACKUP_FILE")"
else
    echo "[$(date)] ERROR: Failed to upload backup"
    exit 1
fi

echo "Cleaning up old local backups (keeping last ${LOCAL_RETENTION_COUNT})..."
cd "$BACKUP_DIR"
ls -t "${BACKUP_NAME}"_*.sql.gz 2>/dev/null | tail -n +$((LOCAL_RETENTION_COUNT + 1)) | xargs -r rm -f

echo "Cleaning up remote backups older than ${REMOTE_RETENTION_DAYS} days..."
rclone delete "storage:${S3_BUCKET}/${BACKUP_PREFIX}/" --min-age "${REMOTE_RETENTION_DAYS}d"

echo "[$(date)] Backup completed successfully!"
