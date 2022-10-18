#!/bin/bash

DATA_MONERO=/data/monero
DATA_WALLET=/data/wallet
DATA_WALLET_LOG=/data/wallet.log
DATA_POOL=/data/pool
mkdir -p $DATA_MONERO
mkdir -p $DATA_WALLET
mkdir -p $DATA_POOL


if [[ $FAST_SYNC == true && $LOCAL == false && $VERIFY == false ]]; then
aria2c --out=data/blockchain.raw --summary-interval=5 -c -s 16 -x 16 -k 64M -j 1 https://downloads.getmonero.org/blockchain.raw
monero-blockchain-import --input-file /data/blockchain.raw --dangerous-unverified-import 1 --batch-size 25000 --data-dir /data/monero
rm /data/blockchain.raw
elif [[ $FAST_SYNC == true && $LOCAL == true && $VERIFY == true ]]; then
aria2c --out=data/blockchain.raw --summary-interval=5 -c -s 16 -x 16 -k 64M -j 1 https://downloads.getmonero.org/blockchain.raw
monero-blockchain-import --input-file /data/blockchain.raw --batch-size 25000 --data-dir /data/monero
rm /data/blockchain.raw
elif [[ $FAST_SYNC == true && $LOCAL == true ]]; then
#Expects blockchain.raw to already be in place for local sync
#aria2c --out=/data/blockchain.raw --summary-interval=5 -c -s 16 -x 16 -k 64M -j 1 https://downloads.getmonero.org/blockchain.raw
monero-blockchain-import --input-file /data/blockchain.raw --dangerous-unverified-import 1 --batch-size 25000 --data-dir /data/monero
rm /data/blockchain.raw
else
echo "Starting Slow Sync"
fi



set -x

echo Updating monero-pool config...
sed -i "s/wallet-rpc-port =\(.*\)/wallet-rpc-port = 28088/"                  /usr/local/etc/pool.conf
sed -i "s/pool-wallet =\(.*\)/pool-wallet = $POOL_WALLET/"                   /usr/local/etc/pool.conf
sed -i "s/pool-fee-wallet =\(.*\)/pool-fee-wallet = $FEE_WALLET/"            /usr/local/etc/pool.conf
sed -i "s/pool-fee =\(.*\)/pool-fee = $POOL_FEE/"                            /usr/local/etc/pool.conf
sed -i "s/payment-threshold =\(.*\)/payment-threshold = $PAYMENT_THRESHOLD/" /usr/local/etc/pool.conf

if [[ $LOCAL == true ]]; then #Testing
sed -i "s/block-notified =\(.*\)/block-notified = 1/"                        /usr/local/etc/pool.conf
fi

sed -i "s/data-dir =\(.*\)/data-dir = \/data\/pool/"                         /usr/local/etc/pool.conf
sed -i "s/log-file =\(.*\)/log-file = \/data\/pool.log/"                     /usr/local/etc/pool.conf

echo Running Monero daemon...

if [[ $LOCAL == true ]]; then
/usr/local/bin/monerod --detach --data-dir $DATA_MONERO \
    --rpc-bind-ip 127.0.0.1 --rpc-bind-port 28081 \
    --rpc-restricted-bind-ip 0.0.0.0 --rpc-restricted-bind-port 28092 --confirm-external-bind $MONERO_ARGS \
    --block-notify '/usr/bin/pkill -USR1 notify' \
    --enforce-dns-checkpointing --out-peers 128 --in-peers 1024 --limit-rate-up 1048576 --limit-rate-down 1048576
else
/usr/local/bin/monerod --detach --data-dir $DATA_MONERO \
    --rpc-bind-ip 127.0.0.1 --rpc-bind-port 28081 \
    --rpc-restricted-bind-ip 0.0.0.0 --rpc-restricted-bind-port 28092 --confirm-external-bind $MONERO_ARGS \
    --enforce-dns-checkpointing --out-peers 128 --in-peers 1024 --limit-rate-up 1048576 --limit-rate-down 1048576
fi

echo Sleeping for 30 secs...
sleep 30

echo Running Monero wallet RPC daemon...

/usr/local/bin/monero-wallet-rpc --detach --wallet-dir $DATA_WALLET \
    --log-file $DATA_WALLET_LOG --max-log-file-size 10485000 --max-log-files 10 \
    --daemon-address 127.0.0.1:28081 --trusted-daemon \
    --rpc-bind-ip 127.0.0.1 --rpc-bind-port 28088 --disable-rpc-login $MONERO_WALLET_ARGS
echo Sleeping for 30 secs...
sleep 30


echo Restoring wallet from mnemonic seed...
curl http://127.0.0.1:28088/json_rpc -d \
    "{\"jsonrpc\":\"2.0\", \"id\":\"0\", \"method\":\"restore_deterministic_wallet\", \"params\":{\"filename\":\"pool_wallet\", \"password\":\"\", \"seed\":\"$POOL_WALLET_SEED\"}}" \
    -H "Content-Type: application/json"
echo Sleeping for 30 secs...
sleep 30


echo Running Monero pool...
/usr/local/bin/monero-pool --config-file /usr/local/etc/pool.conf
