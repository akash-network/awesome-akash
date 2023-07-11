#!/usr/bin/env bash

mkdir -p -m0755 /run/sshd
mkdir -m700 ~/.ssh
echo "$SSH_PUBKEY" | tee ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
ls -lad ~ ~/.ssh ~/.ssh/authorized_keys
md5sum ~/.ssh/authorized_keys
exec /usr/sbin/sshd -D &

su - user -c "/home/user/actions-runner/config.sh --url ${RUNNER_GH_REPO} --token ${RUNNER_GH_TOKEN} --unattended --replace --name ${RUNNER_NAME:-ghrunner} --labels ${RUNNER_LABELS:-ghrunner}"
su - user -c "/home/user/actions-runner/run.sh" &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
