## Chia on Akash

# Why use Akash?

Welcome [Chia](https://www.chia.net/) community! We are excited to announce support for Chia on the [Akash](https://akash.network) network!  You can now run farmers and plotters on our marketplace of compute.  Below you will find details on how to configure your deployment for different use cases.  Akash is a part of the [Cosmos](https://cosmos.network/) ecosystem of blockchains.

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
2. Send 10 ATOM to your new Cosmos wallet address (this address will start with `cosmos`)
3. Goto https://app.osmosis.zone/assets > next to `Cosmos Hub - ATOM` click on `Deposit`
4. Now go back to https://app.osmosis.zone/ and select `ATOM > AKT` to complete the swap
5. Return to the https://app.osmosis.zone/assets page to withdraw your AKT to your Keplr wallet

Have more questions? Find our team in [Discord](https://discord.com/invite/DxftX67) and [Telegram](https://t.me/AkashNW)

# Deploying Chia Plotting on Akash

Once you have setup your Keplr wallet and imported the address to Akashlytics you are ready to create your first deployment.  Follow the instructions in Akashlytics to create a certificate, then click on `Create Deployment`

When prompted to `Choose Template` select `Empty` as we will copy-and-paste the deploy.yaml file from this repository.
Choose `Empty` for the template and paste the `deploy.yaml` file from this repository adjusting your wallet address and pool variables.
```
---
version: "2.0"

services:
  chia:
    image: cryptoandcoffee/akash-chia:60
    expose:
      - port: 8080
        as: 80
        proto: tcp
        to:
          - global: true
    env:
      - CONTRACT=
      - FARMERKEY=
      - REMOTE_LOCATION=local
        #Choose local to access finished plots through web interface or upload finished plots to SSH destination path like /root/plots
      - PLOTTER=madmax
        #Choose your plotter software - madmax or blade (testnet only)
###################################################################
# Remote Upload Variables / Only enable if REMOTE_LOCATION != local
#      - REMOTE_HOST=changeme.com #SSH upload host
#      - REMOTE_LOCATION=changeme #SSH upload location like /root/plots
#      - REMOTE_PORT=22 #SSH upload port
#      - REMOTE_USER=changeme #SSH upload user
#      - REMOTE_PASS=changme #SSH upload password
profiles:
  compute:
    chia:
      resources:
        cpu:
          units: 10.0
        memory:
          size: 6Gi
#Chia blockchain is currently ~40gb as of November 2021 / if you are plotting please use at least 256Gi
        storage:
          size: 256Gi
  placement:
    akash:
      pricing:
        chia:
          denom: uakt
          amount: 1000
deployment:
  chia:
    akash:
      profile: chia
      count: 1
```

# Choosing a provider

Akash is a marketplace of compute.  Providers set their own prices for compute resources.  We recommend you try different providers and check your logs after deployment.

![AkashlyticsBids](https://user-images.githubusercontent.com/19512127/142057801-5091473e-a9c3-4994-9e13-f1b1b1658491.png)

# How to speed up plotting?

## Use only providers with the `chia-plotting` attribute

To limit the selection of providers to those with fast storage that meets the requirements for plotting, we recommend you add the `chia-plotting` attribute to the placement section of deploy.yaml file.

```
placement:
  akash:
    attributes:
      chia-plotting: "true"
    pricing:
      chia:
        denom: uakt
        amount: 25
```

## Increase the deployment size on Akash

You can deploy more than one instance of plotting.


```
cpu:
  units: 1.0 # Max cpu units is 10

```

Or increase the replica count from `count: 1` to `count: 2`.

```
deployment:
  chia:
    akash:
      profile: chia
      count: 1 # Multiplier for cpu:units
```
