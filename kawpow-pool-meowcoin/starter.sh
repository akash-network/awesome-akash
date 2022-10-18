#!/bin/bash

cat <<EOT > /root/.meowcoin/meowcoin.conf
rpcuser=user1
rpcpassword=pass1
onlynet=ipv4
#blocknotify=/root/.meowcoin/blocknotify meowcoin:17117 meowcoin %s
#zmqpubhashblock=tcp://127.0.0.1:15101
rpcbind=0.0.0.0
server=1
listen=1
rpcallowip=::/0
EOT

/meowcoind -daemon
sleep 5
/meowcoin-cli importprivkey $PRIVATE_KEY
tail -f /root/.meowcoin/debug.log -n1000
