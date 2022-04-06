#!/bin/bash
#function build(){
apt-get update && \
        apt install iputils-ping msr-tools kmod git build-essential libbz2-dev cmake libuv1-dev libssl-dev libhwloc-dev wget gcc g++ -y && \
        apt clean && \
        rm -rf /var/lib/apt/lists/*

git clone https://github.com/xmrig/xmrig.git ; cd xmrig
sed -i 's/constexpr const int kDefaultDonateLevel = 1;/constexpr const int kDefaultDonateLevel = '${DONATE_LEVEL}';/g' src/donate.h
sed -i 's/constexpr const int kMinimumDonateLevel = 1;/constexpr const int kMinimumDonateLevel = '${DONATE_LEVEL}';/g' src/donate.h

mkdir build ; cd build ; cmake .. -DCMAKE_C_COMPILER=gcc-11 -DCMAKE_CXX_COMPILER=g++-11 -DCMAKE_BUILD_TYPE=Release ; make -j$(nproc) && cp xmrig /usr/bin
#}

if [[ $POOL == *"hashvault"* ]]; then
echo "Checking nearest Hashvault location"
hashvault_locations=(pool.hashvault.pro:443 chicago01.hashvault.pro:443 frankfurt01.hashvault.pro:443 moscow01.hashvault.pro:443 singapore01.hashvault.pro:443)

for url in "${hashvault_locations[@]}"
do
   :
   echo "Checking average ping of $url for 10 seconds"
   original_url=$url
   url=${url%:*}
   ping=$(ping -c 10 $url | tail -1| awk '{print $4}' | cut -d '/' -f 2)
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
   echo "Checking average ping of $url for 10 seconds"
   original_url=$url
   url=${url%:*}
   ping=$(ping -c 10 $url | tail -1| awk '{print $4}' | cut -d '/' -f 2)
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
fi

if [[ ${RANDOMX_1GB} == "true" ]];
then
RANDOMX_1GB_PAGES="--randomx-1gb-pages"
else
RANDOMX_1GB_PAGES=
fi

echo "Using POOL: ${POOL} WALLET: ${WALLET}  WORKER: ${WORKER} TLS: ${TLS} TLS_FINGERPRINT: ${TLS_FINGERPRINT}"

if [[ ${TLS_FINGERPRINT} != "" ]]; then
xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --tls-fingerprint ${TLS_FINGERPRINT} --http-host 0.0.0.0 --http-port 8080 --randomx-mode ${RANDOMX_MODE} ${RANDOMX_1GB_PAGES}
elif [[ ${TLS_FINGERPRINT} == "" && ${TLS} == "true" ]]; then
xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --http-host 0.0.0.0 --http-port 8080 --randomx-mode ${RANDOMX_MODE} ${RANDOMX_1GB_PAGES}
else
xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --http-host 0.0.0.0 --http-port 8080 --randomx-mode ${RANDOMX_MODE} ${RANDOMX_1GB_PAGES}
fi
