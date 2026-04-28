#!/bin/bash
# Download Piper voice models
# Uncomment the voices you want to include

set -e

MODELS_DIR="/app/models"
mkdir -p "$MODELS_DIR"

echo "Downloading Piper voice models..."

# English (US) - Lessac (recommended, high quality)
wget -q -O "$MODELS_DIR/en_US-lessac-medium.onnx" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/lessac/medium/en_US-lessac-medium.onnx"
wget -q -O "$MODELS_DIR/en_US-lessac-medium.onnx.json" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/lessac/medium/en_US-lessac-medium.onnx.json"

# English (US) - Amy (alternative)
wget -q -O "$MODELS_DIR/en_US-amy-medium.onnx" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/amy/medium/en_US-amy-medium.onnx"
wget -q -O "$MODELS_DIR/en_US-amy-medium.onnx.json" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/amy/medium/en_US-amy-medium.onnx.json"

# English (GB) - Alan
wget -q -O "$MODELS_DIR/en_GB-alan-medium.onnx" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx"
wget -q -O "$MODELS_DIR/en_GB-alan-medium.onnx.json" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx.json"

# Spanish - DaveFX
wget -q -O "$MODELS_DIR/es_ES-davefx-medium.onnx" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/es/es_ES/davefx/medium/es_ES-davefx-medium.onnx"
wget -q -O "$MODELS_DIR/es_ES-davefx-medium.onnx.json" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/es/es_ES/davefx/medium/es_ES-davefx-medium.onnx.json"

# French - Siwis
wget -q -O "$MODELS_DIR/fr_FR-siwis-medium.onnx" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/fr/fr_FR/siwis/medium/fr_FR-siwis-medium.onnx"
wget -q -O "$MODELS_DIR/fr_FR-siwis-medium.onnx.json" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/fr/fr_FR/siwis/medium/fr_FR-siwis-medium.onnx.json"

# German - Thorsten
wget -q -O "$MODELS_DIR/de_DE-thorsten-medium.onnx" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/de/de_DE/thorsten/medium/de_DE-thorsten-medium.onnx"
wget -q -O "$MODELS_DIR/de_DE-thorsten-medium.onnx.json" \
    "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/de/de_DE/thorsten/medium/de_DE-thorsten-medium.onnx.json"

echo "Voice models downloaded successfully!"
echo "Downloaded models:"
ls -lh "$MODELS_DIR"/*.onnx
