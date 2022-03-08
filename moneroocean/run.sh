#!/usr/bin/env bash
#memory=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
#echo "Memory found: $memory"
set -euo pipefail
apt-get update && \
        apt install curl bc iputils-ping msr-tools kmod git build-essential libbz2-dev cmake libuv1-dev libssl-dev libhwloc-dev wget gcc g++ wget -y && \
        apt clean && \
        rm -rf /var/lib/apt/lists/*

#if (( $memory > 8196000 )); then
if [[ $PAGES == "true" ]]; then

curl -s -L https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/setup_moneroocean_miner.sh | bash -s "${WALLET}"
killall -9 xmrig

sed -i 's/"randomx-mode": *[^,]*,/"randomx-mode": fast,/' /root/moneroocean/config.json
sed -i 's/"1gb-pages": *[^,]*,/"1gb-pages": false,/' /root/moneroocean/config.json
sed -i 's/"huge-pages": *[^,]*,/"huge-pages": true,/' /root/moneroocean/config.json
sed -i 's/"huge-pages-jit": *[^,]*,/"huge-pages": true,/' /root/moneroocean/config.json

echo "Got memory greater than 8gb, enabling Huge Pages and Randomx-Mode = fast"

else

curl -s -L https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/setup_moneroocean_miner.sh | bash -s "${WALLET}"
killall -9 xmrig

sed -i 's/"randomx-mode": *[^,]*,/"randomx-mode": light,/' /root/moneroocean/config.json
sed -i 's/"1gb-pages": *[^,]*,/"1gb-pages": false,/' /root/moneroocean/config.json
sed -i 's/"huge-pages": *[^,]*,/"huge-pages": false,/' /root/moneroocean/config.json
sed -i 's/"huge-pages-jit": *[^,]*,/"huge-pages": false,/' /root/moneroocean/config.json

echo "Got memory less than 8gb, disabling Huge Pages and Randomx-Mode = light"
echo "Mining will be slower than normal, increase memory size."

fi

sed -i 's/"cn\/0": *[^,]*,/"cn\/0": true,/' /root/moneroocean/config.json
sed -i 's/"cn-lite\/0": false/"cn-lite\/0": true/' /root/moneroocean/config.json
sed -i 's/"hw-aes": *[^,]*,/"hw-aes": null,/' /root/moneroocean/config.json
sed -i 's/"donate-level": *[^,]*,/"donate-level": 0,/' /root/moneroocean/config.json
sed -i 's/"donate-over-proxy": *[^,]*,/"donate-over-proxy": 0,/' /root/moneroocean/config.json
sed -i 's/"pass": *[^,]*,/"pass": "'"${WORKER}-${AKASH_CLUSTER_PUBLIC_HOSTNAME}"'",/' /root/moneroocean/config.json
sed -i 's/"user": *[^,]*,/"user": "'"$WALLET"'",/' /root/moneroocean/config.json

cat /root/moneroocean/config.json

exec /bin/bash /root/moneroocean/miner.sh --config=/root/moneroocean/config.json
