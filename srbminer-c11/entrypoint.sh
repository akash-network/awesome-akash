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
# Run srbminer with your desired parameters
/root/SRBMiner-MULTI --algorithm $ALGO --pool $POOL --wallet $WALLET_ADDRESS --password $PASSWORD $OPTIONS
