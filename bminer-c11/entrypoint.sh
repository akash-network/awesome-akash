#!/bin/bash

# Check if bminer is already downloaded
if [ ! -f "/root/bminer" ]; then

    ASSET_URL="https://www.bminercontent.com/releases/bminer-v16.4.11-2849b5c-amd64.tar.xz"

    wget $ASSET_URL -O /root/bminer.tar.xz

    # Extract to the current directory without the top-level folder
    tar --strip-components=1 -xf /root/bminer.tar.xz -C .

    # Delete the downloaded archive
    rm /root/bminer.tar.xz
    chmod +x /root/bminer
fi

echo "Startup takes up to ~60 seconds"

ALGO=$(sed -e 's/^"//' -e 's/"$//' <<<"$ALGO") #Remove quotes
PASSWORD=$(sed -e 's/^"//' -e 's/"$//' <<<"$PASSWORD") 
POOL=$(sed -e 's/^"//' -e 's/"$//' <<<"$POOL") 
WALLET_ADDRESS=$(sed -e 's/^"//' -e 's/"$//' <<<"$WALLET_ADDRESS") 
OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$OPTIONS") 

/root/bminer $OPTIONS
#-uri _ADDRESS --password $PASSWORD $OPTIONS
