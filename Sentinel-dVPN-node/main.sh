#!/bin/bash
if [[ -z $LISTEN_PORT ]] || [[ -z $REMOTE_PORT ]] ; then echo CHECK YOUR LISTEN_PORT AND REMOTE_PORT IN DEPLOY.YML ! ; echo For example: "LISTEN_PORT=3333" "REMOTE_PORT=8585" ; sleep infinity ; fi
if [[ -z $IPV4_ADDRESS ]] ; then echo CHECK YOUR IPV4 ADDRESS IN DEPLOY.YML ! ; echo For example: "IPV4_ADDRESS=XXX.XXX.XXX.XXX" ; sleep infinity ;fi
sentinelnode config init && sentinelnode v2ray config init
(echo ;echo ;echo ;echo ;echo ;echo ;echo )| openssl req -new -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 -x509 -sha256 -days 365 -nodes -out ${HOME}/tls.crt -keyout ${HOME}/tls.key
if [[ -n $GAS_ADJUSTMENT ]] ; then sed -i.bak -e "s|^gas_adjustment *=.*|gas_adjustment = $GAS_ADJUSTMENT|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $GAS ]] ; then sed -i.bak -e "s|^gas *=.*|gas = $GAS|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $GAS_PRICES ]] ; then sed -i.bak -e "s|^gas_prices *=.*|gas_prices = \"$GAS_PRICES\"|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $CHAIN ]] ; then sed -i.bak -e "s|^id *=.*|id = \"$CHAIN\"|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $RPC_ADDRESS ]] ; then sed -i.bak -e "s|^rpc_address *=.*|rpc_address = \"$RPC_ADDRESS\"|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $SIMULATE_AND_EXECUTE ]] ; then sed -i.bak -e "s|^simulate_and_execute *=.*|simulate_and_execute = $SIMULATE_AND_EXECUTE|;" /root/.sentinelnode/config.toml ; fi
if [[ -z $HANDSHAKE ]] ; then HANDSHAKE=false && sed -i.bak -e "s|^enable *=.*|enable = \"$HANDSHAKE\"|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $PEERS ]] ; then sed -i.bak -e "s|^peers *=.*|peers = $PEERS|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $BACKEND ]] ; then sed -i.bak -e "s/^backend *=.*/backend = \"$BACKEND\"/;" /root/.sentinelnode/config.toml ; else sed -i.bak -e "s/^backend *=.*/backend = \"test\"/;" /root/.sentinelnode/config.toml ; fi
if [[ -n $WALLET_NAME ]] ; then sed -i.bak -e "s/^from *=.*/from = \"$WALLET_NAME\"/;" /root/.sentinelnode/config.toml; else sed -i.bak -e "s/^from *=.*/from = \"wallet\"/;" /root/.sentinelnode/config.toml ; fi
if [[ -n $INTERVAL_SET_SESSIONS ]] ; then sed -i.bak -e "s|^interval_set_sessions *=.*|interval_set_sessions = \"$INTERVAL_SET_SESSIONS\"|;" /root/.sentinelnode/config.toml ;fi
if [[ -n $INTERVAL_UPDATE_SESSIONS ]] ; then sed -i.bak -e "s|^interval_update_sessions *=.*|interval_update_sessions = \"$INTERVAL_UPDATE_SESSIONS\"|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $INTERVAL_UPDATE_STATUS ]] ; then sed -i.bak -e "s|^interval_update_status *=.*|interval_update_status = \"$INTERVAL_UPDATE_STATUS\"|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $REMOTE_PORT ]] ; then sed -i.bak -e "s|^listen_on *=.*|listen_on = \"0.0.0.0:$REMOTE_PORT\"|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $MONIKER ]] ; then sed -i.bak -e "s/^moniker *=.*/moniker = \"$MONIKER\"/;" /root/.sentinelnode/config.toml ; fi
if [[ -n $IPV4_ADDRESS ]] ; then sed -i.bak -e "s|^ipv4_address *=.*|ipv4_address = \"$IPV4_ADDRESS\"|;" /root/.sentinelnode/config.toml ; fi
REMOTE_URL="$IPV4_ADDRESS:$REMOTE_PORT" 
sed -i.bak -e "s|^remote_url *=.*|remote_url = \"https://$REMOTE_URL\"|;" /root/.sentinelnode/config.toml
if [[ -n $TYPE ]] ; then sed -i.bak -e "s|^type *=.*|type = \"$TYPE\"|;" /root/.sentinelnode/config.toml ; else sed -i.bak -e "s/^type *=.*/type = \"v2ray\"/;" /root/.sentinelnode/config.toml ; fi
if [[ -n $LISTEN_PORT ]] ; then sed -i.bak -e "s|^listen_port *=.*|listen_port = \"$LISTEN_PORT\"|;" /root/.sentinelnode/v2ray.toml ; fi
if [[ -n $TRANSPORT ]] ; then sed -i.bak -e "s|^transport *=.*|transport = \"$TRANSPORT\"|;" /root/.sentinelnode/v2ray.toml ; fi
if [[ -n $GIGABYTE_PRICES ]] ; then sed -i.bak -e "s|^gigabyte_prices *=.*|gigabyte_prices = \"$GIGABYTE_PRICES\"|;" /root/.sentinelnode/config.toml ; fi
if [[ -n $HOURLY_PRICES ]] ; then sed -i.bak -e "s|^hourly_prices *=.*|hourly_prices = \"$HOURLY_PRICES\"|;" /root/.sentinelnode/config.toml ; fi
(echo `echo $MNEMONIC_BASE64 | base64 -d`)|sentinelnode keys add --recover
mv ${HOME}/tls.crt ${HOME}/.sentinelnode/tls.crt && mv ${HOME}/tls.key ${HOME}/.sentinelnode/tls.key
PATH=$PATH:/root/v2ray
sentinelnode start
sleep infinity
