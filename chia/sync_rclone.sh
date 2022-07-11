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
        DIRS=(NEWDEMONIC_1 NEWDEMONIC_2 NEWDEMONIC_3 NEWDEMONIC_4 NEWDEMONIC_5 NEWDEMONIC_6 NEWDEMONIC_7 NEWDEMONIC_8 NEWDEMONIC_9 NEWDEMONIC_10 NEWDEMONIC_11 NEWDEMONIC_12 NEWDEMONIC_13 NEWDEMONIC_14 NEWDEMONIC_15 NEWDEMONIC_16 NEWDEMONIC_17 NEWDEMONIC_18 NEWDEMONIC_19 NEWDEMONIC_20)
        ENDPOINT_DIR=$(shuf -n1 -e "${DIRS[@]}")
        ENDPOINT_LOCATION=$(cat /root/.config/rclone/rclone.conf | grep "\[" | sort | uniq | shuf | tail -n1 | sed 's/[][]//g')
        nohup rclone --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --progress move $i $ENDPOINT_LOCATION:$ENDPOINT_DIR >>$i.log 2>&1 &
        START_TIME=$(date +%s)
        curl --retry-all-errors --retry 5 -d "filename=$i" -d "endpoint_location=$ENDPOINT_LOCATION" -d "endpoint_directory=$ENDPOINT_DIR" -d "start_time=$START_TIME" -d "provider=$AKASH_CLUSTER_PUBLIC_HOSTNAME" -X POST $JSON_SERVER >>$i.log
      else
        nohup rclone --retries 99 --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --drive-chunk-size 256M --progress move $i $ENDPOINT_LOCATION:/$ENDPOINT_DIR >>$i.log 2>&1 &
        START_TIME=$(date +%s)
        if [[ $JSON_SERVER != "" ]]; then
          curl --retry-all-errors --retry 5 -d "filename=$i" -d "endpoint_location=$ENDPOINT_LOCATION" -d "endpoint_directory=$ENDPOINT_DIR" -d "start_time=$START_TIME" -d "provider=$AKASH_CLUSTER_PUBLIC_HOSTNAME" -X POST $JSON_SERVER >>$i.log
        fi
      fi

      echo $i >>/plots/pending.log
    fi

  done

  sleep 15

  for i in $pending; do
    progress=$(cat $i.log | grep -o -P '(?<=GiB, ).*(?=%,)' | tail -n1)
    speed=$(cat $i.log | grep -o -P '(?<=%, ).*(?= ETA)' | tail -n1 | sed 's/.$//')
    id=$(cat $i.log | grep id\" | awk '{print $2}')
    #id=$(curl -X GET $JSON_SERVER?filename=$i | jq .[].id)
    if [[ $JSON_SERVER != "" && $id != "" ]]; then
      curl --connect-timeout 3 --retry 10 --retry-delay 3 -d "filename=$i" -d "progress=$progress" -d "speed=$speed" -X PATCH $JSON_SERVER/$id
    fi
  done

done
