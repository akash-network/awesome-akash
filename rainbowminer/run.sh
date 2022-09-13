#!/usr/bin/env bash
sed -i 's/BTC_WALLET/"'"$BTC_WALLET"'"/g' ./RainbowMiner/setup.json
sed -i 's/XMR_WALLET/"'"$XMR_WALLET"'"/g' ./RainbowMiner/setup.json
sed -i 's/DOGE_WALLET/"'"$DOGE_WALLET"'"/g' ./RainbowMiner/setup.json
sed -i 's/RVN_WALLET/"'"$RVN_WALLET"'"/g' ./RainbowMiner/setup.json
sed -i 's/XTZ_WALLET/"'"$XTZ_WALLET"'"/g' ./RainbowMiner/setup.json

sed -i 's/POOLS/"'"$POOLS"'"/g' ./RainbowMiner/setup.json
sed -i 's/AECURRENCY/"'"$AECurrency"'"/g' ./RainbowMiner/setup.json

./RainbowMiner/start.sh
