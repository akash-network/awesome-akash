#!/bin/bash

cat <<EOT > /root/.atanapicore/atanapi.conf
rpcuser=user1
rpcpassword=pass1
onlynet=ipv4
zmqpubhashblock=tcp://atanapi:15101

rpcport=2982
rpcbind=0.0.0.0
rpcallowip=0.0.0.0/0

listen=1
server=1
daemon=1

addnode=104.219.214.246:30002
addnode=124.79.31.93:30002
addnode=144.91.123.186:30002
addnode=176.49.110.196:30002
addnode=178.128.54.75:30002
addnode=35.238.164.153:30002
addnode=82.65.198.148:30002
addnode=89.235.202.57:30002
addnode=161.35.60.68:30002
addnode=176.49.110.196:30002
addnode=178.128.54.75
addnode=35.238.164.153
addnode=65.109.52.145:30002
addnode=180.244.161.147
addnode=180.244.161.197
addnode=180.244.164.82
addnode=180.244.165.32
addnode=180.244.166.169
addnode=180.244.167.154
addnode=185.153.45.177
addnode=218.87.194.45
addnode=223.84.182.132
addnode=35.238.164.153
addnode=176.33.67.91
addnode=194.230.160.86
addnode=74.143.11.50
addnode=81.133.36.219
addnode=83.202.14.211
addnode=84.211.70.63
addnode=86.122.171.203
addnode=86.57.193.186
addnode=92.223.85.66
addnode=94.25.171.82
addnode=94.50.250.76
EOT


/atanapid
sleep 5
/atanapi-cli importprivkey $PRIVATE_KEY
tail -f /root/.atanapicore/debug.log -n1000
