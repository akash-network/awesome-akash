#!/bin/bash
if [[ -z "$CONTRACT" || -z "$FARMERKEY" ]]; then
  echo "CONTRACT or FARMERKEY not set - please check your settings"
  sleep 300
  exit
fi


if [[ $RCLONE == "true" && $JSON_SERVER != "" ]]; then
  CHECK_PLOTS=$(curl --retry-all-errors --retry 5 --head "$JSON_SERVER?_page=1&_limit=1" | grep Total-Count | head -n1 | cut -d":" -f2- | cut -d" " -f2-)
  echo "Found $CHECK_PLOTS total plots"
  if [[ $CHECK_PLOTS > $TOTAL_PLOTS ]]; then
    echo "Plotting order is complete! Found $CHECK_PLOTS / $TOTAL_PLOTS requested on $JSON_SERVER. Please kill this deployment or update TOTAL_PLOTS"
    exit
  else
    echo "Plotting order found $CHECK_PLOTS / $TOTAL_PLOTS requested on $JSON_SERVER."
  fi
  #if [[ $JSON_SERVER != "" ]]; then
    #until [ "$CHECK_PLOTS" -lt "$TOTAL_PLOTS" ]; do
  #  while (($CHECK_PLOTS > $TOTAL_PLOTS)); do
  #    echo "Plotting order is complete! Found $CHECK_PLOTS / $TOTAL_PLOTS requested on $JSON_SERVER. Please kill this deployment or update TOTAL_PLOTS"
  #    sleep 15
  #    CHECK_PLOTS=$(curl --retry-all-errors --retry 300 --head "$JSON_SERVER?_page=1&_limit=1" | grep Total-Count | head -n1 | cut -d":" -f2- | cut -d" " -f2-)
  #  done
  #fi
fi

if [[ "$FINAL_LOCATION" != "local" && "$RCLONE" == "false" ]]; then
  echo "SSH connection test before unpacking..."
  mkdir -p /root/.ssh/
  touch /root/.ssh/known_hosts
  echo "Found $REMOTE_HOST with user $REMOTE_USER on port $REMOTE_PORT to upload to"
  ssh-keyscan -p "${REMOTE_PORT}" "${REMOTE_HOST}" >>~/.ssh/known_hosts
  export SSHPASS=${REMOTE_PASS}

  sshpass -e ssh -o ConnectTimeout=5 -p $REMOTE_PORT $REMOTE_USER@$REMOTE_HOST exit
  if [ $? != 0 ]; then
    echo "SSH Connection failed - please check your settings"
    sleep 300
    exit
  fi
fi

if [[ -z "$CPU_UNITS" || -z "$MEMORY_UNITS" || -z "$STORAGE_UNITS" ]]; then
  echo "CPU_UNITS, MEMORY_UNITS, STORAGE_UNITS variables not set - please check your settings"
  sleep 300
  exit
else

  echo "Found the following deployment compute settings, please verify these values match your SDL."
  echo "Using $CPU_UNITS threads, $MEMORY_UNITS memory, and $STORAGE_UNITS for storage."

  STORAGE_UNITS=$(echo $STORAGE_UNITS | sed 's/[^0-9]//g') #Remove Gi from variable
  MEMORY_UNITS=$(echo $MEMORY_UNITS | sed 's/[^0-9]//g')   #Remove Gi from variable

  STORAGE_MIN=364 #Required for Madmax 256Gb + 1 Plot
  STORAGE_MAX=$(echo "${STORAGE_UNITS}-${STORAGE_MIN}" | bc -l)
  STORAGE_PLOTS=$(echo "${STORAGE_MAX}/${K32_SIZE}" | bc -l | awk '{print int($1+0.5)}') #Round down

  echo Found $STORAGE_UNITS Storage units
  echo Found $MEMORY_UNITS Memory units
  echo Found $STORAGE_MIN Storage min units
  echo Found $STORAGE_MAX Storage max units
  echo Found $STORAGE_PLOTS Storage plots

  if (($STORAGE_UNITS < 364)); then
    echo "${STORAGE_UNITS}Gi is not enough disk space to create a plot with.  Please use at least 364Gi."
    sleep 300
    exit
  fi

  if (($MEMORY_UNITS < 6)); then
    echo "${MEMORY_UNITS}Gi is not enough memory to create a plot with.  Please use at least 6Gi."
    sleep 300
    exit
  fi

  if (($STORAGE_PLOTS < 1)); then
    echo "${STORAGE_MAX}Gi is not enough storage to create a plot with.  Please use at least 364Gi."
    sleep 300
    exit
  fi

  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "This deployment can create a total of $STORAGE_PLOTS plots on ${STORAGE_UNITS}Gi available storage "
  echo "requested without stopping. If this number doesn\'t look right - you need to update the CPU_UNITS, "
  echo "MEMORY_UNITS, STORAGE_UNITS to match the units requested in the SDL. Sleeping 30 seconds.          "
  sleep 30
