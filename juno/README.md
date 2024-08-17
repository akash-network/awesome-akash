# What is Juno?

Juno is a golang [**Starknet**](https://starknet.io/) node implementation by [**Nethermind**](https://nethermind.io/) with the aim of decentralising Starknet.

## Deploy Starknet node on Akash

1. Install [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap) wallet as a browser extension
2. Fund your wallet with at least 5 AKT. How to get AKT? Read at https://akash.network/token
3. Open [Akash Console](https://console.akash.network/) and connect your Keplr wallet
5. Create a certificate
3. Create deployment
4. Choose `Empty` for the template and copy-and-paste the `deploy.yaml` file from this repository

Don't forget to use your own API key from Infura in SDL. Node will sync after deployment.

Click [here](https://akash.network/docs/guides/) to learn more about deploying.

## Get Access to Starknet RPC
Juno is compatible with the following Starknet API versions:
- v0.6.0 (Endpoint: /v0_6 or default /)
- v0.5.0 (Endpoint: /v0_5)

To interact with a specific API version, you can specify the version endpoint in your RPC calls. For example:
```
curl -X POST http://localhost:6060 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"juno_version","id":1}'
```
Use URI from Akash Console after deployment instead of http://localhost:6060

## Documentation

[Juno Website](https://juno.nethermind.io/)
[Juno on Github](https://github.com/NethermindEth/juno)
[Infura](https://app.infura.io/)
[JSON-RPC methods](https://docs.infura.io/api/networks/starknet/json-rpc-methods)
[Starknet Website](https://www.starknet.io/en)
