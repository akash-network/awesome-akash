#!/usr/bin/env bash
#memory=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
#echo "Memory found: $memory"
set -euo pipefail

if [ -z $WALLET ]; then
    echo "Please examine the SDL and be sure to set your Monero Wallet Address in the WALLET= variable."
    sleep 300
    exit
fi

if [ -z $MODE ]; then
    echo "Please examine the SDL and be sure to set the mode to fast or light in the MODE= variable."
    sleep 300
    exit
fi

if [ -z $MEMORY_SIZE ]; then
    echo "Please set MEMORY_SIZE equal to the memory requested.  This is required to determine if we can use randomx-mode fast or light."
    echo "You must close this deployment to change the memory requested."
    sleep 300
    exit
fi

if [[ $MEMORY_SIZE == *"Gi"* ]]; then
    MEMORY_SIZE=$(echo $MEMORY_SIZE | sed 's/[^0-9.]//g') #Remove Gi from variable
    echo "Found $MEMORY_SIZE Gi"
elif [[ $MEMORY_SIZE == *"Mi"* ]]; then
    MEMORY_SIZE=$(echo $MEMORY_SIZE | sed 's/[^0-9.]//g')    #Remove Mi from variable
    MEMORY_SIZE=$(echo "scale=2; $MEMORY_SIZE/1000" | bc -l) #Convert to GB
    echo "Found $MEMORY_SIZE Gi"
else
    echo "ERROR - MEMORY_SIZE is incorrect.  Please examine the SDL and be sure to set with Gi or Mi"
    echo "You must close this deployment to change the memory requested."
    sleep 300
    exit
fi

MIN_MEMORY_LIGHT_MODE=1 #No less to run MoneroOcean
MIN_MEMORY_FAST_MODE=3  #No less to run FAST mode single NUMA node

if [[ $MODE == fast ]]; then
    if (($(echo "$MEMORY_SIZE < $MIN_MEMORY_FAST_MODE" | bc -l))); then
        echo "Not enough memory to use MoneroOcean with MODE=fast.  Please increase to greater than 3Gi or switch to MODE=light with at least 1Gi."
        echo "You must close this deployment to change the memory requested."
        sleep 300
        exit
    fi
elif [[ $MODE == light ]]; then
    if (($(echo "$MEMORY_SIZE < $MIN_MEMORY_LIGHT_MODE" | bc -l))); then
        echo "Not enough memory to use MoneroOcean with MODE=light.  Please increase to greater than 1Gi or switch to MODE=fast with at least 3Gi."
        echo "You must close this deployment to change the memory requested."
        sleep 300
        exit
    fi
else
    echo "ERROR - MIN_MEMORY is incorrect.  Please examine the SDL and be sure to set with Gi or Mi"
    echo "You must close this deployment to change the memory requested."
    sleep 300
    exit
fi

echo "Checking for NUMA nodes"
if [[ $(lscpu | grep "NUMA" | head -n1 | awk '{print $3}') > 1 ]]; then

    echo "Got more than 1 NUMA node on this provider!  Ensuring you have set enough memory..."

    if [[ $MODE == fast ]]; then
        NUMA_MIN_MEMORY=6

        if (($(echo "$MEMORY_SIZE >= $NUMA_MIN_MEMORY" | bc -l))); then
            echo "Found enough memory!"
        else
            echo "This provider has $(lscpu | grep "NUMA" | head -n1 | awk '{print $3}') NUMA nodes"
            echo "Increase the requested memory for this deployment to >= 6Gi"
            echo "You must close this deployment to change the memory requested."
            sleep 300
            exit
        fi

    fi

    if [[ $MODE == light ]]; then
        NUMA_MIN_MEMORY=3
        if (($(echo "$MEMORY_SIZE >= $NUMA_MIN_MEMORY" | bc -l))); then
            echo "Found enough memory!"
        else
            echo "This provider has $(lscpu | grep "NUMA" | head -n1 | awk '{print $3}') NUMA nodes"
            echo "Increase the requested memory for this deployment to >= 3Gi"
            echo "You must close this deployment to change the memory requested."
            sleep 300
            exit
        fi

    fi

else

    echo "Found 1 NUMA node with MODE=fast"
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
