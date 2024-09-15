# pkt.cash miner

Deploy a https://pkt.cash miner on https://akash.network

## Version

packetcrypt-v0.5.2

## Pool configuration

PKT pools vary in their performance and reliability.  Once you have created your deployment, check the logs to make sure the pool is responding as expected. Otherwise, please remove the faulty pool from your manifest file.

```
    env:
      - WALLET_ADDR=
      - POOL1=http://pool.pkteer.com
      - POOL2=http://pool.pkt.world
      - POOL3=http://pool.pktpool.io
      - POOL4=https://stratum.zetahash.com
```

For example, if a pool is not working.  Replace the pool address and/or comment out the variables. Be sure to update the sequential number for each POOL variable.

```
    env:
      - WALLET_ADDR=
      - POOL1=http://pool.pkteer.com
      #- POOL2=http://pool.pkt.world
      - POOL2=http://pool.pktpool.io
      - POOL3=https://stratum.zetahash.com
```

If you continue to have issues with the pools, please contact pkt.cash support channels.

## Track earnings

Track your earnings at https://explorer.pkt.cash

## Configuration

Edit `deploy.yaml` so that it uses your wallet address and desired pool.

## Running

Follow the steps at https://akash.network/docs to deploy to the https://akash.network cloud.
