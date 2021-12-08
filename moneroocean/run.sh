#!/usr/bin/env bash
set -euo pipefail
apt-get update && \
        apt install curl bc iputils-ping msr-tools kmod git build-essential libbz2-dev cmake libuv1-dev libssl-dev libhwloc-dev wget gcc g++ -y && \
        apt clean && \
        rm -rf /var/lib/apt/lists/*

curl -s -L https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/setup_moneroocean_miner.sh | bash -s "${WALLET}"
tail -f /root/moneroocean/xmrig.log
