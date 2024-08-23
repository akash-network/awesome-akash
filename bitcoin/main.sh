#!/bin/bash
apt-get install -y  wget tar 
runsvdir -P /etc/service &
wget $LINK_BINARY
tar xvf `basename $LINK_BINARY`
rm `basename $LINK_BINARY`
install -m 0755 -o root -g root -t /usr/local/bin `ls | grep bitcoin`/bin/*
mkdir /root/.bitcoin

if [[ -n $SNAPSHOT ]]
then
apt-get install -y lz4
echo ==== Скачивание снепшота. Время скачивания зависит от провайдера! ====
echo = Downloading snapshot. The download time depends on the provider! =
curl $SNAPSHOT | lz4 -dc - | tar -xf - -C /root/.bitcoin
fi
bitcoind -prune=$PRUNE
