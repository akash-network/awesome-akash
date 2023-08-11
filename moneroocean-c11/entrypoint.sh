#!/bin/bash

# Check if xmrig is already downloaded
if [ ! -f "/root/xmrig" ]; then

    # Fetch the asset URL
    ASSET_URL=$(curl -s https://api.github.com/repos/MoneroOcean/xmrig/releases/latest | jq -r ".assets[] | select((.browser_download_url | contains(\"lin\")) and (.browser_download_url | endswith(\".tar.gz\")) and (.browser_download_url | contains(\"compat\") | not)) | .browser_download_url")

    # Download the archive
    wget $ASSET_URL -O /root/xmrig.tar.gz

    # Extract to the /root directory
    tar -xzf /root/xmrig.tar.gz -C /root

    # List the contents of the current directory (for debugging purposes)
    ls -la /root

    # Delete the downloaded archive
    rm /root/xmrig.tar.gz

    # Provide execute permissions to xmrig
    chmod +x /root/xmrig

fi
# Run xmrig with your desired parameters
/root/xmrig --algo $ALGO --server $POOL --user $WALLET_ADDRESS --pass $PASSWORD $OPTIONS
