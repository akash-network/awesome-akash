#!/bin/bash
echo "Sleeping 30 seconds for startup of DB"
sleep 30
#sed -i 's/NEOXA_ENABLE/false/g' config.json
sed -i 's/WALLET/"'"$WALLET"'"/g' /config.json
sed -i 's/FEE/"'"${FEE_WALLET}"'"/g' /config.json
sed -i 's/AMOUNT/'${FEE_AMOUNT}'/g' /config.json
sed -i 's/POSTGRES/"'"${POSTGRES_PASSWORD}"'"/g' /config.json

cat /config.json


dotnet /miningcore/build/Miningcore.dll -c /config.json
