#!/bin/bash
cat <<EOT > /root/.neoxa/neoxa.conf
rpcuser=user1
rpcpassword=pass1
onlynet=ipv4
#blocknotify=/root/.neoxa/blocknotify neoxa:17117 neoxamainnet %s
#zmqpubhashblock=tcp://127.0.0.1:15101
rpcbind=0.0.0.0
server=1
listen=1
rpcallowip=::/0
addnode=51.38.81.19:8788
addnode=195.201.119.131:8788
addnode=165.227.137.52:8788
addnode=174.138.40.128:8788
addnode=188.166.236.242:8788
addnode=181.117.193.147:8788
addnode=207.154.203.174:8788
addnode=51.254.241.251:8788
addnode=95.216.145.191:8788
addnode=37.187.24.194:8788
addnode=82.0.135.187:8788
addnode=5.196.50.2:8788
EOT

/neoxad -daemon
sleep 5
/neoxa-cli importprivkey $PRIVATE_KEY
tail -f /root/.neoxa/debug.log -n1000
