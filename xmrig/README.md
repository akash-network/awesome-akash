# Why use Akash?

Welcome [xmrig](https://xmrig.com/) and [Monero](https://getmonero.org) miners! [Akash](https://akash.network) is a decentralized marketplace of compute with thousands of CPU's ready for small and large deployments.  xmrig mining can be deployed on the network successfully using this guide.  Akash is a part of the [Cosmos](https://cosmos.network/) ecosystem of blockchains.

# How to speed up mining?

The biggest factor to control speed of mining is using RANDOMX_MODE=fast or RANDOMX_MODE=light.

Set `RANDOMX_MODE=fast` to maximize your speed and use the most amount of resources possible/expensive.
Requires at least 4.5Gi of Memory for providers with > 1 NUMA node.

Set `RANDOMX_MODE=light` to use the smallest amount of resources possible/cheapest.
Use as little as 0.01 and 128Mi of Memory for a deployment

## Configure xmrig options

The Akash version of xmrig comes with variables that can be added or removed to the deploy.yaml file to further configure the miner.

Here are all available variables:
```
POOL=
WALLET=
PASSWORD=
WORKER=
TLS=
TLS_FINGERPRINT=
ALGO=
DONATE_LEVEL=
RANDOMX_MODE=
RANDOMX_1GB=
```

## Default pools

The default pool is [Hashvault](https://monero.hashvault.pro/en/dashboard).  Input your Monero wallet address in the `WALLET=` variable.

## Changing the pool

We recommend you use Hashvault for a reliable pool, however if you need to change it feel free using the `POOL=` and configure `WALLET=` and `PASSWORD=`.

## Disabling TLS

If your pool does not support TLS it can be disabled by setting `TLS=false` and `TLS_FINGERPRINT=` in the deploy.yaml file.

## Increase the deployment size on Akash

You can deploy more CPU or more replicas to mine faster.


```
cpu:
  units: 1.0 # Max cpu units is 256
```

Or increase the replica count from `count: 1` to `count: 2`.

```
deployment:
  xmrig:
    akash:
      profile: xmrig
      count: 1 # Multiplier for cpu:units
```


### Check your miner's status

Just enter your deployment URI at http://workers.xmrig.info

### Check your miner's stats in the Hashvault pool

Enter your Monero address to see the stats at https://monero.hashvault.pro/en/dashboard

# Check your profitability

After your deployment has finished tuning or is displaying results on the pool you can check your profitability by inputing your hashrate from the log file.

[Minerstat profitability calculator](https://minerstat.com/coin/XMR)

# What is the best pool? Where do I solo mine?

We recommend you check MiningPoolStats for the most up-to-date list of mining pools.

[Mining Pool Stats](https://miningpoolstats.stream/monero)

# Additional guides

[How to mine Monero on Akash Network](https://nixaid.com/mine-monero-akash)
