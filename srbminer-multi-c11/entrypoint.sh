#!/bin/bash

# Check if srbminer is already downloaded
if [ ! -f "/root/srbminer" ]; then

    ASSET_URL=$(curl -s https://api.github.com/repos/doktor83/SRBMiner-Multi/releases/latest | jq -r ".assets[] | select(.browser_download_url | endswith(\".tar.xz\")) | .browser_download_url")

    wget $ASSET_URL -O /root/srbminer.tar.xz

    # Extract to the current directory without the top-level folder
    tar --strip-components=1 -xf /root/srbminer.tar.xz -C .

    # Delete the downloaded archive
    rm /root/srbminer.tar.xz
    chmod +x /root/SRBMiner-MULTI
fi

echo "Startup takes up to ~60 seconds"

ALGO=$(sed -e 's/^"//' -e 's/"$//' <<<"$ALGO") #Remove quotes
PASSWORD=$(sed -e 's/^"//' -e 's/"$//' <<<"$PASSWORD") 
POOL=$(sed -e 's/^"//' -e 's/"$//' <<<"$POOL") 
WALLET_ADDRESS=$(sed -e 's/^"//' -e 's/"$//' <<<"$WALLET_ADDRESS") 
OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$OPTIONS") 

/root/SRBMiner-MULTI --algorithm $ALGO --pool $POOL --wallet $WALLET_ADDRESS --password $PASSWORD $OPTIONS
