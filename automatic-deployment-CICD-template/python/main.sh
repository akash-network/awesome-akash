#!/bin/bash

. ./funcs.sh
. ./common.sh

initial_serve

REPO_DIR=$(basename "$REPO_URL" .git)

clone_repo
rollback_commit

py_framework
py_install_and_build

py_serve_app

if [ -n "$DISABLE_PULL" ]; then
	echo "[*] Latest changes will not be fetched. Pull disabled..."
	while true; do sleep 10000; done
fi

while true; do
	sleep 4
	if update_repo; then
		py_install_and_build
		kill "$SERVE_PID" &>/dev/null
		py_serve_app
	fi
done
