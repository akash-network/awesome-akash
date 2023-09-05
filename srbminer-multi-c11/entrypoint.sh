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

# List of variables to strip quotes from
#vars=("ALGO" "POOL" "WALLET_ADDRESS" "PASSWORD" "OPTIONS")
# Loop to strip quotes and export
#for var in "${vars[@]}"; do export "$var"=$(sed -e 's/^"//' -e 's/"$//' <<< "$(eval echo \$$var)"); done

ALGO=$(sed -e 's/^"//' -e 's/"$//' <<<"$ALGO") #Remove quotes
PASSWORD=$(sed -e 's/^"//' -e 's/"$//' <<<"$PASSWORD") #Remove quotes
POOL=$(sed -e 's/^"//' -e 's/"$//' <<<"$POOL") #Remove quotes
WALLET_ADDRESS=$(sed -e 's/^"//' -e 's/"$//' <<<"$WALLET_ADDRESS") #Remove quotes
OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$OPTIONS") #Remove quotes

/root/SRBMiner-MULTI --algorithm $ALGO --pool $POOL --wallet $WALLET_ADDRESS --password $PASSWORD $OPTIONS
