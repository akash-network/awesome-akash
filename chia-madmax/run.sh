#!/bin/bash

if [[ -z "$CONTRACT" || -z "$FARMERKEY" ]]; then
  echo "CONTRACT or FARMERKEY not set - please check your settings"
  sleep 300
  exit
fi

#check api for any plots without upload_complete and subtract from total plots completed
#This will keep plotting until exact number

if [[ $RCLONE == "true" && $JSON_SERVER != "" ]]; then

CHECK_PLOTS=$(curl --retry-all-errors --head -s "$JSON_SERVER?_page=1&_limit=1" | grep X-Total-Count | awk '{print $2}' | head -n1)
CHECK_PLOTS="${CHECK_PLOTS%$'\r'}"
  if (( $(bc <<<"$CHECK_PLOTS >= $TOTAL_PLOTS") )); then
    echo "KILL"
    echo "Plotting order is complete! Found $CHECK_PLOTS / $TOTAL_PLOTS requested on $JSON_SERVER. Please kill this deployment or update TOTAL_PLOTS"
    exit
  else
    echo "Plotting order found $CHECK_PLOTS / $TOTAL_PLOTS requested on $JSON_SERVER."
  fi
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

  if [[ $PORT != "8444" && $PLOTTER == "madmax" ]]; then
  STORAGE_MIN=64
  else
  STORAGE_MIN=364 #Required for Madmax 256Gb + 1 Plot
  fi
  STORAGE_MAX=$(echo "${STORAGE_UNITS}-${STORAGE_MIN}" | bc -l)
  STORAGE_PLOTS=$(echo "${STORAGE_MAX}/${K32_SIZE}" | bc -l | awk '{print int($1+0.5)}') #Round down

  echo Found $STORAGE_UNITS Storage units
  echo Found $MEMORY_UNITS Memory units
  echo Found $STORAGE_MIN Storage min units
  echo Found $STORAGE_MAX Storage max units
  echo Found $STORAGE_PLOTS Storage plots

  if [[ $PORT != "8444" && $PLOTTER == "madmax" ]]; then
    if (($STORAGE_UNITS < 64)); then
      echo "${STORAGE_UNITS}Gi is not enough disk space to create a plot with on port : $PORT.  Please use at least 64Gi."
      sleep 300
      exit
    elif (($STORAGE_UNITS < 364)); then
        echo "${STORAGE_UNITS}Gi is not enough disk space to create a plot with.  Please use at least 364Gi."
        sleep 300
        exit
    else
        echo "You have set enough storage."
    fi
  else
    if (($STORAGE_PLOTS < 1)); then
      echo "${STORAGE_MAX}Gi is not enough storage to create a plot with.  Please use at least 364Gi."
      sleep 300
      exit
    fi
  fi

  if (($MEMORY_UNITS < 6)); then
    echo "${MEMORY_UNITS}Gi is not enough memory to create a plot with.  Please use at least 6Gi."
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
  echo "Plots will be created locally.  Please check Akash Console for the Uri - you can find this on the   "
  echo "deployment details page.  Plots will only appear after creation.  Please be patient for your first"
  echo "plots to appear.  Starting in 5 seconds.                                                          "
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  sleep 5
else
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "Plots will be uploaded to $FINAL_LOCATION on $REMOTE_HOST.                                         "
  echo "After the plot is successfully uploaded it will be deleted automatically from the deployment        "
  echo "Starting in 5 seconds.                                                                            "
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  echo "###################################################################################################"
  sleep 5
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

#Setup filemanager
mkdir /plots
chmod 777 /plots -R
cp /filemanager/tinyfilemanager.php /plots/index.php

#Setup nginx for filemanager
mv /config.php /plots/
mv /nginx.conf /etc/nginx/sites-enabled/default
mv /nginx-default.conf /etc/nginx/nginx.conf

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

if [[ $REMOTE_HOST != "" && $FINAL_LOCATION == "upload" ]]; then

  echo "Starting rsync in background and logging to rsync_log.log..."
  screen -dmS rsync bash /sync.sh
  screen -ls
  if ! screen -list | grep -q "rsync"; then
    echo "rsync is not running!"
    sleep 60
    exit
  fi
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

#Add support for custom port : https://github.com/akash-network/awesome-akash/issues/327
if [[ $PORT != "" ]]; then
PORT="-x $PORT"
fi

