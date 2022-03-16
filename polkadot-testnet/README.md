# Polkadot Testnet Node
This image will deploy Polkadot node on Westend testnet.

# Verify Node Health Status
Assuming your akash provider forwarded port for `:9933` is `:30384` and the provider url is `provider.edgenet-3.ca.aksh.pw`

```shell
curl -X POST -H 'content-type:application/json' --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"system_health"
}'  provider.edgenet-3.ca.aksh.pw:30384
```

Output:
```json
{
    "jsonrpc": "2.0",
    "result": {
        "isSyncing": true,
        "peers": 39,
        "shouldHavePeers": true
    },
    "id": 1
}
```