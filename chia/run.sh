#!/bin/bash
#mkdir tmp 
#for CA certificates
#apt-get update ; DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -yqq ; DEBIAN_FRONTEND=noninteractive apt-get install -yqq git sshpass rsync screen sudo
if [[ "$REMOTE_LOCATION" != "local" ]]; then
echo "Upload test before unpacking..."
mkdir -p /root/.ssh/
touch /root/.ssh/known_hosts
echo "Found $REMOTE_HOST with user $REMOTE_USER on port $REMOTE_PORT to upload to"
ssh-keyscan -p "${REMOTE_PORT}" "${REMOTE_HOST}" >> ~/.ssh/known_hosts
ssh -o BatchMode=yes -o ConnectTimeout=5 -p "$REMOTE_PORT" "$REMOTE_USER"@"$REMOTE_HOST" echo Upload Destination Connection OK 2>&1 || echo "Did not pass go! Check your SSH settings" && exit 1
else
DEBIAN_FRONTEND=noninteractive apt-get install -yqq nginx
mkdir /plots
touch /plots/plot.plot
tee /etc/nginx/sites-enabled/default <<EOF
server {
  listen  8080;
  location / {
    root /plots/;
    index index.html;
    autoindex on;
  }
}
EOF
service nginx restart
echo "Plot will be created locally.  You can download a plot at ${AKASH_CLUSTER_PUBLIC_HOSTNAME}:8080"
fi
echo "Let's get thing started..."
ram=$(free -m | grep -oP '\d+' | head -n 1)
threads=$(grep -c ^processor /proc/cpuinfo)
cores=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}' )

echo "Found RAM: $ram"
echo "Found THREADS: $threads"
echo "Found CORES: $cores"

mkdir -p /root/chia/final ; mkdir -p /root/chia/tmp2 ; mkdir -p /root/chia/tmp

rm -rf chia-blockchain
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules ; cd chia-blockchain
sh install.sh ; . ./activate
chia init

if [ ! -z $KEYS ]; then
echo "Foud KEYS variable set, importing"
echo ${KEYS} > keys.txt ; chia keys add -f ./keys.txt ; rm keys.txt ; chia keys show
fi

#Upload prep
#mkdir -p /root/.ssh/
#touch /root/.ssh/known_hosts
#ssh-keyscan -p "${REMOTE_PORT}" "${REMOTE_HOST}" >> ~/.ssh/known_hosts

if [ ! -z $PLOTTER ]; then
while :
do

if [[ "$REMOTE_LOCATION" != "local" ]]; then

sshpass -p "${REMOTE_PASS}" rsync -av --remove-source-files --progress /root/chia/final/*.plot -e "ssh -p ${REMOTE_PORT}" "${REMOTE_USER}"@"${REMOTE_HOST}":"${REMOTE_LOCATION}"
if [[ ${PLOTTER} == "madmax" ]]; then
chia plotters madmax -k $SIZE -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 $TMPDIR2 -d $FINALDIR
elif [[ ${PLOTTER} == "blade" ]]; then
apt-get install -y libgmp3-dev
chia plotters bladebit -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -d $FINALDIR
else
chia plots create -k $SIZE -n $COUNT -r $THREADS -b $MEMORY -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 $TMPDIR2 -d $FINALDIR
fi

else

if [[ ${PLOTTER} == "madmax" ]]; then
chia plotters madmax -k $SIZE -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -D -d /plots/
elif [[ ${PLOTTER} == "blade" ]]; then
apt-get install -y libgmp3-dev
chia plotters bladebit -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -d /plots/
else
chia plots create -k $SIZE -n $COUNT -r $THREADS -b $MEMORY -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 $TMPDIR2 -d /plots/
fi


fi

done
fi
