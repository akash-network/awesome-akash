#!/usr/bin/env bash

echo "Check this every 15 seconds"
rm /plots/finished.log
rm /plots/uploading.log
rm /plots/failed.log
#Run once to test upload

for (( ; ; )); do

  files=$(ls -la /plots/*.plot | awk '{print $9}')
  count=$(ls -la /plots/*.plot | wc -l)

  echo "Found $count files to sync"
  echo "Upload max $TOTAL_UPLOADS"
  pending=$(cat /plots/pending.log)

  for i in $files; do

    if grep -q $i /plots/pending.log; then
      echo "Skipping $i - alreading uploading!"
    else

      if (("$(ps -aux | grep move | grep -v grep | wc -l)" >= "$TOTAL_UPLOADS")); then
        echo "Count is too high...waiting for uploads to complete"
      elif [[ $RCLONE_EXTRA != "" ]]; then
        nohup rclone --progress $RCLONE_EXTRA move $i $ENDPOINT_LOCATION:/$ENDPOINT_DIR >>$i.log 2>&1 &
      elif [[ $ALPHA == true ]]; then
        #DIRS=(JM_1 JM_2 JM_3 JM_4 JM_5)
        DIRS=(NEWDEMONIC_11 NEWDEMONIC_12 NEWDEMONIC_13 NEWDEMONIC_14 NEWDEMONIC_15 NEWDEMONIC_16 NEWDEMONIC_17 NEWDEMONIC_18 NEWDEMONIC_19 NEWDEMONIC_20)
        ENDPOINT_DIR=$(shuf -n1 -e "${DIRS[@]}")
        ENDPOINT_LOCATION=$(cat /root/.config/rclone/rclone.conf | grep "\[" | sort | uniq | shuf | tail -n1 | sed 's/[][]//g')
        nohup rclone --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --progress move $i $ENDPOINT_LOCATION:$ENDPOINT_DIR >>$i.log 2>&1 &
        START_TIME=$(date +%s)
        curl --retry-all-errors --retry 5 -d "filename=$i" -d "endpoint_location=$ENDPOINT_LOCATION" -d "endpoint_directory=$ENDPOINT_DIR" -d "start_time=$START_TIME" -d "provider=$AKASH_CLUSTER_PUBLIC_HOSTNAME" -X POST $JSON_SERVER >>$i.log
      elif [[ $SHUFFLE_RCLONE_ENDPOINT == true ]]; then
        #Uses same directory name
        ENDPOINT_LOCATION=$(cat /root/.config/rclone/rclone.conf | grep "\[" | sort | uniq | shuf | tail -n1 | sed 's/[][]//g')

          if [[ $SHUFFLE_RCLONE_IMPERSONATE == true ]]; then
          #IMPERSONATE=(gdrive1@resolver.io gdrive2@resolver.io gdrive3@resolver.io gdrive4@resolver.io)
          ENDPOINT_IMPERSONATE=$(shuf -n1 -e "${IMPERSONATE[@]}")
          nohup rclone --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --progress --drive-chunk-size 512M --fast-list --tpslimit 5 --drive-pacer-min-sleep 5ms --drive-pacer-burst 2000 --drive-impersonate $ENDPOINT_IMPERSONATE move $i $ENDPOINT_LOCATION:$ENDPOINT_DIR >>$i.log 2>&1 &
          else
          nohup rclone --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --progress --drive-impersonate $IMPERSONATE move $i $ENDPOINT_LOCATION:$ENDPOINT_DIR >>$i.log 2>&1 &
          fi

        echo $i >>/plots/pending.log
          sleep 5
 #        nohup rclone --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --progress move $i $ENDPOINT_LOCATION:$ENDPOINT_DIR >>$i.log 2>&1 &
      elif [[ $SHUFFLE_RCLONE_DIR == true ]]; then
        ENDPOINT_DIR="plotz-1 plotz-2 plotz-3 plotz-4 plotz-5"
        DIRS=($ENDPOINT_DIR)
        ENDPOINT_DIR=$(shuf -n1 -e "${DIRS[@]}")
        nohup rclone --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --progress move $i $ENDPOINT_LOCATION:$ENDPOINT_DIR >>$i.log 2>&1 &
      else
        nohup rclone --retries 99 --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --drive-chunk-size 256M --progress move $i $ENDPOINT_LOCATION:/$ENDPOINT_DIR >>$i.log 2>&1 &
        START_TIME=$(date +%s)
        if [[ $JSON_SERVER != "" ]]; then
          curl --retry-all-errors --retry 5 -d "filename=$i" -d "endpoint_location=$ENDPOINT_LOCATION" -d "endpoint_directory=$ENDPOINT_DIR" -d "start_time=$START_TIME" -d "provider=$AKASH_CLUSTER_PUBLIC_HOSTNAME" -X POST $JSON_SERVER >>$i.log
        fi
      fi

    fi

  done

  sleep 15
  if [[ $ALPHA == true ]]; then
  for i in $pending; do
    progress=$(cat $i.log | grep -o -P '(?<=GiB, ).*(?=%,)' | tail -n1)
    speed=$(cat $i.log | grep -o -P '(?<=%, ).*(?= ETA)' | tail -n1 | sed 's/.$//')
    id=$(cat $i.log | grep id\" | awk '{print $2}')
    #id=$(curl -X GET $JSON_SERVER?filename=$i | jq .[].id)
    if [[ $JSON_SERVER != "" && $id != "" ]]; then
      curl --connect-timeout 3 --retry 10 --retry-delay 3 -d "filename=$i" -d "progress=$progress" -d "speed=$speed" -X PATCH $JSON_SERVER/$id
    fi
  done
  fi

done
