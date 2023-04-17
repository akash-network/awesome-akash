#!/bin/bash
ps -aux | grep rclone | grep .plot | awk '{print $24}' > uploading_now.log
for i in $(ls -la ./plots/*.plot | awk '{print $9}' | cut -c 2-); do
#for i in $(cat ./plots/pending.log); do
if grep -q $i ./uploading_now.log; then
echo "Skipping - uploading already"
continue
fi
#if for i in $(cat ./uploading_now.log); do
#for i in $(cat ./plots/pending.log); do

#echo "skip"
#continue
#done
#id=$(cat $i.log | grep id\" | awk '{print $2}')
echo "Testing for plots that were in progress"
echo $i
#curl --connect-timeout 3 --retry 300 --retry-delay 3 -X GET $JSON_SERVER?filename=$i
#sleep 2
id=$(curl -s --retry-all-errors --connect-timeout 3 --retry 300 --retry-delay 3 -X GET $JSON_SERVER?filename=$i | jq .[].id)
sleep 1
progress=$(curl -s --retry-all-errors --connect-timeout 3 --retry 300 --retry-delay 3 -X GET $JSON_SERVER?filename=$i | jq -r .[].progress)
echo $id
echo $progress
if [[ -z $id ]]; then
echo "No ID found"
sed -i 's|'$i'|\n|g' /plots/pending.log
sed -i '/^$/d;s/[[:blank:]]//g' /plots/pending.log

#        DIRS=(NEWDEMONIC_1 NEWDEMONIC_2 NEWDEMONIC_3 NEWDEMONIC_4 NEWDEMONIC_5 NEWDEMONIC_6 NEWDEMONIC_7 NEWDEMONIC_8 NEWDEMONIC_9 NEWDEMONIC_10 NEWDEMONIC_11 NEWDEMONIC_12 NEWDEMONIC_13 NEWDEMONIC_14 NEWDEMONIC_15 NEWDEMONIC_16 NEWDEMONIC_17 NEWDEMONIC_18 NEWDEMONIC_19 NEWDEMONIC_20)
#        ENDPOINT_DIR=$(shuf -n1 -e "${DIRS[@]}")
#        ENDPOINT_LOCATION=$(cat /root/.config/rclone/rclone.conf | grep "\[" | sort | uniq | shuf | tail -n1 | sed 's/[][]//g')
#        nohup rclone --contimeout 60s --timeout 300s --low-level-retries 10 --retries 99 --dropbox-chunk-size 150M --progress move $i $ENDPOINT_LOCATION:$ENDPOINT_DIR >>$i.log 2>&1 &
#        START_TIME=$(date +%s)
#        curl --retry-all-errors --connect-timeout 3 --retry 300 --retry-delay 3 -d "filename=$i" -d "endpoint_location=$ENDPOINT_LOCATION" -d "endpoint_directory=$ENDPOINT_DIR" -d "start_time=$START_TIME" -d "provider=$AKASH_CLUSTER_PUBLIC_HOSTNAME" -X POST $JSON_SERVER >>$i.log
#        echo $i >>/plots/pending.log
else
echo "ID FOUND!"

fi

#curl --connect-timeout 3 --retry 300 --retry-delay 3 -X GET $JSON_SERVER/$id
#?filename=$i
done
