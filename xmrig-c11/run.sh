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

if [[ ${TLS_FINGERPRINT} != "" && ${TLS} == "true" ]]; then
    ./xmrig/xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --tls-fingerprint ${TLS_FINGERPRINT} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --cuda --no-cpu $CUSTOM_OPTIONS
elif [[ ${TLS_FINGERPRINT} == "" && ${TLS} == "true" ]]; then
    ./xmrig/xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --cuda --no-cpu $CUSTOM_OPTIONS
else
    ./xmrig/xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --cuda --no-cpu $CUSTOM_OPTIONS
fi
