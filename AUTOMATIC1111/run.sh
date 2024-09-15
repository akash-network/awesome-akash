#!/bin/bash
if [[ -n "$LINK_MODEL" ]];then
bash model "$LINK_MODEL"
fi
/stable-diffusion-webui/webui.sh
