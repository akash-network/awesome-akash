#!/bin/bash
set -e

# Configure AWS CLI for Akave
aws configure set aws_access_key_id "$AKAVE_ACCESS" --profile akave
aws configure set aws_secret_access_key "$AKAVE_SECRET" --profile akave
aws configure set region akave-network --profile akave

# Start HTTP server
python3 -m http.server 8080 --directory /www &
echo "HTTP server started on port 8080"

############################################################
# One-time upload
############################################################
echo "Performing one-time upload"
ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
file="/data/test-$ts.txt"
echo "hello from akash at $ts" > "$file"

aws s3 cp "$file" \
  "s3://$AKAVE_BUCKET/akash-test/test-$ts.txt" \
  --endpoint-url "$AKAVE_ENDPOINT" \
  --profile akave

echo "Uploaded test-$ts.txt to Akave"

############################################################
# Foreground refresh + HTML render loop (every REFRESH_INTERVAL)
############################################################
echo "HTTP index refresh loop starting (every ${REFRESH_INTERVAL}s)"
while true; do
  ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  echo "Refreshing index.html at $ts"

  # List objects to TSV: KEY \t SIZE \t LASTMOD
  if aws s3api list-objects-v2 \
       --bucket "$AKAVE_BUCKET" \
       --prefix "akash-test/" \
       --endpoint-url "$AKAVE_ENDPOINT" \
       --profile akave \
       --output json \
       | jq -r '.Contents[]? | [.Key, (.Size|tostring), .LastModified] | @tsv' \
       > /tmp/list.tsv 2>/tmp/list.err; then
    :
  else
    echo "Error listing objects:"
    cat /tmp/list.err
    : > /tmp/list.tsv
  fi

  {
    echo "<html><head><title>Akave Akash Test</title></head><body>"
    echo "<h1>Akave + Akash Live Test</h1>"
    echo "<p><b>Bucket:</b> $AKAVE_BUCKET</p>"
    echo "<p><b>Prefix:</b> akash-test/</p>"
    echo "<p><b>Upload interval:</b> ${UPLOAD_INTERVAL}s</p>"
    echo "<p><b>Refresh interval:</b> ${REFRESH_INTERVAL}s</p>"
    echo "<h2>Objects (click to download via pre-signed URL, 1h TTL)</h2>"
    echo "<table border='1' cellpadding='4' cellspacing='0'>"
    echo "<tr><th>Key</th><th>Size (bytes)</th><th>Last Modified</th></tr>"

    if [ -s /tmp/list.tsv ]; then
      while IFS=$'\t' read -r key size mtime; do
        # Generate pre-signed URL (1 year)
        url=$(aws s3 presign "s3://$AKAVE_BUCKET/$key" \
                 --endpoint-url "$AKAVE_ENDPOINT" \
                 --profile akave \
                 --expires-in 31536000 2>/dev/null || echo "")

        printf "<tr><td><a href=\"%s\">%s</a></td><td>%s</td><td>%s</td></tr>\n" \
               "$url" "$key" "$size" "$mtime"
      done < /tmp/list.tsv
    else
      echo "<tr><td colspan='3'>(no objects found)</td></tr>"
    fi

    echo "</table>"
    echo "<p>Last refreshed: $ts (UTC)</p>"
    echo "</body></html>"
  } > /www/index.html

  sleep "$REFRESH_INTERVAL"
done
