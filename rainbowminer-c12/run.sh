#!/usr/bin/env bash

echo "Checking CPU in pod"
if [ -f /sys/fs/cgroup/cpu/cpu.cfs_quota_us ]; then
CPU_COUNT=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us)
else
CPU_COUNT=$(cat /sys/fs/cgroup/cpu.max | awk '{print $1}')
fi
CPU_COUNT=$(echo "scale=0; $CPU_COUNT/100000" | bc -l) #Convert to Cores
echo "Found $CPU_COUNT cpus available."

CPUS=$CPU_COUNT

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
sed -i 's/INTERVAL/"'"$BENCHMARK_INTERVAL"'"/g' ./RainbowMiner/setup.json
sed -i 's/CPUS/"'"$CPUS"'"/g' ./RainbowMiner/setup.json
sed -i 's/PROHASHING/"'"$PROHASHING"'"/g' ./RainbowMiner/setup.json
sed -i 's/MINING_DUTCH/"'"$MINING_DUTCH"'"/g' ./RainbowMiner/setup.json



#remove affinity and threads from miners


./RainbowMiner/start.sh