if [ ! -z $PLOTTER ]; then
  while :; do
    chmod 777 /plots -R
    COUNT=$((COUNT + 1))

    if [[ $TOTAL_PLOTS != "" && JSON_SERVER == "" ]]; then #If user has set TOTAL_PLOTS / count manually
    if (( $(bc <<<"$COUNT >= $TOTAL_PLOTS") )); then
        echo "Plotting order is complete! Found $COUNT / $TOTAL_PLOTS requested. Please kill this deployment or update TOTAL_PLOTS"
        echo "Last plot detected!"
        echo "Sleeping 6 hours before killing to allow uploads to finish"
        sleep $SLEEP_BEFORE_KILL
        exit
      else
        echo "Plotting order found $COUNT / $TOTAL_PLOTS requested."
      fi
    fi

    if [[ $JSON_SERVER != "" && $TOTAL_PLOTS != "" ]]; then #Count plots with server
      CHECK_PLOTS=$(curl --retry-all-errors --head -s "$JSON_SERVER?_page=1&_limit=1" | grep X-Total-Count | awk '{print $2}' | head -n1)
      CHECK_PLOTS=${CHECK_PLOTS%$'\r'}
        if (( $(bc <<<"$CHECK_PLOTS >= $TOTAL_PLOTS") )); then
          echo "KILL"
          echo "Plotting order is complete! Found $CHECK_PLOTS / $TOTAL_PLOTS requested on $JSON_SERVER. Please kill this deployment or update TOTAL_PLOTS"
          echo "Last plot detected!"
          echo "Sleeping 6 hours before killing to allow uploads to finish"
          sleep $SLEEP_BEFORE_KILL
          exit
        else
          echo "Plotting order found $CHECK_PLOTS / $TOTAL_PLOTS requested on $JSON_SERVER."
        fi
    fi

    if [[ "$FINAL_LOCATION" != "local" ]]; then

      if [[ "$UPLOAD_BACKGROUND" == "false" && $RCLONE == "false" ]]; then
        sshpass -e rsync -av --remove-source-files --progress /plots/*.plot -e "ssh -p ${REMOTE_PORT}" "${REMOTE_USER}"@"${REMOTE_HOST}":"${FINAL_LOCATION}"
      fi
      if [[ "$UPLOAD_BACKGROUND" == "false" && $RCLONE == "true" ]]; then
        #rclone --rc-web-gui --progress --rc-web-gui-update --buffer-size=64M --drive-chunk-size 256M --dropbox-chunk-size 256M move /plots/*.plot $ENDPOINT_LOCATION:/$ENDPOINT_DIR
        rclone --no-check-dest --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --drive-chunk-size 256M --progress move /plots/*.plot $ENDPOINT_LOCATION:/$ENDPOINT_DIR
      fi

      if [[ ${PLOTTER} == "madmax" ]]; then
        madmax -k $PLOT_SIZE -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -d $FINALDIR -u $BUCKETS $PORT
      elif [[ ${PLOTTER} == "madmax-ramdrive" ]]; then
        madmax -k $PLOT_SIZE -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 /mnt/ram/ -d $FINALDIR -u $BUCKETS $PORT
      elif [[ ${PLOTTER} == "bladebit" ]]; then
        bladebit -w -n $COUNT -t $CPU_UNITS -c $CONTRACT -f $FARMERKEY $FINALDIR
      elif [[ ${PLOTTER} == "bladebit-disk" ]]; then
        bladebit-disk -w -t $CPU_UNITS -f $FARMERKEY -c $CONTRACT diskplot -b $BUCKETS -t1 $TMPDIR --cache $RAMCACHE -a $FINALDIR
      else
        madmax -k $PLOT_SIZE -n $COUNT -t $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -d $FINALDIR -u $BUCKETS $PORT
      fi

    else

      if [[ ${PLOTTER} == "madmax" ]]; then
        madmax -k $PLOT_SIZE -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -d $FINALDIR -u $BUCKETS $PORT
      elif [[ ${PLOTTER} == "madmax-ramdrive" ]]; then
        madmax -k $PLOT_SIZE -n $COUNT -r $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -2 /mnt/ram/ -d $FINALDIR -u $BUCKETS $PORT
      elif [[ ${PLOTTER} == "bladebit" ]]; then
        bladebit -w -n $COUNT -t $CPU_UNITS -c $CONTRACT -f $FARMERKEY $FINALDIR
      elif [[ ${PLOTTER} == "bladebit-disk" ]]; then
        bladebit-disk -w -t $CPU_UNITS -f $FARMERKEY -c $CONTRACT diskplot -b $BUCKETS -t1 $TMPDIR --cache $RAMCACHE -a $FINALDIR
      else
        madmax -k $PLOT_SIZE -n $COUNT -t $CPU_UNITS -c $CONTRACT -f $FARMERKEY -t $TMPDIR -d $FINALDIR -u $BUCKETS $PORT
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
