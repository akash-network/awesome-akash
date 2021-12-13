# Why use Akash?

Welcome [MoneroOcean](https://moneroocean.stream/) and [Monero](https://getmonero.org) miners! This repository uses the default auto-switching installer from MoneroOcean, available [here](https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/setup_moneroocean_miner.sh).  [Akash](https://akash.network) is a decentralized marketplace of compute with thousands of CPU's ready for small and large deployments.  MoneroOcean mining can be deployed on the network successfully using this guide.  Akash is a part of the [Cosmos](https://cosmos.network/) ecosystem of blockchains.

# Windows/Linux/Mac Users

1. Install [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en) wallet as a browser plugin
2. Install [Akashlytics](https://akashlytics.com/deploy) and import your AKT wallet address from Keplr.
3. [Fund your wallet](#Quickest-way-to-get-more-AKT)

For additional help we recommend you [follow our full deployment guide](https://docs.akash.network/guides/deploy) in parallel with this guide.

# How does this work?
Akash uses its blockchain to manage your container deployment and accounting.  To deploy on Akash you will need to fund your wallet with at least 10 AKT (~$20)  Each time you create a deployment, 5 AKT will be used for escrow and to fund the deployment.  If the deployment is canceled the balance of the escrow is returned to you.  You can spin up deployments without worrying about any long term contracts and you can cancel anytime.

# Default wallet
Akash uses [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en) as the desktop wallet.  Advanced users can follow the [CLI instructions](https://docs.akash.network/guides/cli)

# Quickest way to get more AKT
To fund your deployment you will need AKT in your account.  The fastest way to do that is as follows:

## Buy on an Exchange
1. Install [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en)
2. Buy AKT on an [exchange](https://www.coingecko.com/en/coins/akash-network#markets)
3. Withdraw your AKT to your Keplr wallet.

## Swap from `ATOM` to `AKT`
1. Install [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en)
2. Send 10 ATOM to your new Cosmos wallet address inside Keplr (this address will start with `cosmos`)
3. Goto [Osmosis Assets](https://app.osmosis.zone/assets) > next to `Cosmos Hub - ATOM` click on `Deposit`
   This step deposits ATOM from your Keplr wallet onto the Osmosis platform.
5. Now go back to [Osmosis Homepage](https://app.osmosis.zone/assets) and select `ATOM > AKT` to complete the swap
   This step swaps your ATOM you deposited onto the Osmosis platform into any other supported coin.
7. Return to the [Osmosis Assets](https://app.osmosis.zone/assets) page to withdraw your AKT to your Keplr wallet
   This step withdraws AKT from the Osmosis platform back into your Keplr wallet.  You can now send AKT to Akashlytics.

Have more questions? Find our team in [Discord](https://discord.com/invite/DxftX67) and [Telegram](https://t.me/AkashNW)

# Deploying on Akash

Once you have setup your Keplr wallet and imported the address to Akashlytics you are ready to create your first deployment.  Follow the instructions in Akashlytics to create a certificate, then click on `Create Deployment`

When prompted to `Choose Template` select `Empty` as we will copy-and-paste the deploy.yaml file from this repository.
Choose `Empty` for the template and paste the `deploy.yaml` file from this repository adjusting your wallet address and pool variables.
```
---
version: "2.0"

services:
  xmrig:
    image: cryptoandcoffee/akash-moneroocean:1
    expose:
      - port: 8080
        as: 80
        proto: tcp
        to:
          - global: true
    env:
      - "WALLET=4AbG74FRUHYXBLkvqM1f7QH3UXGkhLetKdxS7U7BHkyfMF4nfx99GvN1REwYQHAeVLLy4Qa5gXXkfS4pSHHUWwdVFifDo5K"
profiles:
  compute:
    xmrig:
      resources:
        cpu:
          units: 1.0
        memory:
          size: 1Gi
        storage:
          size: 256Mi
  placement:
    akash:
      pricing:
        xmrig:
          denom: uakt
          amount: 5
deployment:
  xmrig:
    akash:
      profile: xmrig
      count: 1
```

# Choosing a provider

Akash is a marketplace of compute.  Providers set their own prices for compute resources.  We recommend you try different providers and check your logs after deployment to determine the hashrate.

![AkashlyticsBids](https://user-images.githubusercontent.com/19512127/142057801-5091473e-a9c3-4994-9e13-f1b1b1658491.png)

# Configure MoneroOcean options

You only need to configure your wallet address to use the MoneroOcean miner.  

Here are all available variables:
```
WALLET=
```

# How to speed up mining?

## Increase the deployment size on Akash

You can deploy more CPU or more replicas to mine faster.

```
cpu:
  units: 1.0 # Max cpu units is 10

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

### Check your miner's stats in the MoneroOcean pool

Enter your Monero address to see the stats at https://moneroocean.stream/

# Check your profitability

After your deployment has finished tuning or is displaying results on the pool you can check your profitability by inputing your hashrate from the log file.

[Minerstat profitability calculator](https://minerstat.com/coin/XMR)

# Additional guides

[How to mine Monero on Akash Network](https://nixaid.com/mine-monero-akash)
