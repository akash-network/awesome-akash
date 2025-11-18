# Centrifuge
Centrifuge Chain is blockchain built with Rust and the Polkadot SDK, purpose built for real-world assets.

## RPC
To access the JSON-RPC server and check the synchronization status, run the following `curl` command:
```
curl -X POST \
--header 'Content-Type: application/json' \
--data-raw '{"jsonrpc": "2.0",
"method": "system_syncState",
"params": [],
"id": "1"}' <URL:9933>
```

## Docs
[Centrifuge Documentation](https://docs.centrifuge.io/) | [Releases](https://github.com/centrifuge/centrifuge-chain/releases) | [JSON-RPC reference](https://polkadot.js.org/docs/substrate/rpc/)
