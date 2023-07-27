#!/usr/bin/env bash
wget -P /stable-diffusion-webui/models/Stable-diffusion https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.ckpt
/stable-diffusion-webui/webui.sh --update-check --xformers --listen --port 8080 --medvram
