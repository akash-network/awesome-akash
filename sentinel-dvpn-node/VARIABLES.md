<p align="center"><img src="https://user-images.githubusercontent.com/23629420/219872517-2adc32b1-5f64-4d48-9a81-1e2ef6b01a53.png" width=90% </p>
  
  # List of variables available for input and modification via deploy.yml
  
   In the manifest file ( `deploy.yml` ), you can change the settings in the `config.toml` and `v2ray.toml` files by deleting, adding or changing the following variables (their default values are in parentheses) .
  
   For file **/root/.sentinelnode/config.toml :**
  
   * `GAS_ADJUSTMENT` - Gas correction factor (default value: `1.05` ).
   * `GAS` - Gas limit per transaction (default value: `200000` ).
   * `GAS_PRICES` - Gas price to determine the transaction fee (default value: `0.1udvpn` ).
   * `CHAIN` - Network name (default value: `sentinelhub-2` ).
   * `RPC_ADDRESS` - RPC node address (default value: `https://rpc.sentinel.co:443` ).
   * `SIMULATE_AND_EXECUTE` - Calculate transaction fees (default value: `true` ).
   * `HANDSHAKE` - Enable DNS handshake resolver (default value: `false` ).
   * `PEERS` - Number of peers (default value: `8` ).
   * `BACKEND` - The underlying key storage mechanism (default value: `test` ).
   * `WALLET_NAME` - The name of the account or wallet to sign (default value: `wallet` ).
   * `INTERVAL_SET_SESSIONS` - Time interval between each set_sessions operation (default value: `10s` ).
   * `INTERVAL_UPDATE_SESSIONS` - Time interval between each update_sessions transaction (default value: `1h55m0s` ).
   * `INTERVAL_UPDATE_STATUS` - Time interval between each set_status transaction (default value: `55m0s` ).
   * `REMOTE_PORT` - Port for connecting sentinelcli clients (default value: `8585` ).
   * `MONIKER` - Node name (default value: `null` ).  
   * `GIGABYTE_PRICES` - Price per 1 gygabyte traffic.
   * `HOURLY_PRICES`  - Price per 1 hour traffic.
   * `IPV4_ADDRESS` - IPv4 address to replace the public IPv4 address with one issued by the ISP (default value: `null` ).
   * `TYPE` - Node type (default value: `v2ray` ).
  
   For file **/root/.sentinelnode/v2ray.toml :**
   * `LISTEN_PORT` - Port number to accept incoming connections (default value: `3333` ).
   * `TRANSPORT` - The name of the transport protocol (default value: `grpc` ).
