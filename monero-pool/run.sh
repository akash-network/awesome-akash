#!/bin/bash

if [[ $FAST_SYNC == true && $LOCAL == false ]]; then
aria2c --out=/data/blockchain.raw --summary-interval=5 -c -s 16 -x 16 -k 64M -j 1 https://downloads.getmonero.org/blockchain.raw
monero-blockchain-import --input-file /data/blockchain.raw --batch-size 20000 --data-dir /data/monero
rm /data/blockchain.raw
elif [[ $FAST_SYNC == true && $LOCAL == true ]]; then
#aria2c --out=/data/blockchain.raw --summary-interval=5 -c -s 16 -x 16 -k 64M -j 1 https://downloads.getmonero.org/blockchain.raw
monero-blockchain-import --input-file /data/blockchain.raw --batch-size 20000 --data-dir /data/monero
rm /data/blockchain.raw
else
echo "Starting Slow Sync"
fi



DATA_MONERO=/data/monero
DATA_WALLET=/data/wallet
DATA_WALLET_LOG=/data/wallet.log
DATA_POOL=/data/pool

set -x

echo Updating monero-pool config...
sed -i "s/wallet-rpc-port =\(.*\)/wallet-rpc-port = 28088/"                  /usr/local/etc/pool.conf
sed -i "s/pool-wallet =\(.*\)/pool-wallet = $POOL_WALLET/"                   /usr/local/etc/pool.conf
sed -i "s/pool-fee-wallet =\(.*\)/pool-fee-wallet = $FEE_WALLET/"            /usr/local/etc/pool.conf
sed -i "s/pool-fee =\(.*\)/pool-fee = $POOL_FEE/"                            /usr/local/etc/pool.conf
sed -i "s/payment-threshold =\(.*\)/payment-threshold = $PAYMENT_THRESHOLD/" /usr/local/etc/pool.conf

if [[ $LOCAL == true ]]; then
sed -i "s/block-notified =\(.*\)/block-notified = 1/"                        /usr/local/etc/pool.conf
fi

sed -i "s/data-dir =\(.*\)/data-dir = \/data\/pool/"                         /usr/local/etc/pool.conf
sed -i "s/log-file =\(.*\)/log-file = \/data\/pool.log/"                     /usr/local/etc/pool.conf


#db-sync-mode=safe
#enforce-dns-checkpointing=1
#out-peers=64              # This will enable much faster sync and tx awareness; the default 8 is suboptimal nowadays
#in-peers=1024             # The default is unlimited; we prefer to put a cap on this
#limit-rate-up=1048576     # 1048576 kB/s == 1GB/s; a raise from default 2048 kB/s; contribute more to p2p network
#limit-rate-down=1048576   # 1048576 kB/s == 1GB/s; a raise from default 8192 kB/s; allow for faster initial sync

echo Running Monero daemon...
mkdir -p $DATA_MONERO

if [[ $LOCAL == true ]]; then
/usr/local/bin/monerod --detach --data-dir $DATA_MONERO \
    --rpc-bind-ip 127.0.0.1 --rpc-bind-port 28081 \
    --rpc-restricted-bind-ip 0.0.0.0 --rpc-restricted-bind-port 28092 --confirm-external-bind $MONERO_ARGS \
    --block-notify '/usr/bin/pkill -USR1 notify' \
    --db-sync-mode safe --enforce-dns-checkpointing --out-peers 128 --in-peers 1024 --limit-rate-up 1048576 --limit-rate-down 1048576
else
/usr/local/bin/monerod --detach --data-dir $DATA_MONERO \
    --rpc-bind-ip 127.0.0.1 --rpc-bind-port 28081 \
    --rpc-restricted-bind-ip 0.0.0.0 --rpc-restricted-bind-port 28092 --confirm-external-bind $MONERO_ARGS \
    --db-sync-mode safe --enforce-dns-checkpointing --out-peers 128 --in-peers 1024 --limit-rate-up 1048576 --limit-rate-down 1048576
fi

echo Sleeping for 30 secs...
sleep 30

echo Running Monero wallet RPC daemon...
mkdir -p $DATA_WALLET

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
mkdir -p $DATA_POOL
#/usr/local/bin/monero-pool --config-file /usr/local/etc/pool.conf $@
/usr/local/bin/monero-pool --config-file /usr/local/etc/pool.conf


#monerod --p2p-bind-ip=0.0.0.0 --p2p-bind-port=18080 --rpc-bind-ip=0.0.0.0 --rpc-bind-port=18081 --non-interactive --confirm-external-bind

