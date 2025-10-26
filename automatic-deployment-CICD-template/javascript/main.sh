#!/bin/bash

# load functions
. ./funcs.sh
. ./common.sh

# serve index.html
initial_serve

# get the repo dir name
REPO_DIR=$(basename "$REPO_URL" .git)

clone_repo
rollback_commit

npm config set loglevel silent

js_framework

npm config set loglevel notice

js_install_and_build

js_serve_app

# for disabling pull
if [ -n "$DISABLE_PULL" ]; then
  echo "[*] Latest changes will not be fetched. Pull disabled..."
  while true; do sleep 10000; done
fi

while true; do
  sleep 4
  if update_repo; then
    js_install_and_build
    kill "$SERVE_PID" &> /dev/null
    
    js_serve_app
  fi
done
