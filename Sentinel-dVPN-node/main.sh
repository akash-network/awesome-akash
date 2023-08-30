#!/bin/bash
CONFIG_PATH="/root/.sentinelnode/config.toml"
V2RAY_CONFIG_PATH="/root/.sentinelnode/v2ray.toml"
# Function to check if a variable is set and print an error message if it's not.
check_var() {
    local var_name="$1"
    local error_message="$2"
    local example="$3"
    if [[ -z ${!var_name} ]]; then
        echo "$error_message"
        echo "For example: $example"
        sleep infinity
    fi
}
update_config() {
    local var_name="$1"
    local pattern="$2"
    local config_path="$3"

    if [[ -n ${!var_name} ]]; then
        sed -i.bak -e "s|^$pattern *=.*|$pattern = \"${!var_name}\"|;" "$config_path"
    fi
}

check_var "LISTEN_PORT" "CHECK YOUR LISTEN_PORT AND REMOTE_PORT IN DEPLOY.YML !" "LISTEN_PORT=3333 REMOTE_PORT=8585"
check_var "IPV4_ADDRESS" "CHECK YOUR IPV4 ADDRESS IN DEPLOY.YML !" "IPV4_ADDRESS=XXX.XXX.XXX.XXX"

sentinelnode config init && sentinelnode v2ray config init

(echo ;echo ;echo ;echo ;echo ;echo ;echo )| openssl req -new -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 -x509 -sha256 -days 365 -nodes -out ${HOME}/tls.crt -keyout ${HOME}/tls.key
REMOTE_URL="https://$IPV4_ADDRESS:$REMOTE_PORT"
# Variables to update in the config.toml.
declare -A config_mappings=(
    ["GAS_ADJUSTMENT"]="gas_adjustment"
    ["GAS"]="gas"
    ["GAS_PRICES"]="gas_prices"
    ["CHAIN"]="id"
    ["BACKEND"]="backend"
    ["WALLET_NAME"]="from"
    ["MONIKER"]="moniker"
    ["TYPE"]="type"
    ["RPC_ADDRESS"]="rpc_address"
    ["SIMULATE_AND_EXECUTE"]="simulate_and_execute"
    ["PEERS"]="peers"
    ["INTERVAL_SET_SESSIONS"]="interval_set_sessions"
    ["INTERVAL_UPDATE_SESSIONS"]="interval_update_sessions"
    ["INTERVAL_UPDATE_STATUS"]="interval_update_status"
    ["IPV4_ADDRESS"]="ipv4_address"
    ["GIGABYTE_PRICES"]="gigabyte_prices"
    ["HOURLY_PRICES"]="hourly_prices"
    ["REMOTE_URL"]="remote_url"
)

# Update each variable in config.toml.
for var in "${!config_mappings[@]}"; do
    update_config "$var" "${config_mappings[$var]}" "$CONFIG_PATH"
done

[[ -n $LISTEN_PORT ]] && sed -i.bak -e "s|^listen_port *=.*|listen_port = \"$LISTEN_PORT\"|;" "$V2RAY_CONFIG_PATH"
[[ -n $TRANSPORT ]] && sed -i.bak -e "s|^transport *=.*|transport = \"$TRANSPORT\"|;" "$V2RAY_CONFIG_PATH"

# Special cases
[[ -z $HANDSHAKE ]] && HANDSHAKE=false && update_config "HANDSHAKE" "enable" "$CONFIG_PATH"
[[ -n $REMOTE_PORT ]] || sed -i.bak -e "s|^listen_on *=.*|listen_on = \"0.0.0.0:$REMOTE_PORT\"|;" "$CONFIG_PATH"

(echo `echo $MNEMONIC_BASE64 | base64 -d`)|sentinelnode keys add --recover
mv ${HOME}/tls.crt ${HOME}/.sentinelnode/tls.crt && mv ${HOME}/tls.key ${HOME}/.sentinelnode/tls.key
PATH=$PATH:/root/v2ray
sentinelnode start
