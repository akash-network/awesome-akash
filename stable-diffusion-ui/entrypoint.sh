#!/bin/bash
# Entrypoint for the Easy Diffusion image.
#
# Environment variables:
#   MODELS      Models to download before start, as "folder|url" entries separated by spaces,
#               commas or newlines. Folders: stable-diffusion, vae, lora, embeddings, controlnet,
#               text-encoder, realesrgan, gfpgan, codeformer. Already-downloaded files are skipped.
#   HF_TOKEN    Optional Hugging Face token, for gated repos.
#   ED_BACKEND  ed_diffusers (default, v3.0 engine), webui (v3.5 / Forge, installs on first start),
#               sdkit3 (v4, experimental).
#   PORT        Port for the web UI (default 9000).
set -euo pipefail

ED_DIR="${ED_DIR:-/opt/easy-diffusion}"
DATA_DIR=/data
MODELS_DIR="$DATA_DIR/models"

# Stage 1 (root): make /data writable for the "ed" user, then re-run this script as "ed".
if [ "$(id -u)" = "0" ]; then
  mkdir -p "$MODELS_DIR"
  chown ed:ed "$DATA_DIR" "$MODELS_DIR"
  exec setpriv --reuid=ed --regid=ed --init-groups env HOME=/home/ed "$0" "$@"
fi

# Stage 2 (user "ed")
cd "$ED_DIR"

# Easy Diffusion settings. Written on every start so the environment variables always apply.
cat > config.yaml << EOF
models_dir: $MODELS_DIR
net:
  listen_port: ${PORT:-9000}
  listen_to_network: true
render_devices: auto
ui:
  open_browser_on_start: false
update_branch: main
backend: ${ED_BACKEND:-ed_diffusers}
EOF

download() {
  local dir="$MODELS_DIR/$1" url="$2" name
  name="${url##*/}"; name="${name%%\?*}"
  if [ -f "$dir/$name" ]; then
    echo "[models] $1/$name already present"
    return 0
  fi
  mkdir -p "$dir" "$MODELS_DIR/.incoming"
  local auth=()
  if [ -n "${HF_TOKEN:-}" ] && [[ "$url" == *huggingface.co* ]]; then
    auth=(--header="Authorization: Bearer $HF_TOKEN")
  fi
  echo "[models] downloading $1/$name"
  if aria2c -q -c -x16 -s16 -k1M --file-allocation=none "${auth[@]}" \
       -d "$MODELS_DIR/.incoming" -o "$name" "$url"; then
    mv "$MODELS_DIR/.incoming/$name" "$dir/$name"
    echo "[models] finished $1/$name"
  else
    echo "[models] FAILED $1/$name ($url)"
  fi
}

# Download models one at a time, before the server starts.
models="${MODELS:-}"
for entry in ${models//,/ }; do
  case "$entry" in
    *"|"*) download "${entry%%|*}" "${entry#*|}" ;;
    *) echo "[models] skipping \"$entry\": expected folder|url" ;;
  esac
done
rm -rf "$MODELS_DIR/.incoming"

# Start Easy Diffusion the same way its own launcher does (on_sd_start.sh), but without the
# self-update step, so the deployment runs exactly the version that was built into the image.
export PATH="$ED_DIR/installer_files/env/bin:$PATH"
export INSTALL_ENV_DIR="$ED_DIR/installer_files/env"
export PYTHONNOUSERSITE=y
PYTHONVERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')"
export PYTHONPATH="$INSTALL_ENV_DIR/lib/python$PYTHONVERSION/site-packages"

echo "[setup] starting Easy Diffusion (engine: ${ED_BACKEND:-ed_diffusers})"
exec python scripts/check_modules.py --launch-uvicorn
