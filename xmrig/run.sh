#!/usr/bin/env bash
echo "Checking CPU in pod"
if [ -f /sys/fs/cgroup/cpu/cpu.cfs_quota_us ]; then
CPU_COUNT=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us)
else
CPU_COUNT=$(cat /sys/fs/cgroup/cpu.max | awk '{print $1}')
fi
CPU_COUNT=$(echo "scale=0; $CPU_COUNT/100000" | bc -l) #Convert to Cores
echo "Found $CPU_COUNT cpus available."

echo "Checking Memory in pod"
if [ -f /sys/fs/cgroup/memory/memory.limit_in_bytes ]; then
MEMORY_SIZE=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
else
MEMORY_SIZE=$(cat /sys/fs/cgroup/memory.max)
fi
MEMORY_SIZE=$(echo "scale=2; $MEMORY_SIZE/1024/1024/1024" | bc -l) #Convert to Gi

echo "Found $MEMORY_SIZE of memory available."

if [ -z $WALLET ]; then
    echo "Please examine the SDL and be sure to set your Monero Wallet Address in the WALLET= variable."
    sleep 300
    exit
fi

if [ -z $CPU_COUNT ]; then
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
            echo "------------------------------------------"
            echo "Deployment will continue in SLOW mode after 30 seconds, setting RANDOMX_MODE=light."
            sleep 30
            RANDOMX_MODE=light
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

    echo "Could not detect more than 1 NUMA node, assuming single NUMA and lowering memory limits."

    if [[ $RANDOMX_MODE == fast ]]; then
        NUMA_MIN_MEMORY=3
        #4416Mi

        if (($(echo "$MEMORY_SIZE >= $NUMA_MIN_MEMORY" | bc -l))); then
            echo "Found enough memory!"
        else
            echo "This provider has $(lscpu | grep "NUMA" | head -n1 | awk '{print $3}') NUMA nodes"
            echo "Increase the requested memory for this deployment to >= 3Gi"
            echo "You must close this deployment to change the memory requested."
            echo "If you don't want to close this deployment, please switch to RANDOMX_MODE=light and update the deployment."
            echo "------------------------------------------"
            echo "Deployment will continue in SLOW mode after 30 seconds, setting RANDOMX_MODE=light."
            sleep 30
            RANDOMX_MODE=light
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
fi

WORKER=$(echo ${WORKER}-${AKASH_CLUSTER_PUBLIC_HOSTNAME})

if [[ $POOL == *"hashvault"* ]]; then
echo "Checking nearest Hashvault location"
hashvault_locations=(pool.hashvault.pro:443 chicago01.hashvault.pro:443 frankfurt01.hashvault.pro:443 moscow01.hashvault.pro:443 singapore01.hashvault.pro:443)

for url in "${hashvault_locations[@]}"
do
   :
   echo "Checking average ping of $url for 5 seconds"
   original_url=$url
   url=${url%:*}
   ping=$(ping -c 5 $url | tail -1| awk '{print $4}' | cut -d '/' -f 2)
   url=$original_url
   echo "$url,$ping" >> speed.log
done

echo "------------------------------------------------------------------------"
server=$(cat speed.log | sort -t, -nk2 | head -n1 | awk -F"," '{print $1}')
pingtime=$(cat speed.log | sort -t, -nk2 | head -n1 | awk -F"," '{print $2}')
echo "The fastest server is $server with an average ping time of ${pingtime}ms"
echo "------------------------------------------------------------------------"
rm speed.log

POOL=$server
TLS=true
TLS_FINGERPRINT=420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14

elif [[ $POOL == *"ocean"* ]]; then
echo "Checking nearest MoneroOcean location"
moneroocean_locations=(gulf.moneroocean.stream:20128 us-or.moneroocean.stream:20128 us-va.moneroocean.stream:20128 us-oh.moneroocean.stream:20128 de.moneroocean.stream:20128 fi.moneroocean.stream:20128 fr.moneroocean.stream:20128 jp.moneroocean.stream:20128 sg.moneroocean.stream:20128)

