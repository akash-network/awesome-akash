#!/bin/sh
if [ -z "$CJDNS_IPV4" ] 
then 
echo Public IP is empty! Set socket "CJDNS_IPV4" in SDL and update deployment!
tail -f /dev/null
fi
wget -O ./cjdns.sh https://pkt.cash/special/cjdns/cjdns.sh ; chmod +x ./cjdns.sh
./cjdns.sh exec
