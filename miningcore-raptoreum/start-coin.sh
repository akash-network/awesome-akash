#!/bin/bash

cat <<EOT > /root/.raptoreum/raptoreum.conf
rpcuser=user1
rpcpassword=pass1
onlynet=ipv4
zmqpubhashblock=tcp://raptoreum:15101

rpcport=2982
rpcbind=0.0.0.0
rpcallowip=0.0.0.0/0

listen=1
server=1
daemon=1

EOT


/raptoreumd
sleep 5
/raptoreum-cli importprivkey $PRIVATE_KEY
tail -f /root/.atanapicore/debug.log -n1000
