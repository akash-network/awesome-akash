#!/bin/bash
if [ -z ${LINK_BINARY} ]; then LINK_BINARY="https://bitcoin.org/bin/bitcoin-core-27.0/bitcoin-27.0-x86_64-linux-gnu.tar.gz" ;fi
wget ${LINK_BINARY}
tar xvf `basename ${LINK_BINARY}`
rm `basename ${LINK_BINARY}`
install -m 0755 -o root -g root -t /usr/local/bin `ls | grep bitcoin`/bin/*

if [[ -n ${SNAPSHOT} ]]
then
apt-get install -y lz4
mkdir /root/.bitcoin
echo ==== Скачивание снепшота. Время скачивания зависит от провайдера! ====
echo == Downloading snapshot. The download time depends on the provider! ==
curl ${SNAPSHOT} | lz4 -dc - | tar -xf - -C /root/.bitcoin
fi

bitcoind ${ARGS}
