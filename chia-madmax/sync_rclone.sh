#!/usr/bin/env bash

echo "Check this every 15 seconds"
rm /plots/finished.log
rm /plots/uploading.log
rm /plots/failed.log
#Run once to test upload

for (( ; ; )); do
  curl -s --connect-timeout 5 --retry 99 --retry-all-errors --retry-delay 5 $JSON_SERVER > api_plots.log
  files=$(ls -la /plots/*.plot | awk '{print $9}')
  count=$(ls -la /plots/*.plot | wc -l)

  echo "Found $count files to sync"
  echo "Upload max $TOTAL_UPLOADS"
  pending=$(cat /plots/pending.log)

  for i in $files; do

    result=$(cat api_plots.log | jq -r '.[] | select(.filename == "'"$i"'").filename')

    if grep -q $i /plots/pending.log; then
      echo "Skipping $i - alreading uploading!"
    elif [[ $result != "" ]]; then
      echo "API-Skipping $i - alreading uploading!"
    else

      if (("$(ps -aux | grep move | grep -v grep | wc -l)" >= "$TOTAL_UPLOADS")); then
        echo "Count is too high...waiting for uploads to complete"
      elif [[ $RCLONE_EXTRA != "" ]]; then
        nohup rclone --progress $RCLONE_EXTRA move $i $ENDPOINT_LOCATION:/$ENDPOINT_DIR >>$i.log 2>&1 &
      elif [[ $ALPHA == true ]]; then
        #DIRS=(JM_1 JM_2 JM_3 JM_4 JM_5)
        DIRS=(AKASH_1 AKASH_2 AKASH_3 AKASH_4 AKASH_5 AKASH_6 AKASH_7 AKASH_8 AKASH_9 AKASH_10 AKASH_11 AKASH_12 AKASH_13 AKASH_14 AKASH_15 AKASH_16 AKASH_17 AKASH_18 AKASH_19 AKASH_20)
        ENDPOINT_DIR=$(shuf -n1 -e "${DIRS[@]}")
        ENDPOINT_LOCATION=$(cat /root/.config/rclone/rclone.conf | grep "_crypt" | grep "\[" | sort | uniq | shuf | tail -n1 | sed 's/[][]//g')
        nohup rclone --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --progress move $i $ENDPOINT_LOCATION:$ENDPOINT_DIR >>$i.log 2>&1 &
        #nohup rclone --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 -P --transfers=1 --fast-list --tpslimit=1 --bwlimit 100000000000000000000000 --dropbox-chunk-size=150M move $i $ENDPOINT_LOCATION:$ENDPOINT_DIR >>$i.log 2>&1 &
        echo $i >>/plots/pending.log
        START_TIME=$(date +%s)
        curl -s --connect-timeout 5 --retry 99 --retry-all-errors --retry-delay 5 -d "filename=$i" -d "endpoint_location=$ENDPOINT_LOCATION" -d "endpoint_directory=$ENDPOINT_DIR" -d "start_time=$START_TIME" -d "provider=$AKASH_CLUSTER_PUBLIC_HOSTNAME" -X POST $JSON_SERVER >>$i.log
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
          curl --connect-timeout 2 --retry 99 --retry-delay 2 -d "filename=$i" -d "endpoint_location=$ENDPOINT_LOCATION" -d "endpoint_directory=$ENDPOINT_DIR" -d "start_time=$START_TIME" -d "provider=$AKASH_CLUSTER_PUBLIC_HOSTNAME" -X POST $JSON_SERVER >>$i.log
        fi
      fi

    fi

  done

  if [[ $ALPHA == true ]]; then
  for i in $pending; do
    sleep 5
    FINISHED=100
    progress=$(cat $i.log | grep -o -P '(?<=GiB, ).*(?=%,)' | tail -n1)
    speed=$(cat $i.log | grep -o -P '(?<=%, ).*(?= ETA)' | tail -n1 | sed 's/.$//')
    #id=$(cat $i.log | grep id\" | awk '{print $2}')
    #id=$(curl --retry-all-errors -X GET $JSON_SERVER?filename=$i | jq .[].id)
    id=$(cat api_plots.log | jq -r '.[] | select(.filename == "'"$i"'").id')
    START=$(cat api_plots.log | jq -r '.[] | select(.filename == "'"$i"'").start_time')
    END=$(date +%s)
    TOTAL_TIME=$(echo $((END-START)) | awk '{print int($1/60)" minutes"}')

    if [[ $progress != "" && $id != "" ]]; then

      if (( $(bc <<<"$progress == $FINISHED") )); then
        echo "Finished Upload, now checking status on API"
        result=$(cat api_plots.log | jq -r '.[] | select(.filename == "'"$i"'").progress')

        if [[ $result != "upload_complete" && $progress == "100" ]]; then
        END=$(date +%s)
        curl --connect-timeout 5 --retry 99 --retry-all-errors --retry-delay 5 -d "progress=upload_complete" -d "finish_time=$END" -X PATCH $JSON_SERVER/$id
        rm $i.log
        sed -i "s|$i||g" /plots/pending.log
        sed -i '/^$/d;s/[[:blank:]]//g' /plots/pending.log
        fi

      else
        curl --connect-timeout 5 --retry 99 --retry-all-errors --retry-delay 5 -d "total_time=$TOTAL_TIME" -d "progress=$progress" -d "speed=$speed" -X PATCH $JSON_SERVER/$id
      fi

    else
       echo "No progress or id"
       result=$(cat api_plots.log | jq -r '.[] | select(.filename == "'"$i"'").progress')
       if [[ $result != "Possible error detected in logs" ]]; then
       echo "Updating the API with the error"
       #error=$(cat $i.log | grep ERROR | head -n1)
       error="ERROR"
       curl --connect-timeout 5 --retry 99 --retry-all-errors --retry-delay 5 -d "error=$error" -X PATCH $JSON_SERVER/$id
       fi
    fi
  done
  fi

done
