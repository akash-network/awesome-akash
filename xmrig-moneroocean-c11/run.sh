#!/usr/bin/env bash
remove_quotes() {
  local str="$1"
  str="${str%\"}"
  str="${str#\"}"
  echo "$str"
}

for var_name in ALGO POOL WALLET WORKER TLS_FINGERPRINT TLS CUSTOM_OPTIONS; do
  eval "value=\$$var_name"
  value=$(remove_quotes "$value")

  if [ -z "$value" ]; then
    if [[ "$var_name" != "TLS_FINGERPRINT" && "$var_name" != "CUSTOM_OPTIONS" ]]; then
      echo "Please examine the SDL and be sure to set $var_name."
      sleep 300
      exit
    fi
  else
    eval "$var_name=\"$value\""
  fi
done


WORKER=$(echo ${WORKER}-${AKASH_CLUSTER_PUBLIC_HOSTNAME})

echo "Using POOL: ${POOL} WALLET: ${WALLET}  WORKER: ${WORKER} TLS: ${TLS} TLS_FINGERPRINT: ${TLS_FINGERPRINT}"

#./xmrig/xmrig -a "cn/gpu" --url gulf.moneroocean.stream:20128 --user 4AbG74FRUHYXBLkvqM1f7QH3UXGkhLetKdxS7U7BHkyfMF4nfx99GvN1REwYQHAeVLLy4Qa5gXXkfS4pSHHUWwdVFifDo5K --pass akash~cn/gpu --cuda --no-cpu --syslog --no-color --verbose

#./xmrig/xmrig --url gulf.moneroocean.stream:10128 --user 4AbG74FRUHYXBLkvqM1f7QH3UXGkhLetKdxS7U7BHkyfMF4nfx99GvN1REwYQHAeVLLy4Qa5gXXkfS4pSHHUWwdVFifDo5K -p "akash~cn/gpu" --verbose --no-color --cuda --no-cpu

./xmrig/xmrig --url gulf.moneroocean.stream:10128 --user 4AbG74FRUHYXBLkvqM1f7QH3UXGkhLetKdxS7U7BHkyfMF4nfx99GvN1REwYQHAeVLLy4Qa5gXXkfS4pSHHUWwdVFifDo5K --verbose --no-color --cuda --no-cpu

 --bench-algo-time 60

./xmrig/xmrig --url gulf.moneroocean.stream:20128 --user 4AbG74FRUHYXBLkvqM1f7QH3UXGkhLetKdxS7U7BHkyfMF4nfx99GvN1REwYQHAeVLLy4Qa5gXXkfS4pSHHUWwdVFifDo5K --verbose --no-color --cuda --no-cpu --tls --bench-algo-time 60


bnechsleep infinity

#algo-perf

 --cuda --syslog --no-color --verbose -t 1


sleep infinity

./xmrig/xmrig -c /xmrig/config.json

sleep infinity

if [[ ${TLS_FINGERPRINT} != "" && ${TLS} == "true" ]]; then
    ./xmrig/xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --tls-fingerprint ${TLS_FINGERPRINT} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --cuda --no-cpu $CUSTOM_OPTIONS
elif [[ ${TLS_FINGERPRINT} == "" && ${TLS} == "true" ]]; then
    ./xmrig/xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --cuda --no-cpu $CUSTOM_OPTIONS
else
    ./xmrig/xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --cuda --no-cpu $CUSTOM_OPTIONS
fi

sleep infinity
