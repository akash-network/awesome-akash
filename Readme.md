# Banano Mainnet Deployer on Akash
This image will deploy Banano node on Mainnet.

# Verify Node Active
Assuming your akash provider forwarded port for `:7072` is `:30944` and the provider url is `provider.edgenet-3.ca.aksh.pw`

```shell
curl -g -d '{ "action": "version"}' 'http://provider.edgenet-3.ca.aksh.pw:30944'
```
{
    "rpc_version": "1",
    "store_version": "21",
    "protocol_version": "18",
    "node_vendor": "Banano V23.0",
    "store_vendor": "LMDB 0.9.25",
    "network": "live",
    "network_identifier": "F61A79F286ABC5CC01D3D09686F0567812B889A5C63ADE0E82DD30F3B2D96463",
    "build_info": "9b744fe8 \"GNU C++ version \" \"7.5.0\" \"BOOST 107000\" BUILT \"Feb 16 2022\""
}
```
# Check Node Block Count
Assuming your akash provider forwarded port for `:7072` is `:30944` and the provider url is `provider.edgenet-3.ca.aksh.pw`

```shell
curl -g -d '{ "action": "block_count"}' 'http://provider.edgenet-3.ca.aksh.pw:30944'
```

Sample Output:
```json
{
    "count": "1",
    "unchecked": "1232663",
    "cemented": "1"
}
