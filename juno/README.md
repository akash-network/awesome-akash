# Juno

Juno is a golang [**Starknet**](https://starknet.io/) node implementation by [**Nethermind**](https://nethermind.io/) with the aim of decentralising Starknet.

## Get Access to Starknet RPC
Juno is compatible with the following Starknet API versions:
- v0.6.0 (Endpoint: /v0_6 or default /)
- v0.5.0 (Endpoint: /v0_5)
To interact with a specific API version, you can specify the version endpoint in your RPC calls. For example:
```
curl -X POST http://localhost:6060 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"juno_version","id":1}'
```
Use URI in Cloudmos or Akash Console after deployment instead of http://localhost:6060

## Documentation

[Juno Website](https://juno.nethermind.io/)
[Juno on Github](https://github.com/NethermindEth/juno)
[Infura](https://app.infura.io/)
[JSON-RPC methods](https://docs.infura.io/api/networks/starknet/json-rpc-methods)
