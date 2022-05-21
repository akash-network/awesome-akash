echo "Check this every 15 seconds"
for (( ; ; )); do

	files=$(ls -la /plots/*.plot | awk '{print $9}')
	count=$(ls -la /plots/*.plot | wc -l)

	echo "Found $count files to sync"

	pending=$(cat /plots/pending.log)

	for i in $files; do

	if grep -q $i /plots/pending.log; then
		echo "Skipping $i - alreading uploading!"
	else
#		nohup rclone --progress --log-file=rclone-${i}.log --buffer-size=64M --drive-chunk-size 512M move $i google:/rclone/ 2>&1 &
#		nohup rclone --progress --log-file=/plots/rclone.log --buffer-size=64M --drive-chunk-size 512M move $i google:/rclone/ &
#		nohup rclone --progress --buffer-size=64M --drive-chunk-size 512M move $i google:/rclone/ > $i.log 2>&1 &
#works
#    nohup rclone --progress --buffer-size=64M --drive-chunk-size 512M move $i $ENDPOINT_LOCATION:/$ENDPOINT_DIR >>$i.log 2>&1 &
    if [[ $RCLONE_EXTRA != "" ]]; then
		nohup rclone --rc-web-gui --rc-web-gui-update --progress $RCLONE_EXTRA move $i $ENDPOINT_LOCATION:/$ENDPOINT_DIR >>$i.log 2>&1 &
	  else
		nohup rclone --rc-web-gui --rc-web-gui-update --progress move $i $ENDPOINT_LOCATION:/$ENDPOINT_DIR >>$i.log 2>&1 &
	  fi

		echo $i >>/plots/pending.log
	fi


	done

	sleep 15
done
