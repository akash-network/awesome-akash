#!/bin/bash
mkdir -p /root/.raptoreumcore

cd /root/.raptoreumcore/
wget https://bootstrap.raptoreum.com/bootstraps_for_v1.3.17.00/bootstrap.zip
ls -la
unzip bootstrap.zip
rm -f bootstrap.zip


cat <<EOT > /root/.raptoreumcore/raptoreum.conf
rpcuser=user1
rpcpassword=pass1
zmqpubhashblock=tcp://raptoreum:15101

rpcport=2982
rpcbind=0.0.0.0
rpcallowip=0.0.0.0/0

onlynet=ipv4


listen=1
server=1
daemon=1

rpcworkqueue=1024
rpcthreads=36
maxconnections=100
banscore=1



addnode=209.151.150.72
addnode=66.165.237.58:10226
addnode=94.237.79.27
addnode=185.190.143.3:10226
addnode=95.111.216.12
addnode=198.100.149.124
addnode=198.100.146.111
addnode=66.94.114.91:10226
addnode=5.135.187.46
addnode=144.126.128.185:10226
addnode=5.135.179.95
addnode=91.185.215.203:10226
addnode=139.59.7.178
addnode=185.209.229.135:10226
addnode=104.248.207.174:10226
addnode=95.216.226.48:50418
addnode=184.175.157.147:45158
addnode=184.175.157.147:53368
addnode=184.175.157.147:45188
addnode=198.248.189.20:4347
addnode=184.175.157.147:46684
addnode=51.75.147.1:10226
addnode=184.175.157.147:57382
addnode=45.134.109.2:49636
addnode=107.15.150.45:53447
addnode=91.122.105.234:36430
addnode=45.134.109.2:38728
addnode=45.134.109.2:36894
addnode=31.202.81.212:64516
addnode=84.18.96.172:36171
addnode=184.175.157.150:56140
addnode=184.175.157.147:48164
addnode=91.188.254.218:36062
addnode=184.175.157.149:49900
addnode=184.175.157.149:51184
addnode=78.29.36.246:63009
addnode=209.50.63.80:45904
addnode=95.55.114.86:61328
addnode=184.175.157.147:40734
addnode=109.81.215.95:19455
addnode=184.175.157.149:48530
addnode=184.175.157.147:34894
addnode=184.175.157.149:54726
addnode=47.26.108.34:51777
addnode=98.115.4.151:54804
addnode=180.217.195.223:30656
addnode=45.134.109.2:60700
addnode=190.2.96.224:48363
addnode=207.244.237.53:58940
addnode=95.78.208.79:1270
addnode=185.3.33.197:9522
addnode=103.151.76.46:50162
addnode=107.185.155.133:62691
addnode=184.175.157.146:43758
addnode=222.228.42.205:50783
addnode=90.178.241.213:52767
addnode=108.46.229.118:54900
addnode=79.184.108.122:56290
addnode=178.60.252.83:54930
addnode=45.134.109.2:42930
addnode=186.139.122.218:50089
addnode=82.159.177.68:61010
addnode=91.175.80.175:4847
addnode=202.166.183.89:57570
addnode=212.92.233.83:51877

EOT


/raptoreumd -conf=/root/.raptoreumcore/raptoreum.conf
sleep 5
/raptoreum-cli importprivkey $PRIVATE_KEY
tail -f /root/.raptoreumcore/debug.log -n1000
