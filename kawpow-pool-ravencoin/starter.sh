#!/bin/bash

cat <<EOT > /root/.raven/raven.conf
rpcuser=user1
rpcpassword=pass1
onlynet=ipv4
#blocknotify=/root/.raven/blocknotify ravencoin:17117 ravencoin %s
#zmqpubhashblock=tcp://127.0.0.1:15101
rpcbind=0.0.0.0
server=1
listen=1
rpcallowip=::/0
EOT


/ravend -daemon
sleep 5
/raven-cli importprivkey $PRIVATE_KEY
#/neoxa-cli importprivkey $PRIVATE_KEY
tail -f /root/.raven/debug.log -n1000


#/raven-4.6.1-7864c39c2/bin/ravend
