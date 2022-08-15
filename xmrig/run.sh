#!/usr/bin/env bash
set -euo pipefail

if [ -z $WALLET ]; then
    echo "Please examine the SDL and be sure to set your Monero Wallet Address in the WALLET= variable."
    sleep 300
    exit
fi

if [ -z $CPU_UNITS ]; then
    echo "Please examine the SDL and be sure to set the CPU_UNITS= variable equal to the cpu.units requested."
    sleep 300
    exit
fi

if [ -z $RANDOMX_MODE ]; then
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

MIN_MEMORY_LIGHT_MODE=0.1 #No less to run MoneroOcean
MIN_MEMORY_FAST_MODE=4.75  #No less to run FAST mode single NUMA node

if [[ $RANDOMX_MODE == fast ]]; then
    if (($(echo "$MEMORY_SIZE < $MIN_MEMORY_FAST_MODE" | bc -l))); then
        echo "Not enough memory to use MoneroOcean with MODE=fast.  Please increase to greater than 3Gi or switch to MODE=light with at least 0.1Gi."
        echo "You must close this deployment to change the memory requested."
        sleep 300
        exit
    fi
elif [[ $RANDOMX_MODE == light ]]; then
    if (($(echo "$MEMORY_SIZE < $MIN_MEMORY_LIGHT_MODE" | bc -l))); then
        echo "Not enough memory to use MoneroOcean with MODE=light.  Please increase to greater than 0.1Gi or switch to MODE=fast with at least 3Gi."
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

    if [[ $RANDOMX_MODE == fast ]]; then
        NUMA_MIN_MEMORY=4.75
        #4416Mi

        if (($(echo "$MEMORY_SIZE >= $NUMA_MIN_MEMORY" | bc -l))); then
            echo "Found enough memory!"
        else
            echo "This provider has $(lscpu | grep "NUMA" | head -n1 | awk '{print $3}') NUMA nodes"
            echo "Increase the requested memory for this deployment to >= 4.75Gi"
            echo "You must close this deployment to change the memory requested."
            sleep 300
            exit
        fi

    fi

    if [[ $RANDOMX_MODE == light ]]; then
        NUMA_MIN_MEMORY=0.1
        if (($(echo "$MEMORY_SIZE >= $NUMA_MIN_MEMORY" | bc -l))); then
            echo "Found enough memory!"
        else
            echo "This provider has $(lscpu | grep "NUMA" | head -n1 | awk '{print $3}') NUMA nodes"
            echo "Increase the requested memory for this deployment to >= 0.1Gi"
            echo "You must close this deployment to change the memory requested."
            sleep 300
            exit
        fi

    fi

else

    echo "Could not detect NUMA Nodes"
fi

WORKER=$(echo ${WORKER}-${AKASH_CLUSTER_PUBLIC_HOSTNAME})

cd /xmrig ; echo "Using POOL: ${POOL} WALLET: ${WALLET}  WORKER: ${WORKER} TLS: ${TLS} TLS_FINGERPRINT: ${TLS_FINGERPRINT}"
CUSTOM_OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$CUSTOM_OPTIONS") #Remove quotes

if [[ ${TLS_FINGERPRINT} != "" && ${TLS} == "true" ]]; then
  ./xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --tls-fingerprint ${TLS_FINGERPRINT} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --randomx-mode=$RANDOMX_MODE -t $CPU_UNITS $CUSTOM_OPTIONS
elif [[ ${TLS_FINGERPRINT} == "" && ${TLS} == "true" ]]; then
  ./xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --randomx-mode=$RANDOMX_MODE -t $CPU_UNITS $CUSTOM_OPTIONS
else
  ./xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --randomx-mode=$RANDOMX_MODE -t $CPU_UNITS $CUSTOM_OPTIONS
fi
