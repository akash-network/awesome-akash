#!/bin/bash

# Check if gminer is already downloaded
if [ ! -f "/root/gminer" ]; then
    # Fetch the latest tag name
    ASSET_URL=$(curl -s https://api.github.com/repos/develsoftware/GMinerRelease/releases/latest | jq -r ".assets[] | select(.content_type == \"application/x-xz\") | .browser_download_url")
    # Download and extract
    wget $ASSET_URL -O /root/gminer.tar.xz
    tar -xf /root/gminer.tar.xz -C /root
fi
# Run gminer with your desired parameters

ALGO=$(sed -e 's/^"//' -e 's/"$//' <<<"$ALGO") #Remove quotes
PASSWORD=$(sed -e 's/^"//' -e 's/"$//' <<<"$PASSWORD") 
POOL=$(sed -e 's/^"//' -e 's/"$//' <<<"$POOL") 
WALLET_ADDRESS=$(sed -e 's/^"//' -e 's/"$//' <<<"$WALLET_ADDRESS") 
OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$OPTIONS") 

/root/miner --algo $ALGO --server $POOL --user $WALLET_ADDRESS --pass $PASSWORD $OPTIONS