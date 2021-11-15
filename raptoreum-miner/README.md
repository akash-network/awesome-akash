## How to mine Raptoreum (RTM) on Akash Network

### deploy.yaml

Welcome Raptoreum miners! Akash offers a global marketplace of compute with thousands of CPU's ready for small and large deployments.

You must change the wallet address in `env` variables in deploy.yaml.  Additional settings like TUNE and DONATION are available as well.

# Windows and Mac Users :

1. [Follow our Quick Start Guide](https://docs.akash.network/guides/deploy)
2. Edit the deploy.yaml file with your wallet address.
3. Deploy and manage your deployment with [Akashlytics](https://akashlytics.com/deploy)

# Linux Users

1.  Follow our [Bootstrap Start Guide](https://github.com/ovrclk/akash-wallet-handler)
2.  Edit the deploy.yaml file with your wallet address.
3.  Deploy and manage your deployment with [Akashlytics](https://akashlytics.com/deploy)

# How to speed up mining?

## Change the `TUNE=no-tune` variable in deploy..yaml to `TUNE=full-tune`

No tune will start mining right away - with no performance tuning of the container.  Without this expect a lower hashrate.
Be warned, tuning can take at least 3 hours before mining begins - so do not expect to see hashrate on the pool immediately.
You can always check your logs in Akashlytics.

## Increase the deployment size on Akash

You can deploy more CPU or more replicas to mine faster.  


```
cpu:
  units: 1.0 # Max cpu units is 10

```

Or increase the replica count from `count: 1` to `count: 2` or greater.

```
deployment:
  raptoreum:
    akash:
      profile: raptoreum
      count: 1 # Multiplier for cpu:units
```

# Check your profitability

After your deployment has finished tuning or is displaying results on the pool you can check your profitability by inputing your hashrate from the log file.

[Minerstat profitability calculator](https://minerstat.com/coin/RTM)

# What is the best pool? Where do I solo mine?

We recommend you check MiningPoolStats for the most up-to-date list of mining pools.

[Mining Pool Stats](https://miningpoolstats.stream/raptoreum)

