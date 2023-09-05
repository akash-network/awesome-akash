#!/bin/bash

# Check if wildrig-multi is already downloaded
if [ ! -f "/root/wildrig-multi" ]; then

    ASSET_URL=$(curl -s https://api.github.com/repos/andru-kun/wildrig-multi/releases/latest | jq -r ".assets[] | select(.browser_download_url | endswith(\".tar.xz\")) | .browser_download_url")

    wget $ASSET_URL -O /root/wildrig-multi.tar.xz

    # Extract to the current directory without the top-level folder
    tar -xf /root/wildrig-multi.tar.xz -C .
    # Delete the downloaded archive
    rm /root/wildrig-multi.tar.xz
    chmod +x /root/wildrig-multi
fi

ALGO=$(sed -e 's/^"//' -e 's/"$//' <<<"$ALGO") #Remove quotes
PASSWORD=$(sed -e 's/^"//' -e 's/"$//' <<<"$PASSWORD") 
POOL=$(sed -e 's/^"//' -e 's/"$//' <<<"$POOL") 
WALLET_ADDRESS=$(sed -e 's/^"//' -e 's/"$//' <<<"$WALLET_ADDRESS") 
OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$OPTIONS") 

# Run wildrig-multi with your desired parameters
/root/wildrig-multi -a $ALGO -o $POOL -u $WALLET_ADDRESS -p $PASSWORD $OPTIONS
