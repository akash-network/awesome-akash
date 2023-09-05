#!/bin/bash

# Check if bzminer is already downloaded
if [ ! -f "/root/bzminer" ]; then
    # Fetch the latest release URL
    LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/bzminer/bzminer/releases/latest | jq -r ".assets[] | select(.name | test(\"linux.tar.gz\")) | .browser_download_url")

    # Download the tarball
    wget $LATEST_RELEASE_URL -O /root/bzminer-linux.tar.gz

    # Extract the tarball
    #tar -xzf /root/bzminer-linux.tar.gz -C /root
    tar --strip-components=1 -xzf /root/bzminer-linux.tar.gz -C /root
fi

# Your previous entrypoint logic
cd "$(dirname "$0")"

ALGO=$(sed -e 's/^"//' -e 's/"$//' <<<"$ALGO") #Remove quotes
PASSWORD=$(sed -e 's/^"//' -e 's/"$//' <<<"$PASSWORD") 
POOL=$(sed -e 's/^"//' -e 's/"$//' <<<"$POOL") 
WALLET_ADDRESS=$(sed -e 's/^"//' -e 's/"$//' <<<"$WALLET_ADDRESS") 
OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$OPTIONS") 

/root/bzminer -a $ALGO -p $POOL -w $WALLET_ADDRESS --pool_password $PASSWORD $OPTIONS