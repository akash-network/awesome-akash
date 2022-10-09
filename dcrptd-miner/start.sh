#!/bin/bash
cp ./dcrptd-miner/bin/Release/net6.0/linux-x64/config.json /

#WALLET_ADDRESS_HERE.WorkerName $WALLET.$WORKER

sed -i 's/WALLET_ADDRESS_HERE.WorkerName/'${WALLET}.${WORKER}'/g' config.json
sed -i 's/shifu\:\/\/185.215.180.7\:5555/stratum+tcp\:\/\/'${POOL}'/g' config.json
cat config.json

screen -L -Logfile dcryptd.log -dmS dcryptd ./dcrptd-miner/bin/Release/net6.0/linux-x64/dcrptd-miner
sleep 5
tail -f dcryptd.log
#exec ./dcrptd-miner/bin/Release/net6.0/linux-x64/dcrptd-miner
