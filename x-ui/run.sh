#!/bin/bash
if [ -n "$DB" ]; then
mkdir -p /etc/x-ui/
wget -O /etc/x-ui/x-ui.db $DB
fi
if [ -n "$ARG" ]; then
./x-ui setting $ARG
fi
./x-ui run
