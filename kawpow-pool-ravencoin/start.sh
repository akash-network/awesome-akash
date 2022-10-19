#!/bin/bash
cd kawpow-pool/
ls
chmod +x *.sh
service redis-server start
rm package-lock.json
rm -rf node_modules

npm install

sed -i '/const TAGS/,/taggedHash;/d' node_modules/bitcoinjs-lib/src/crypto.js

if [[ $NEOXA_ENABLE == "true" ]]; then
sed -i 's/NEOXA_ENABLE/true/g' pool_configs/neoxa.json
sed -i 's/WALLET/"'"$WALLET"'"/g' pool_configs/neoxa.json
sed -i 's/FEE/"'"${FEE_WALLET}"'"/g' pool_configs/neoxa.json
sed -i 's/AMOUNT/'${FEE_AMOUNT}'/g' pool_configs/neoxa.json
sed -i 's/HOST/"'"${DAEMON_HOST}"'"/g' pool_configs/neoxa.json
sed -i 's/PORT/'${DAEMON_PORT}'/g' pool_configs/neoxa.json
sed -i 's/USER/"'"${DAEMON_USER}"'"/g' pool_configs/neoxa.json
sed -i 's/PASS/"'"${DAEMON_PASS}"'"/g' pool_configs/neoxa.json
else
sed -i 's/NEOXA_ENABLE/false/g' pool_configs/neoxa.json
sed -i 's/WALLET/"'"$WALLET"'"/g' pool_configs/neoxa.json
sed -i 's/FEE/"'"${FEE_WALLET}"'"/g' pool_configs/neoxa.json
sed -i 's/AMOUNT/'${FEE_AMOUNT}'/g' pool_configs/neoxa.json
sed -i 's/HOST/"'"${DAEMON_HOST}"'"/g' pool_configs/neoxa.json
sed -i 's/PORT/'${DAEMON_PORT}'/g' pool_configs/neoxa.json
sed -i 's/USER/"'"${DAEMON_USER}"'"/g' pool_configs/neoxa.json
sed -i 's/PASS/"'"${DAEMON_PASS}"'"/g' pool_configs/neoxa.json
fi


if [[ $RAVEN_ENABLE == "true" ]]; then
sed -i 's/RAVEN_ENABLE/true/g' pool_configs/ravencoin.json
sed -i 's/WALLET/"'"$WALLET"'"/g' pool_configs/ravencoin.json
sed -i 's/FEE/"'"${FEE_WALLET}"'"/g' pool_configs/ravencoin.json
sed -i 's/AMOUNT/'${FEE_AMOUNT}'/g' pool_configs/ravencoin.json
sed -i 's/HOST/"'"${DAEMON_HOST}"'"/g' pool_configs/ravencoin.json
sed -i 's/PORT/'${DAEMON_PORT}'/g' pool_configs/ravencoin.json
sed -i 's/USER/"'"${DAEMON_USER}"'"/g' pool_configs/ravencoin.json
sed -i 's/PASS/"'"${DAEMON_PASS}"'"/g' pool_configs/ravencoin.json
else
sed -i 's/RAVEN_ENABLE/false/g' pool_configs/ravencoin.json
sed -i 's/WALLET/"'"$WALLET"'"/g' pool_configs/ravencoin.json
sed -i 's/FEE/"'"${FEE_WALLET}"'"/g' pool_configs/ravencoin.json
sed -i 's/AMOUNT/'${FEE_AMOUNT}'/g' pool_configs/ravencoin.json
sed -i 's/HOST/"'"${DAEMON_HOST}"'"/g' pool_configs/ravencoin.json
sed -i 's/PORT/'${DAEMON_PORT}'/g' pool_configs/ravencoin.json
sed -i 's/USER/"'"${DAEMON_USER}"'"/g' pool_configs/ravencoin.json
sed -i 's/PASS/"'"${DAEMON_PASS}"'"/g' pool_configs/ravencoin.json
fi

if [[ $MEOWCOIN_ENABLE == "true" ]]; then
sed -i 's/MEOWCOIN_ENABLE/true/g' pool_configs/meowcoin.json
sed -i 's/WALLET/"'"$WALLET"'"/g' pool_configs/meowcoin.json
sed -i 's/FEE/"'"${FEE_WALLET}"'"/g' pool_configs/meowcoin.json
sed -i 's/AMOUNT/'${FEE_AMOUNT}'/g' pool_configs/meowcoin.json
sed -i 's/HOST/"'"${DAEMON_HOST}"'"/g' pool_configs/meowcoin.json
sed -i 's/PORT/'${DAEMON_PORT}'/g' pool_configs/meowcoin.json
sed -i 's/USER/"'"${DAEMON_USER}"'"/g' pool_configs/meowcoin.json
sed -i 's/PASS/"'"${DAEMON_PASS}"'"/g' pool_configs/meowcoin.json
else
sed -i 's/MEOWCOIN_ENABLE/false/g' pool_configs/meowcoin.json
sed -i 's/WALLET/"'"$WALLET"'"/g' pool_configs/meowcoin.json
sed -i 's/FEE/"'"${FEE_WALLET}"'"/g' pool_configs/meowcoin.json
sed -i 's/AMOUNT/'${FEE_AMOUNT}'/g' pool_configs/meowcoin.json
sed -i 's/HOST/"'"${DAEMON_HOST}"'"/g' pool_configs/meowcoin.json
sed -i 's/PORT/'${DAEMON_PORT}'/g' pool_configs/meowcoin.json
sed -i 's/USER/"'"${DAEMON_USER}"'"/g' pool_configs/meowcoin.json
sed -i 's/PASS/"'"${DAEMON_PASS}"'"/g' pool_configs/meowcoin.json
fi


cat pool_configs/neoxa.json
cat pool_configs/ravencoin.json
cat pool_configs/meowcoin.json

cat node_modules/bitcoinjs-lib/src/crypto.js
cd scripts
gcc blocknotify.c -o blocknotify
cp blocknotify /usr/local/bin
cd ..
./pool-start.sh
./pool-logs-watch.sh
