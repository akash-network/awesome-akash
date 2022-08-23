#!/bin/bash
source $HOME/.bashrc
TZ=Africa/Casablanca
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get update
apt-get upgrade -y
apt-get install -y sudo nano wget tar zip unzip jq goxkcdpwgen ssh nginx build-essential git make gcc nvme-cli pkg-config libssl-dev libleveldb-dev clang bsdmainutils ncdu libleveldb-dev apt-transport-https gnupg2 cron
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo ${my_root_password}; echo ${my_root_password}) | passwd root
service ssh restart
service nginx start
sleep 5
sudo apt-get install -y nano runit
runsvdir -P /etc/service &
source $HOME/.bashrc
wget -qO - https://apt.z.cash/zcash.asc | gpg --import
gpg --export 3FE63B67F85EA808DE9B880E6DEF3BAF272766C0 | sudo apt-key add -
echo "deb [arch=amd64] https://apt.z.cash/ buster main" | sudo tee /etc/apt/sources.list.d/zcash.list
sudo apt-get update
sudo apt-get install -y zcash
zcash-fetch-params
mkdir -p /root/.zcash/ && touch /root/.zcash/zcash.conf

while :
do
    pidof zcashd >/dev/null ; [[ $? -ne 0 ]] && echo "Restarting Zcashd:     $(date)" >> /var/log/zcashd.log && zcashd -daemon &
	sleep 900
done
