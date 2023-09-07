#!/usr/bin/env bash

remove_quotes() {
  local str="$1"
  str="${str%\"}"
  str="${str#\"}"
  echo "$str"
}

ALGO=$(remove_quotes "$ALGO")
PASSWORD=$(remove_quotes "$PASSWORD")
POOL=$(remove_quotes "$POOL")
WALLET_ADDRESS=$(remove_quotes "$WALLET_ADDRESS")
OPTIONS=$(remove_quotes "$OPTIONS")

if [ -z $WALLET ]; then
    echo "Please examine the SDL and be sure to set your Monero Wallet Address in the WALLET= variable."
    sleep 300
    exit
fi


WORKER=$(echo ${WORKER}-${AKASH_CLUSTER_PUBLIC_HOSTNAME})

echo "Using POOL: ${POOL} WALLET: ${WALLET}  WORKER: ${WORKER} TLS: ${TLS} TLS_FINGERPRINT: ${TLS_FINGERPRINT}"

if [[ ${TLS_FINGERPRINT} != "" && ${TLS} == "true" ]]; then
    ./xmrig/xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --tls-fingerprint ${TLS_FINGERPRINT} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --cuda --no-cpu $CUSTOM_OPTIONS
elif [[ ${TLS_FINGERPRINT} == "" && ${TLS} == "true" ]]; then
    ./xmrig/xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --tls --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --cuda --no-cpu $CUSTOM_OPTIONS
else
    ./xmrig/xmrig -a ${ALGO} --url ${POOL} --user ${WALLET} --rig-id ${WORKER} --pass ${WORKER} --http-host 0.0.0.0 --http-port 8080 --syslog --no-color --verbose --cuda --no-cpu $CUSTOM_OPTIONS
fi
