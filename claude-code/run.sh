#!/usr/bin/env bash
set -euo pipefail

: "${WEB_PORT:=8080}"
: "${WEB_PASSWORD:?Set WEB_PASSWORD}"

mkdir -p "${XDG_CONFIG_HOME}/code-server"

cat > "${XDG_CONFIG_HOME}/code-server/config.yaml" <<EOF
bind-addr: 0.0.0.0:${WEB_PORT}
auth: password
password: ${WEB_PASSWORD}
cert: false
disable-telemetry: true
EOF

exec code-server /root/.claude/project
