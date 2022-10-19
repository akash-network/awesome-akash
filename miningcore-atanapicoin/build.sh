#!/bin/bash
apt-get update ; apt-get -y install wget
wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb ; dpkg -i packages-microsoft-prod.deb ; rm packages-microsoft-prod.deb
apt-get update ; apt-get -y install dotnet-sdk-6.0 git cmake build-essential libssl-dev pkg-config libboost-all-dev libsodium-dev libzmq5-dev
git clone https://github.com/oliverw/miningcore ; cd miningcore/src/Miningcore ; cp /coins.json coins.json ; dotnet publish -c Release --framework net6.0 -o ../../build
