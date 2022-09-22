#!/usr/bin/env bash
if [ -z "$WALLET_ADDR" ]; then
  echo "WALLET_ADDR not defined"
  sleep 300
  exit 1
fi

echo "Checking CPU in pod"
if [ -f /sys/fs/cgroup/cpu/cpu.cfs_quota_us ]; then
CPU_COUNT=$(cat /sys/fs/cgroup/cpu/cpu.cfs_quota_us)
else
CPU_COUNT=$(cat /sys/fs/cgroup/cpu.max | awk '{print $1}')
fi
CPU_COUNT=$(echo "scale=0; $CPU_COUNT/100000" | bc -l) #Convert to threads
echo "Found $CPU_COUNT cpus available."

#Set uploaders to CPU count if higher than default 10
if [[ $CPU_COUNT > 10 ]]; then
UPLOADERS=$CPU_COUNT
else
UPLOADERS=10
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

if [[ $VERSION != "v0.5.2" ]]; then
echo "Got version $VERSION, pulling from Github" ; rm packetcrypt-${VERSION}-linux_amd64
wget https://github.com/cjdelisle/packetcrypt_rs/releases/download/packetcrypt-${VERSION}/packetcrypt-${VERSION}-linux_amd64 ; chmod +x packetcrypt-${VERSION}-linux_amd64
./packetcrypt-$VERSION-linux_amd64 ann --paymentaddr "$WALLET_ADDR" "${pools[@]}" --threads $CPU_COUNT --uploaders $UPLOADERS
else
echo "Got default version $VERSION"
./packetcrypt-$VERSION-linux_amd64 ann --paymentaddr "$WALLET_ADDR" "${pools[@]}" --threads $CPU_COUNT --uploaders $UPLOADERS
fi