fi

if [[ "$FINAL_LOCATION" == "local" ]]; then
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "Plots will be created locally.  Please check Akashlytics for the Uri - you can find this on the   "
  echo "deployment details page.  Plots will only appear after creation.  Please be patient for your first"
  echo "plots to appear.  Starting in 15 seconds.                                                          "
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  sleep 15
else
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "Plots will be uploaded to $FINAL_LOCATION on $REMOTE_HOST.                                         "
  echo "After the plot is succesfully uploaded it will be deleted automatically from the deployment        "
  echo "Starting in 15 seconds.                                                                            "
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  sleep 15
fi


if [[ $JSON_RCLONE != "" ]]; then
  mkdir -p /root/.config/rclone/
  echo -e "$JSON_RCLONE" >/root/.config/rclone/rclone.conf
  sed -i 's/ //' /root/.config/rclone/rclone.conf
fi

if [[ $RCLONE == "true" ]]; then
  echo Found RCLONE
  wget https://downloads.rclone.org/rclone-current-linux-amd64.deb
  dpkg -i rclone-current-linux-amd64.deb
  screen -dmS sync bash sync_rclone.sh
  screen -ls
  if ! screen -list | grep -q "sync"; then
    echo "Rclone is not running!"
    sleep 60
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

mkdir -p /root/chia/final
mkdir -p /root/chia/tmp2
mkdir -p /root/chia/tmp

if [[ ${PLOTTER} == "bladebit-disk" ]]; then
  git clone https://github.com/Chia-Network/bladebit.git && cd bladebit && git checkout $BLADEBIT_VERSION
  mkdir -p build && cd build
  cmake ..
  cmake --build . --target bladebit --config Release -j $(nproc)
  cd ..
  cp ./build/bladebit /usr/local/bin/
  cd /
else
  rm -rf chia-blockchain
  git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
  cd chia-blockchain
  git checkout $VERSION
  sh install.sh
  . ./activate
  chia init
fi

if [[ "$UPLOAD_BACKGROUND" == "true" && "$FINAL_LOCATION" != "local" && "$RCLONE" == "false" ]]; then
  screen -dmS sync bash ./sync.sh
fi

if [[ $PLOTTER == "madmax-ramdrive" ]]; then
  mkdir -p /mnt/ram
  mount -t tmpfs -o size=110G tmpfs /mnt/ram/
fi

if [ ! -z $KEYS ]; then
  echo "Foud KEYS variable set, importing"
  echo ${KEYS} >keys.txt
  chia keys add -f ./keys.txt
  rm keys.txt
  chia keys show
fi

COUNT=0


