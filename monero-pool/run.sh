#!/bin/bash

DATA_MONERO=/data/monero
DATA_WALLET=/data/wallet
DATA_WALLET_LOG=/data/wallet.log
DATA_POOL=/data/pool

set -x

echo Updating monero-pool config...
sed -i "s/wallet-rpc-port\(.*\)/wallet-rpc-port = 28088/"              /usr/local/etc/pool.conf
sed -i "s/pool-wallet\(.*\)/pool-wallet = $MONERO_POOL_WALLET/"        /usr/local/etc/pool.conf
sed -i "s/pool-fee-wallet\(.*\)/pool-fee-wallet = $MONERO_FEE_WALLET/" /usr/local/etc/pool.conf
sed -i "s/block-notified\(.*\)/block-notified = 0/"                    /usr/local/etc/pool.conf
sed -i "s/data-dir\(.*\)/data-dir = \/data\/pool/"                     /usr/local/etc/pool.conf

echo Running Monero daemon...
mkdir -p $DATA_MONERO
/usr/local/bin/monerod --detach --data-dir $DATA_MONERO \
    --rpc-bind-ip 127.0.0.1 --rpc-bind-port 28081 \
    --rpc-restricted-bind-ip 0.0.0.0 --rpc-restricted-bind-port 28092 --confirm-external-bind $MONERO_ARGS
echo Sleeping for 10 secs...
sleep 10

echo Running Monero wallet RPC daemon...
mkdir -p $DATA_WALLET
/usr/local/bin/monero-wallet-rpc --detach --wallet-dir $DATA_WALLET \
    --log-file $DATA_WALLET_LOG --max-log-file-size 10485000 --max-log-files 10 \
    --daemon-address 127.0.0.1:28081 --trusted-daemon \
    --rpc-bind-ip 127.0.0.1 --rpc-bind-port 28088 --disable-rpc-login $MONERO_WALLET_ARGS
echo Sleeping for 10 secs...
sleep 10

echo Restoring wallet from mnemonic seed...
curl http://127.0.0.1:28088/json_rpc -d \
    "{\"jsonrpc\":\"2.0\", \"id\":\"0\", \"method\":\"restore_deterministic_wallet\", \"params\":{\"filename\":\"pool_wallet\", \"password\":\"\", \"seed\":\"$MONERO_POOL_WALLET_SEED\"}}" \
    -H "Content-Type: application/json"
echo Sleeping for 10 secs...
sleep 10

echo Running Monero pool...
mkdir -p $DATA_POOL
/usr/local/bin/monero-pool --config-file /usr/local/etc/pool.conf $@
