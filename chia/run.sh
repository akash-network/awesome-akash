#!/bin/bash

#SSH Test if required
if [[ "$REMOTE_LOCATION" != "local" ]]; then
echo "SSH connection test before unpacking..."
mkdir -p /root/.ssh/
touch /root/.ssh/known_hosts
echo "Found $REMOTE_HOST with user $REMOTE_USER on port $REMOTE_PORT to upload to"
ssh-keyscan -p "${REMOTE_PORT}" "${REMOTE_HOST}" >> ~/.ssh/known_hosts ; export SSHPASS=${REMOTE_PASS}

sshpass -e ssh -o ConnectTimeout=5 -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST exit
if [ $? != "0" ]; then
    echo "SSH Connection failed - please check your settings"
    exit
fi
fi

mkdir /plots
chmod 777 /plots -R
git clone https://github.com/prasathmani/tinyfilemanager /filemanager
cp /filemanager/tinyfilemanager.php /plots/index.php

mv /config.php /plots/
mv /nginx.conf /etc/nginx/sites-enabled/default

sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/8.1/fpm/php.ini
sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 1000G/g" /etc/php/8.1/fpm/php.ini
sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 1000G/g" /etc/php/8.1/fpm/php.ini
sed -i -e "/listen\s*=\s*\/run\/php\/php8.1-fpm.sock/c\listen = 127.0.0.1:9000" /etc/php/8.1/fpm/pool.d/www.conf
sed -i -e "/pid\s*=\s*\/run/c\pid = /run/php8.1-fpm.pid" /etc/php/8.1/fpm/php-fpm.conf
#Adjusting app name
sed -i -e "s/File Manager/Chia Plot Manager/g" /plots/index.php
sed -i -e "s/Tiny Chia Plot Manager/Chia Plot Manager/g" /plots/index.php

/etc/init.d/nginx start
/etc/init.d/php8.1-fpm start

if [[ "$REMOTE_LOCATION" == "local" ]]; then
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "Plots will be created locally.  Please check Akashlytics for the Uri - you can find this on the"
echo "deployment details page.  Plots will only appear after creation.  Please be patient for your first"
echo "plots to appear.  Sleeping 60 seconds before starting..."
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
sleep 60
else
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "Plots will be uploaded to $REMOTE_LOCATION on $REMOTE_HOST.                                        "
echo "After the plot is succesfully uploaded it will be deleted automatically from the deployment        "
echo "Sleeping 10 seconds before starting...                                                             "
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
sleep 10
fi


echo "Let's get thing started..."
ram=$(free -m | grep -oP '\d+' | head -n 1)
threads=$(grep -c ^processor /proc/cpuinfo)
cores=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}' )

echo "Found RAM: $ram"
echo "Found THREADS: $threads"
echo "Found CORES: $cores"

#Max out threads
echo Using $THREADS as defined by user

mkdir -p /root/chia/final ; mkdir -p /root/chia/tmp2 ; mkdir -p /root/chia/tmp

rm -rf chia-blockchain
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules ; cd chia-blockchain
sh install.sh ; . ./activate
chia init

if [ ! -z $KEYS ]; then
echo "Foud KEYS variable set, importing"
echo ${KEYS} > keys.txt ; chia keys add -f ./keys.txt ; rm keys.txt ; chia keys show
fi

if [ ! -z $PLOTTER ]; then
while :
do
chmod 777 /plots -R

#Always check if full first
if [[ $(ls -la /plots/*.plot | wc -l) > 6 ]]; then
echo "Deployment is full, please delete plots to make room for plotting! Sleeping for 60 seconds before checking for free space."
sleep 60
fi

if [[ "$REMOTE_LOCATION" != "local" ]]; then

if [[ "$UPLOAD_BACKGROUND" == "true" ]]; then
nohup sshpass -e rsync -av --remove-source-files --progress /plots/*.plot -e "ssh -p ${REMOTE_PORT}" "${REMOTE_USER}"@"${REMOTE_HOST}":"${REMOTE_LOCATION}" >> /plots/rsync.log 2>&1 &
else
sshpass -e rsync -av --remove-source-files --progress /plots/*.plot -e "ssh -p ${REMOTE_PORT}" "${REMOTE_USER}"@"${REMOTE_HOST}":"${REMOTE_LOCATION}"
fi

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
chia plotters madmax -k $SIZE -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -d $FINALDIR
elif [[ ${PLOTTER} == "blade" ]]; then
apt-get install -y libgmp3-dev
chia plotters bladebit -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -d $FINALDIR
else
chia plots create -k $SIZE -n $COUNT -r $THREADS -b $MEMORY -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 $TMPDIR2 -d $FINALDIR
fi


fi

done
fi

