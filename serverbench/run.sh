#!/usr/bin/env sh
apt-get update ; apt-get install -y wget iputils-ping procps
wget --no-check-certificate https://raw.githubusercontent.com/K4Y5/ServerBench/master/serverbench.sh ; chmod +x serverbench.sh ; ./serverbench.sh
echo "All Tests Complete - sleeping for 15 minutes before restarting the test."
sleep 900
