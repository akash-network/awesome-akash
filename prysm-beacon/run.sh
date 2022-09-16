#!/bin/bash
echo "Get latest version of prysm"
#curl https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh --output /prysm.sh && chmod +x /prysm.sh

env CUSTOM_COMMAND=$CUSTOM_COMMAND
env JWT_SECRET=$JWT_SECRET

if [[ $JWT_SECRET != "" ]]; then
echo $JWT_SECRET > /jwt.hex
#echo "Showing secret for 3 seconds"
#cat /root/.ethereum/jwt.hex
#sleep 3
else
openssl rand -hex 32 | tr -d "\n" > "/jwt.hex"
#echo "Showing secret for 15 seconds"
#cat /root/.ethereum/jwt.hex
#sleep 15
fi

#echo "Auth ready"


if [[ $CUSTOM_COMMAND != "" ]]; then
$CUSTOM_COMMAND
else
./prysm.sh beacon-chain --accept-terms-of-use --rpc-host=0.0.0.0 --monitoring-host=0.0.0.0 --jwt-secret=/jwt.hex --suggested-fee-recipient=0x4CFbc699d3bEabC5aAE488F30418ee1BE26aD09B
fi

#./prysm.sh beacon-chain generate-auth-secret
