<div align="center">
  <img src="https://github.com/ava-labs/avalanchego/blob/master/resources/AvalancheLogoRed.png?raw=true">
</div>

---

Node implementation for the [Avalanche](https://avax.network) network - a blockchains platform with high throughput, and blazing fast transactions.

## Deploy on Akash
Deploy on [Akash Console](https://console.akash.network/) with [deploy.yaml](deploy.yaml) file.

## Hardware and Operating Systems​
Avalanche is an incredibly lightweight protocol, so nodes can run on commodity hardware. Note that as network usage increases, hardware requirements may change.

- CPU: 8 vCPU
- RAM: 16 GiB
- Storage: 1 TiB SSD

## Check Bootstrapping Progress​
To check if a given chain is done bootstrapping, in another terminal window call info.isBootstrapped by copying and pasting the following command:

```
curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.isBootstrapped",
    "params": {
        "chain":"X"
    }
}' -H 'content-type:application/json;' localhost:9650/ext/info
```

If this returns true, the chain is bootstrapped; otherwise, it returns false. If you make other API calls to a chain that is not done bootstrapping, it will return API call rejected because chain is not done bootstrapping.

## RPC
When finished bootstrapping, the X, P, and C-Chain RPC endpoints will be:
```
localhost:9650/ext/bc/P
localhost:9650/ext/bc/X
localhost:9650/ext/bc/C/rpc
```

## Documentation
[Avalanche Website](https://docs.avax.network/nodes) | [GitHub](https://github.com/ava-labs/avalanchego/tree/master) | [Dockerfile](https://github.com/ava-labs/avalanchego/blob/master/Dockerfile)
