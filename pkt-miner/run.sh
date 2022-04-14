#!/usr/bin/env bash

if [ -z "$WALLET_ADDR" ]; then
  echo "WALLET_ADDR not defined"
  exit 1
fi

declare -a pools

readarray -t pools <<< $(
  env | \
    grep '^POOL[[:digit:]]\+=' | \
    sort | \
    cut -d= -f2
)

if [ -z "${pools[0]}" ]; then
  pools[0]="$POOL_HOST_DEFAULT"
fi

echo "using pools ${pools[*]}..."

./packetcrypt ann --paymentaddr "$WALLET_ADDR" "${pools[@]}"
