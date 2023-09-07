#!/usr/bin/env bash
#memory=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
#echo "Memory found: $memory"
set -euo pipefail

if [ -z $WALLET ]; then
    echo "Please examine the SDL and be sure to set your Monero Wallet Address in the WALLET= variable."
    sleep 300
    exit
fi

curl -s -L https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/setup_moneroocean_miner.sh | bash -s "${WALLET}"
killall -9 xmrig #start and kill to generate configs

# Set CUDA to enabled
sed -i '/"cuda": {/a \ \ \ \ \ \ \ \ "cn/gpu": false,' /root/moneroocean/config.json
sed -i '/"cuda": {/a \ \ \ \ \ \ \ \ "rx/0": false,' /root/moneroocean/config.json
sed -i '/"cuda": {/a \ \ \ \ \ \ \ \ "rx/graft": false,' /root/moneroocean/config.json
sed -i '/"cuda": {/a \ \ \ \ \ \ \ \ "rx/arq": false,' /root/moneroocean/config.json

#Disable API
sed -i '/"http": {/,/}/ s/"enabled": true,/"enabled": false,/' /root/moneroocean/config.json

# Disable OpenCL and CPU
sed -i '/"cpu": {/,/}/ s/"enabled": true,/"enabled": false,/' /root/moneroocean/config.json
sed -i '/"opencl": {/,/}/ s/"enabled": true,/"enabled": false,/' /root/moneroocean/config.json

sed -i 's/"log-file": *[^,]*,/"syslog": true,/' /root/moneroocean/config.json
sed -i 's/"colors": *[^,]*,/"colors": false,/' /root/moneroocean/config.json
sed -i 's/"verbose": *[^,]*,/"verbose": 1,/' /root/moneroocean/config.json
sed -i 's/"bench-algo-time": *[^,]*,/"bench-algo-time": "'"$BENCH_TIME"'",/' /root/moneroocean/config.json
sed -i 's/"donate-level": *[^,]*,/"donate-level": 0,/' /root/moneroocean/config.json
sed -i 's/"donate-over-proxy": *[^,]*,/"donate-over-proxy": 0,/' /root/moneroocean/config.json
sed -i 's/"pass": *[^,]*,/"pass": "'"${WORKER}-${AKASH_CLUSTER_PUBLIC_HOSTNAME}"'",/' /root/moneroocean/config.json
sed -i 's/"user": *[^,]*,/"user": "'"$WALLET"'",/' /root/moneroocean/config.json

echo $(jq '.randomx.init = 0' /root/moneroocean/config.json) > /root/moneroocean/config.json
echo $(jq '.randomx."init-avx2" = 0' /root/moneroocean/config.json) > /root/moneroocean/config.json
echo $(jq '.cuda.enabled = true' /root/moneroocean/config.json) > /root/moneroocean/config.json
echo $(jq '.cuda.astrobwt = true' /root/moneroocean/config.json) > /root/moneroocean/config.json
echo $(jq '.cuda.panthera = true' /root/moneroocean/config.json) > /root/moneroocean/config.json
echo $(jq '.pools[].url = "gulf.moneroocean.stream:10032"' /root/moneroocean/config.json) > /root/moneroocean/config.json

cat /root/moneroocean/config.json

cp /xmrig-cuda/build/libxmrig-cuda.so /root/moneroocean/

/root/moneroocean/miner.sh --config=/root/moneroocean/config.json
