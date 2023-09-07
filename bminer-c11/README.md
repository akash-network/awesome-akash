# Bminer: When Crypto-mining Made Fast

Bminer is a highly optimized cryptocurrency miner that runs on modern AMD / NVIDIA GPUs. Bminer is one of the fastest publicly available miners today -- we use various techniques including tiling and pipelining to realize the full potentials of the hardware.

Bminer also comes with REST APIs to facilitate production deployments (e.g., mining farms).

    Bminer supports mining Equihash-based coins (e.g., BitcoinGold, BitcoinZ) with 2% of devfee.
    Bminer supports mining Ethash-based coins (e.g., Ethereum) with 0.65% of devfee. It is also possible to dual mine Ethash and Blake14r-based / Blake2s-based coins, where the devfee is 1.3%.
    Bminer supports mining Bytom (BTM) with 2% of devfee.
    Bminer supports mining Grin (GRIN) with 1% of devfee.

Features

    Fast and efficient
        Bminer is one of the fastest miner on a number of algorithms.
    Secure and reliable
        SSL support
        Automatic reconnects to recover from transient network failures
        Automatic restarts if GPUs hang
    Operation friendly
        Comes with REST APIs to facilitate large-scale production deployments
