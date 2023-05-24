#!/usr/bin/env bash
git clone https://github.com/Dimokus88/stable-diffusion-webui.git
if [ -n $MODEL_LINK ]
then
pip install diffusers transformers accelerate scipy safetensors
wget -P /stable-diffusion-webui/models/Stable-diffusion "$MODEL_LINK"
fi
/stable-diffusion-webui/webui.sh "$@"