for url in "${moneroocean_locations[@]}"
do
   :
   echo "Checking average ping of $url for 5 seconds"
   original_url=$url
   url=${url%:*}
   ping=$(ping -c 5 $url | tail -1| awk '{print $4}' | cut -d '/' -f 2)
   url=$original_url
   echo "$url,$ping" >> speed.log
done

echo "------------------------------------------------------------------------"
server=$(cat speed.log | sort -t, -nk2 | head -n1 | awk -F"," '{print $1}')
pingtime=$(cat speed.log | sort -t, -nk2 | head -n1 | awk -F"," '{print $2}')
echo "The fastest server is $server with an average ping time of ${pingtime}ms"
echo "------------------------------------------------------------------------"
rm speed.log

POOL=$server
TLS=true
TLS_FINGERPRINT=

elif [[ $POOL == "herominers" ]]; then
echo "Checking nearest Herominers location"
herominers_locations=(de.monero.herominers.com:1111 fi.monero.herominers.com:1111 ru.monero.herominers.com:1111 ca.monero.herominers.com:1111 us.monero.herominers.com:1111 us2.monero.herominers.com:1111 br.monero.herominers.com:1111 hk.monero.herominers.com:1111 kr.monero.herominers.com:1111 in.monero.herominers.com:1111 sg.monero.herominers.com:1111 tr.monero.herominers.com:1111)

for url in "${herominers_locations[@]}"
do
   :
   echo "Checking rtt time for $url"
   original_url=$url
   url=${url%:*}
   #ping=$(ping -c 5 $url | tail -1| awk '{print $4}' | cut -d '/' -f 2)
   ping=$(/usr/bin/time -f "%e" -o time_log -f "%E" nc -z $url 1111 | cat time_log | awk '{print $2}' | cut -d 's' -f 1)
   echo $ping
   url=$original_url
   if [[ ! -z $ping ]]; then
   echo "$url,$ping" >> speed.log
   sleep 3
   fi
done

echo "------------------------------------------------------------------------"
server=$(cat speed.log | sort -t, -nk2 | head -n1 | awk -F"," '{print $1}')
pingtime=$(cat speed.log | sort -t, -nk2 | head -n1 | awk -F"," '{print $2}')
echo "The fastest server is $server with an average ping time of ${pingtime}ms"
echo "------------------------------------------------------------------------"
#rm speed.log
if [[ ! -z $server ]]; then
echo "Could not detect nearest pool!  Using US as default."
server="us.monero.herominers.com:1111"
fi

POOL=$server
TLS=true
TLS_FINGERPRINT=
cat speed.log

else
echo "Using user pool"
fi


cd /xmrig
echo "Using POOL: ${POOL} WALLET: ${WALLET}  WORKER: ${WORKER} TLS: ${TLS} TLS_FINGERPRINT: ${TLS_FINGERPRINT}"
CUSTOM_OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$CUSTOM_OPTIONS") #Remove quotes

if [[ ${TLS_FINGERPRINT} != "" && ${TLS} == "true" ]]; then
    ./xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --tls-fingerprint ${TLS_FINGERPRINT} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --randomx-mode=$RANDOMX_MODE -t $CPU_COUNT --randomx-init=$CPU_COUNT $CUSTOM_OPTIONS
elif [[ ${TLS_FINGERPRINT} == "" && ${TLS} == "true" ]]; then
    ./xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --randomx-mode=$RANDOMX_MODE -t $CPU_COUNT --randomx-init=$CPU_COUNT $CUSTOM_OPTIONS
else
    ./xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --randomx-mode=$RANDOMX_MODE -t $CPU_COUNT --randomx-init=$CPU_COUNT $CUSTOM_OPTIONS
fi
