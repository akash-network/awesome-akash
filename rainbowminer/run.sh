#!/usr/bin/env bash
sed -i 's/CUSTWALLET/"'"$CUSTOM_WALLET"'"/g' ./RainbowMiner/setup.json
sed -i 's/BTC_WALLET/"'"$BTC_WALLET"'"/g' ./RainbowMiner/setup.json
sed -i 's/XMR_WALLET/"'"$XMR_WALLET"'"/g' ./RainbowMiner/setup.json
sed -i 's/DOGE_WALLET/"'"$DOGE_WALLET"'"/g' ./RainbowMiner/setup.json
sed -i 's/RVN_WALLET/"'"$RVN_WALLET"'"/g' ./RainbowMiner/setup.json
sed -i 's/XTZ_WALLET/"'"$XTZ_WALLET"'"/g' ./RainbowMiner/setup.json

sed -i 's/AECURRENCY/"'"$AECurrency"'"/g' ./RainbowMiner/setup.json
sed -i 's/REGION/"'"$REGION"'"/g' ./RainbowMiner/setup.json
sed -i 's/DONATE/"'"$DONATE"'"/g' ./RainbowMiner/setup.json

sed -i 's/SSLOPTION/"'"$SSL"'"/g' ./RainbowMiner/setup.json
sed -i 's/MINER_NAME/"'"$MINER_NAME"'"/g' ./RainbowMiner/setup.json
sed -i 's/ALGORITHM/"'"$ALGORITHM"'"/g' ./RainbowMiner/setup.json
sed -i 's/EXCLUDE_COIN_SYMBOL/"'"$EXCLUDE_COIN_SYMBOL"'"/g' ./RainbowMiner/setup.json
sed -i 's/EXALGO/"'"$EXCLUDE_ALGORITHM"'"/g' ./RainbowMiner/setup.json
sed -i 's/EXCLUDE_POOL_NAME/"'"$EXCLUDE_POOL_NAME"'"/g' ./RainbowMiner/setup.json
sed -i 's/EXCLUDE_COIN/"'"$EXCLUDE_COIN"'"/g' ./RainbowMiner/setup.json
sed -i 's/EXCLUDE_MINER_NAME/"'"$EXCLUDE_MINER_NAME"'"/g' ./RainbowMiner/setup.json
sed -i 's/POOLS/"'"$POOLS"'"/g' ./RainbowMiner/setup.json

./RainbowMiner/start.sh
