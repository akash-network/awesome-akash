#! /usr/bin/env bash
export TERM=linux
set -eu
exec ./serverbench.sh --logfile /var/log/my-application.log
tail --pid $$ -F /var/log/my-application.log &
echo "All Tests Complete - sleeping for 15 minutes before restarting the test."
sleep 900
