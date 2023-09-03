#!/bin/bash

# Check if onezerominer is already downloaded
if [ ! -f "/root/onezerominer" ]; then

    ASSET_URL=$(curl -s https://api.github.com/repos/OneZeroMiner/onezerominer/releases/latest | jq -r ".assets[] | select(.browser_download_url | endswith(\".tar.gz\")) | .browser_download_url" | tail -n1)
#    LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/trexminer/T-Rex/releases/latest | jq -r ".assets[] | select(.name | test(\"linux.tar.gz\")) | .browser_download_url")

    wget $ASSET_URL -O /root/onezerominer.tar.gz

    tar --strip-components=1 -xzf /root/onezerominer.tar.gz -C /root

    # Extract to the current directory without the top-level folder
    #tar --strip-components=1 -xf /root/onezerominer.tar.xz -C .

    # Delete the downloaded archive
    rm /root/onezerominer.tar.gz
    chmod +x /root/onezerominer
fi
# Run onezerominer with your desired parameters
#xhost +Local:*
#xhost
#xhost local:root
unset DISPLAY
bash -c "./onezerominer --algo $ALGO --pool $POOL --wallet $WALLET_ADDRESS --pass $PASSWORD $OPTIONS"