if [ ! -z $PLOTTER ]; then
  while :; do
    chmod 777 /plots -R
    COUNT=$((COUNT + 1))

    if [[ $TOTAL_PLOTS != "" ]]; then #If user has set TOTAL_PLOTS
      if [[ $COUNT > $TOTAL_PLOTS ]]; then
        echo "Plotting order is complete! Found $COUNT / $TOTAL_PLOTS requested. Please kill this deployment or update TOTAL_PLOTS"
        exit
      else
        echo "Plotting order found $COUNT / $TOTAL_PLOTS requested."
      fi
    fi

    if [[ $JSON_SERVER != "" && $TOTAL_PLOTS != "" ]]; then
      CHECK_PLOTS=$(curl --retry-all-errors --retry 5 --head "$JSON_SERVER?_page=1&_limit=1" | grep Total-Count | head -n1 | cut -d":" -f2- | cut -d" " -f2-)
      echo "Found $CHECK_PLOTS total plots"
      if [[ $CHECK_PLOTS > $TOTAL_PLOTS ]]; then
        echo "Plotting order is complete! Found $CHECK_PLOTS / $TOTAL_PLOTS requested on $JSON_SERVER. Please kill this deployment or update TOTAL_PLOTS"
        exit
      else
        echo "Plotting order found $CHECK_PLOTS / $TOTAL_PLOTS requested on $JSON_SERVER."
      fi
    fi

    if [[ "$FINAL_LOCATION" != "local" ]]; then

      #      if [[ $RCLONE == "true" ]]; then
      #				#go run /transfer.sh/main.go --provider gdrive --basedir /plots/ --gdrive-client-json-filepath /gdrive.json --gdrive-local-config-path /gdrive_config
      #			nohup rclone --log-file=plots.log --progress --drive-chunk-size 512M move /plots/*.plot google:/rclone/ >> plots.log
      #			fi
      if [[ "$UPLOAD_BACKGROUND" == "false" && $RCLONE == "false" ]]; then
        sshpass -e rsync -av --remove-source-files --progress /plots/*.plot -e "ssh -p ${REMOTE_PORT}" "${REMOTE_USER}"@"${REMOTE_HOST}":"${FINAL_LOCATION}"
      fi
      if [[ "$UPLOAD_BACKGROUND" == "false" && $RCLONE == "true" ]]; then
        #rclone --rc-web-gui --progress --rc-web-gui-update --buffer-size=64M --drive-chunk-size 256M --dropbox-chunk-size 256M move /plots/*.plot $ENDPOINT_LOCATION:/$ENDPOINT_DIR
        rclone --no-check-dest --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --drive-chunk-size 256M --progress move /plots/*.plot $ENDPOINT_LOCATION:/$ENDPOINT_DIR
      fi
      #			Invoke-Expression "$PSScriptRoot\$rclone_version\rclone.exe move $k adriancardo10_${n}:JM_1 --config=$PSScriptRoot\$rclone_version\rclone_dropbox.conf -P --dropbox-chunk-size=150M --drive-chunk-size 150M --transfers 1 --fast-list --tpslimit 1 --bwlimit 1000000000000000000000000000"

      if [[ ${PLOTTER} == "madmax" ]]; then
        chia plotters madmax -k $SIZE -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -d $FINALDIR -u $BUCKETS
      elif [[ ${PLOTTER} == "bladebit" ]]; then
        chia plotters bladebit -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -d $FINALDIR
      elif [[ ${PLOTTER} == "madmax-ramdrive" ]]; then
        chia plotters madmax -k $SIZE -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 /mnt/ram/ -d $FINALDIR -u $BUCKETS
      elif [[ ${PLOTTER} == "bladebit-disk" ]]; then
        bladebit -t $CPU_UNITS -f $FARMERKEY -c $CONTRACT diskplot -b 64 -t1 $TMPDIR --cache $RAMCACHE -a $FINALDIR

        #                      You need about 192GiB(+|-) for high-frequency I/O Phase 1 calculations
        #                      to be completely in-memory.
        #				bladebit -t $CPU_UNITS -f $FARMERKEY -c $CONTRACT diskplot --b 128 --cache $RAMCACHE -t1 $TMPDIR --f1-threads 3 --fp-threads 16 --c-threads 8 --p2-threads 12 --p3-threads 8 $FINALDIR
        #chia plotters bladebit -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY diskplot --cache $RAMCACHE -d $FINALDIR

        #chia plotters bladebit -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -d $FINALDIR
      else
        chia plotters madmax -k $SIZE -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -d $FINALDIR -u $BUCKETS
      fi

    else

      if [[ ${PLOTTER} == "madmax" ]]; then
        chia plotters madmax -k $SIZE -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -d $FINALDIR -u $BUCKETS
      elif [[ ${PLOTTER} == "bladebit" ]]; then
        chia plotters bladebit -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -d $FINALDIR
      elif [[ ${PLOTTER} == "bladebit-disk" ]]; then
        bladebit -t $CPU_UNITS -f $FARMERKEY -c $CONTRACT diskplot -b 64 -t1 $TMPDIR --cache $RAMCACHE -a $FINALDIR
      else
        chia plotters madmax -k $SIZE -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -d $FINALDIR -u $BUCKETS
      fi

    fi

    STORAGE_CURRENT=$(du -sh --apparent-size --block-size=1 /plots | awk '{print $1/1024/1024/1024}') #Checks plots folder size and returns in GB
    echo "Currently using ${STORAGE_CURRENT}Gi of total allocatable ${STORAGE_MAX}Gi"
    sleep 15
    until (($(ls -la /plots/*.plot | wc -l) < $STORAGE_PLOTS)); do
      echo "Deployment is full, please download and delete plots to make room for plotting! Sleeping for 10 seconds before checking for free space."
      sleep 10
    done

  done

fi
