#!/bin/bash

# Check if onezerominer is already downloaded
if [ ! -f "/root/onezerominer" ]; then

    ASSET_URL=$(curl -s https://api.github.com/repos/OneZeroMiner/onezerominer/releases/latest | jq -r ".assets[] | select(.browser_download_url | endswith(\".tar.gz\")) | .browser_download_url" | tail -n1)

    wget $ASSET_URL -O /root/onezerominer.tar.gz

    tar --strip-components=1 -xzf /root/onezerominer.tar.gz -C /root

    # Delete the downloaded archive
    rm /root/onezerominer.tar.gz
    chmod +x /root/onezerominer
fi

unset DISPLAY

ALGO=$(sed -e 's/^"//' -e 's/"$//' <<<"$ALGO") #Remove quotes
PASSWORD=$(sed -e 's/^"//' -e 's/"$//' <<<"$PASSWORD") 
POOL=$(sed -e 's/^"//' -e 's/"$//' <<<"$POOL") 
WALLET_ADDRESS=$(sed -e 's/^"//' -e 's/"$//' <<<"$WALLET_ADDRESS") 
OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$OPTIONS") 

bash -c "./onezerominer --algo $ALGO --pool $POOL --wallet $WALLET_ADDRESS --pass $PASSWORD $OPTIONS"
