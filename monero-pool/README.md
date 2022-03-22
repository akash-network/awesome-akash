monero-pool
===========

A Monero mining pool server written in C.

Design decisions are focused on performance and efficiency, hence the use of libevent and LMDB. Currently it uses only two threads under normal operation (one for the stratum clients and one for the web UI clients). It gets away with this thanks to the efficiency of both LMDB and libevent (for the stratum clients) and some sensible proxying/caching being placed in front of the web UI.

Configuration is extremely flexible, now allowing for the pool to run in a variety of setups, such as highly available and redundant configurations. Discussed further below in: Interconnected pools.

This pool was the first pool to support RandomX and is currently the only pool which supports the RandomX fast/full-memory mode.

The single payout mechanism is PPLNS, which favors loyal pool miners, and there are no plans to add any other payout mechanisms or other coins. Work should stay focussed on performance, efficiency and stability.

The pool also supports an optional method of mining whereby miners select their own block template to mine on.

Source: [github.com/jtgrassie/monero-pool](https://github.com/jtgrassie/monero-pool)

Environment Variables
---------------------

| Variable | Description | Default value |
|----------|-------------|---------------|
| `MONERO_ARGS` | (Optional) Additional arguments for `monerod`. | `--testnet` |
| `MONERO_WALLET_ARGS` | (Optional) Additional arguments for `monero-wallet-rpc`. | `--testnet` |
| `MONERO_POOL_WALLET` | (Mandatory) Wallet address which will be used to distribute mining rewards. | `9tRe6v9cHk...KURJ3AxUNH` |
| `MONERO_POOL_WALLET_SEED` | (Mandatory) Mnemonic seed of `MONERO_POOL_WALLET`. | swept upper silk slackens ... alkaline sapling simplest upper |
| `MONERO_FEE_WALLET` | (Mandatory) Wallet address which will be used to receive mining pool's fee. Must be different from `MONERO_POOL_WALLET`. | `9unzQP9GZK...CNXNk45NDv` |
