#!/usr/bin/env bash
set -e

export NEAR_HOME=/srv/near

NEARD_FLAGS=${NEAR_HOME:+--home=$NEAR_HOME}

if [[ -z ${INIT} ]]
then
  if [[ -f ${NEAR_HOME}/validator_key.json ]] || [[ -f ${NEAR_HOME}/node_key.json ]]
  then
    echo "key exists. initialization skipped."
  else
    if [[ $CHAIN_ID == "localnet" ]]
    then
      echo "initiating on localnet..."
      neard $NEARD_FLAGS init --chain-id="localnet" ${ACCOUNT_ID:+--account-id=$ACCOUNT_ID}
    elif [[ $CHAIN_ID == "testnet" ]]
    then
      echo "initiating on testnet..."
      neard $NEARD_FLAGS init --chain-id="testnet" ${ACCOUNT_ID:+--account-id=$ACCOUNT_ID} --download-genesis
      rm -f ${NEAR_HOME}/config.json
      echo "getting config..."
      aria2c -x 4 -o ${NEAR_HOME}/config.json "https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/testnet/config.json"
      echo "getting data..."
      aria2c -x 16 -o ${NEAR_HOME}/data.tar "https://near-protocol-public.s3.ca-central-1.amazonaws.com/backups/testnet/rpc/data.tar"
      mkdir -p ${NEAR_HOME}/data
      tar -xf ${NEAR_HOME}/data.tar -C ${NEAR_HOME}/data
      rm -f ${NEAR_HOME}/data.tar
    else
      echo "initiating on mainnet..."
      neard $NEARD_FLAGS init --chain-id="mainnet" ${ACCOUNT_ID:+--account-id=$ACCOUNT_ID} --download-genesis
      rm -f ${NEAR_HOME}/config.json
      echo "getting config..."
      aria2c -x 4 -o ${NEAR_HOME}/config.json "https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/mainnet/config.json"
      echo "getting data..."
      aria2c -x 16 -o ${NEAR_HOME}/data.tar "https://near-protocol-public.s3.ca-central-1.amazonaws.com/backups/mainnet/rpc/data.tar"
      mkdir -p ${NEAR_HOME}/data
      tar -xf ${NEAR_HOME}/data.tar -C ${NEAR_HOME}/data
      rm -f ${NEAR_HOME}/data.tar
    fi
  fi
fi

if [[ -z ${ARCHIVE} ]]
then
  echo "archiving is disabled."
else
  echo "setting up node is as archive..."
  sed -i 's/"archive": false/"archive": true/g' ${NEAR_HOME}/config.json
fi

ulimit -c unlimited

echo "Telemetry: ${TELEMETRY_URL}"
echo "Bootnodes: ${BOOT_NODES}"

if [[ -z ${DISABLE_RPC} ]]
then
  neard $NEARD_FLAGS run ${TELEMETRY_URL:+--telemetry-url=$TELEMETRY_URL} ${BOOT_NODES:+--boot-nodes=$BOOT_NODES}
else
  neard $NEARD_FLAGS run --disable-rpc ${TELEMETRY_URL:+--telemetry-url=$TELEMETRY_URL} ${BOOT_NODES:+--boot-nodes=$BOOT_NODES}
fi

