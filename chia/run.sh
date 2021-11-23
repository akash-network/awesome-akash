#!/bin/bash
ram=$(free -m | grep -oP '\d+' | head -n 1)
threads=$(grep -c ^processor /proc/cpuinfo)
cores=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}' )

echo "Found RAM: $ram"
echo "Found THREADS: $threads"
echo "Found CORES: $cores"

mkdir -p /root/chia/final ; mkdir -p /root/chia/tmp2 ; mkdir -p /root/chia/tmp

apt-get update ; DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -yqq ; DEBIAN_FRONTEND=noninteractive apt-get install -yqq git ssh sshpass rsync screen sudo
rm -rf chia-blockchain
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules ; cd chia-blockchain
sh install.sh ; . ./activate
chia init

if [ ! -z $KEYS ]; then
echo "Foud KEYS variable set, importing"
echo ${KEYS} > keys.txt ; chia keys add -f ./keys.txt ; rm keys.txt ; chia keys show
fi

#Upload prep
mkdir -p /root/.ssh/
touch /root/.ssh/known_hosts
ssh-keyscan -p ${REMOTE_PORT} ${REMOTE_HOST} >> ~/.ssh/known_hosts

if [ ! -z $PLOTTER ]; then
while :
do
sshpass -p "${REMOTE_PASS}" rsync -av --remove-source-files --progress /root/chia/final/*.plot -e "ssh -p ${REMOTE_PORT}" ${REMOTE_USER}@${REMOTE_HOST}:/root/raid/plots
if [[ ${PLOTTER} == "madmax" ]]; then
chia plotters madmax -k $SIZE -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 $TMPDIR2 -d $FINALDIR
elif [[ ${PLOTTER} == "blade" ]]; then
chia plotters bladebit -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -d $FINALDIR
else
chia plots create -k $SIZE -n $COUNT -r $THREADS -b $MEMORY -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 $TMPDIR2 -d $FINALDIR
fi

done
fi
