#!/bin/bash
#mkdir tmp 
#for CA certificates
if [[ "$REMOTE_LOCATION" != "local" ]]; then
echo "Upload test before unpacking..."
mkdir -p /root/.ssh/
touch /root/.ssh/known_hosts
echo "Found $REMOTE_HOST with user $REMOTE_USER on port $REMOTE_PORT to upload to"
ssh-keyscan -p "${REMOTE_PORT}" "${REMOTE_HOST}" >> ~/.ssh/known_hosts
ssh -o BatchMode=yes -o ConnectTimeout=5 -p "$REMOTE_PORT" "$REMOTE_USER"@"$REMOTE_HOST" echo Upload Destination Connection OK 2>&1 || echo "Did not pass go! Check your SSH settings" && exit 1
else
#DEBIAN_FRONTEND=noninteractive apt-get install -yqq nginx php-fpm
mkdir /plots
#touch /plots/plot.plot
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

#service nginx restart
/etc/init.d/nginx start
/etc/init.d/php8.1-fpm start


echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "Plots will be created locally.  You can access your plots at : ${AKASH_CLUSTER_PUBLIC_HOSTNAME}"
echo "Plots will only appear after creation.  Please be patient for your first plot to appear."
echo "Sleeping 30 seconds before starting..."
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"
echo "###################################################################################################"

sleep 30
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

#Upload prep
#mkdir -p /root/.ssh/
#touch /root/.ssh/known_hosts
#ssh-keyscan -p "${REMOTE_PORT}" "${REMOTE_HOST}" >> ~/.ssh/known_hosts

if [ ! -z $PLOTTER ]; then
while :
do
chmod 777 /plots -R
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
chia plotters madmax -k $SIZE -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -d /plots/
elif [[ ${PLOTTER} == "blade" ]]; then
apt-get install -y libgmp3-dev
chia plotters bladebit -n $COUNT -r $THREADS -c $CONTRACT -f $FARMERKEY -d /plots/
else
chia plots create -k $SIZE -n $COUNT -r $THREADS -b $MEMORY -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 $TMPDIR2 -d /plots/
fi


fi

done
fi
