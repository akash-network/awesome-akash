#!/usr/bin/env bash
export SSHPASS=${REMOTE_PASS}
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
			nohup sshpass -e rsync -av --remove-source-files --progress $i -e "ssh -p ${REMOTE_PORT}" "${REMOTE_USER}"@"${REMOTE_HOST}":"${REMOTE_LOCATION}" >>/plots/rsync.log 2>&1 &
			echo $i >>/plots/pending.log
		fi

	done

	sleep 15
done
