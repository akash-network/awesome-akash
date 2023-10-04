#!/usr/bin/env bash

echo "$MODELURLS"
echo "$VAEURLS"
echo "$UPSCALEURLS"
echo "$COMMANDLINE_ARGS"

# split string into array
IFS=',' read -r -a URLS <<< "$MODELURLS"

# loop through array
for modelurl in "${URLS[@]}"
do
    # wget the file
    wget -nv $modelurl -P /comfyui/models/checkpoints
done

# split string into array
IFS=',' read -r -a VAEURLS <<< "$VAEURLS"

# loop through array
for url in "${VAEURLS[@]}"
do
    # wget the file
    wget -nv $url -P /comfyui/models/vae
done

# split string into array
IFS=',' read -r -a UPSCALEURLS <<< "$UPSCALEURLS"

# loop through array
for url in "${UPSCALEURLS[@]}"
do
    # wget the file
    wget -nv $url -P /comfyui/models/upscale_model
done

python /comfyui/main.py $COMMANDLINE_ARGS

