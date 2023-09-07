# Why use Akash?

Welcome [MoneroOcean](https://moneroocean.stream/) and [Monero](https://getmonero.org) miners! This repository uses the default auto-switching installer from MoneroOcean, available [here](https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/setup_moneroocean_miner.sh).  [Akash](https://akash.network) is a decentralized marketplace of compute with thousands of CPU's ready for small and large deployments.  MoneroOcean mining can be deployed on the network successfully using this guide.  Akash is a part of the [Cosmos](https://cosmos.network/) ecosystem of blockchains.

# Configure MoneroOcean options

You only need to configure your wallet address to start using MoneroOcean.  

Here are all available variables:
```
WALLET=
```

# How to speed up mining?

## Enable fast mode

The default SDL uses light mode and 1Gi of memory.  To increase mining speed you must enable fast mode by making the following changes:

```
Update the required variables

- MEMORY_SIZE=3Gi
#Must match memory size in the resources profile
- MODE=fast
#Light or Fast - Min 1Gi required for MODE=light and Min 3Gi required for MODE=fast

Update the requested amount of Memory

memory:
  size:  3Gi

```

## Increase the deployment size on Akash

You can deploy more CPU or more replicas to mine faster.

```
cpu:
  units: 1.0 # Max cpu units is 256

```

Or increase the replica count from `count: 1` to `count: 2`.  The total cpu units requested can never exceed 512.

```
deployment:
  xmrig:
    akash:
      profile: xmrig
      count: 1 # Multiplier for cpu:units
```

### Check your miner's status

Just enter your deployment URI at http://workers.xmrig.info

### Check your miner's stats in the MoneroOcean pool

Enter your Monero address to see the stats at https://moneroocean.stream/

# Check your profitability

After your deployment has finished tuning or is displaying results on the pool you can check your profitability by inputing your hashrate from the log file.

[Minerstat profitability calculator](https://minerstat.com/coin/XMR)

# Additional guides

[How to mine Monero on Akash Network](https://nixaid.com/mine-monero-akash)
