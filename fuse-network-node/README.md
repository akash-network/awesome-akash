Fuse Network
============
A fast, decentralized payment network that offers Ethereum smart contract capabilities and enables anyone to have ownership in the infrastructure.

To access JSON-RPC server (RPC ports are open by default) run the following `curl` command:
```
curl -X POST \
--header 'Content-Type: application/json' \
--data-raw '{"jsonrpc": "2.0",
"method": "eth_chainId",
"params": [],
"id": "1"}' <URL>
```

More details about Fuse Network: https://fuse.io/
Developers docs: https://developers.fuse.io/fuse-dev-docs/
JSON-RPC reference: https://getblock.io/docs/available-nodes-methods/FUSE/JSON-RPC/eth_chainId/
