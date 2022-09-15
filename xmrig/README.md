# Why use Akash?

Welcome [xmrig](https://xmrig.com/) and [Monero](https://getmonero.org) miners! [Akash](https://akash.network) is a decentralized marketplace of compute with thousands of CPU's ready for small and large deployments.  xmrig mining can be deployed on the network successfully using this guide.  Akash is a part of the [Cosmos](https://cosmos.network/) ecosystem of blockchains.

# How to speed up mining?

The biggest factor to control speed of mining is using RANDOMX_MODE=fast or RANDOMX_MODE=light.

Set `RANDOMX_MODE=fast` to maximize your speed and use the most amount of resources possible / highest price.
Requires at least 3Gi of Memory for providers with = 1 NUMA node.
Requires at least 4.75Gi of Memory for providers with > 1 NUMA node.

Set `RANDOMX_MODE=light` to use the smallest amount of resources / lowest price.
Requires at least 0.1Gi of Memory for all providers.

## Configure xmrig options

The Akash version of xmrig comes with variables that can be added or removed to the deploy.yaml file to further configure the miner.

Here are all available variables:
```
POOL=
WALLET=
PASS=x
WORKER=
TLS=
TLS_FINGERPRINT=
ALGO=
DONATE_LEVEL=
RANDOMX_MODE=
CUSTOM_OPTIONS=
```

## Default pools

The default pool is [MoneroOcean](moneroocean.stream/).  
Input your Monero wallet address in the `WALLET=` variable.

You can also set `POOL=herominers` or `POOL=hashvault`.  This will attempt to auto-select the nearest pool to your deployment.

## Solo mining

To enable solo mining use `POOL=herominers` and `WALLET=solo:yourmoneroaddress`. This will attempt to auto-select the nearest Herominers pool to your deployment.

If you know the location of the provider, please manually define the `POOL=`

Central Europe (Germany ): de.monero.herominers.com:1111
Northern Europe (Finland ): fi.monero.herominers.com:1111
Eastern Europe (Russia ): ru.monero.herominers.com:1111
North America - East (Canada ): ca.monero.herominers.com:1111
North America - West (USA ): us.monero.herominers.com:1111
North America - East (USA ): us2.monero.herominers.com:1111
South America (Brazil ): br.monero.herominers.com:1111
Asia (HongKong ): hk.monero.herominers.com:1111
Asia (South Korea ): kr.monero.herominers.com:1111
South Asia (India ): in.monero.herominers.com:1111
SouthEast Asia (Singapore ): sg.monero.herominers.com:1111
Western Asia (Turkey ): tr.monero.herominers.com:1111
Oceania (Australia ): au.monero.herominers.com:1111

## Changing the pool

We recommend you use HeroMiners for a reliable pool, however if you need to change it feel free using the `POOL=` and configure `WALLET=` and `PASSWORD=`.

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
