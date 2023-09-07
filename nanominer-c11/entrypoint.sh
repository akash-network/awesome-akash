#!/bin/bash

# Check if nanominer is already downloaded
if [ ! -f "/root/nanominer" ]; then
    # Fetch the latest release URL
    LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/nanopool/nanominer/releases/latest | jq -r ".assets[] | select(.name | test(\"linux\")) | .browser_download_url")

    # Download the tarball
    wget $LATEST_RELEASE_URL -O /root/nanominer-linux.tar.gz

    # Extract the tarball
    tar --strip-components=0 -xzf /root/nanominer-linux.tar.gz -C /root
fi

# Your previous entrypoint logic
cd "$(dirname "$0")"

ALGO=$(sed -e 's/^"//' -e 's/"$//' <<<"$ALGO") #Remove quotes
PASSWORD=$(sed -e 's/^"//' -e 's/"$//' <<<"$PASSWORD") 
POOL=$(sed -e 's/^"//' -e 's/"$//' <<<"$POOL") 
WALLET_ADDRESS=$(sed -e 's/^"//' -e 's/"$//' <<<"$WALLET_ADDRESS") 
OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$OPTIONS")

/root/nanominer -a $ALGO -o $POOL -u $WALLET_ADDRESS -p $PASSWORD $OPTIONS
