#!/bin/bash
echo "Sleeping 15 seconds for startup of DB"
sleep 15

sed -i 's/WALLET/"'"$WALLET"'"/g' /config.json
sed -i 's/FEE/"'"${FEE_WALLET}"'"/g' /config.json
sed -i 's/AMOUNT/'${FEE_AMOUNT}'/g' /config.json
sed -i 's/POSTGRES/"'"${POSTGRES_PASSWORD}"'"/g' /config.json
sed -i 's/HOST/"'"${DAEMON_HOST}"'"/g' /config.json

cat /config.json


dotnet /miningcore/build/Miningcore.dll -c /config.json
