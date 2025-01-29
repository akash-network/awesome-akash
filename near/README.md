# NEAR on Akash

# What is Akash?

Akash is an [**open source** ](https://github.com/ovrclk/akash)Cloud platform that lets you quickly deploy a Docker container to the Cloud provider of your choice for less than the cost of AWS, right from the [**command-line**](https://akash.network/docs/deployments/akash-cli/overview).

# What is NEAR?

NEAR is a [sharded](https://near.org/downloads/Nightshade.pdf), [proof-of-stake](https://en.wikipedia.org/wiki/Proof_of_stake), [layer-one](https://blockchain-comparison.com/blockchain-protocols/) blockchain that is simple to use, secure and scalable.



# Simple Steps

1. Install [Keplr](https://chrome.google.com/webstore/detail/keplr/dmkamcknogkgcdfhhbddcghachkejeap?hl=en) wallet as a browser extension
2. Fund your wallet at least 5 AKT([how to get AKT](https://akash.network/token))
3. Install [Akashlytics](https://akashlytics.com/deploy) and import your AKT wallet address from Keplr
4. Deploy a NEAR node

Click [here](https://akash.network/docs/guides/) to learn more about deploying.



# Deploy a NEAR node on Akash

1. import your AKT wallet address from Keplr
2. create a certificate
3. create deployment
4. choose `Empty` for the template and copy-and-paste the `deploy.yaml` file from this repository

> Note:
>
> - adjusting the `account-id` if you want to run a validator node.



```
---
version: "2.0"

services:
  nearup:
    image: nearprotocol/nearup
    args:
      - run
      # Validators should use the account ID of the account you want to stake with. leave empty if not going to be a validator
      - --account-id=
      # Types of network: mainnet, testnet, betanet, guildnet, localnet
      - mainnet
    expose:
      - port: 3030
        as: 3030
        to:
          - global: true

profiles:
  compute:
    nearup:
      resources:
        # Near Nodes Minimal Hardware Specifications: 8 physical cores AND 8GB DDR4 RAM
        cpu:
          # Max cpu units is 10 on Akash
          units: 8
        memory:
          size: 8Gi
        storage:
          size: 256Gi
  placement:
    akash:
      attributes:
        host: akash
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
      pricing:
        nearup:
          denom: uakt
          amount: 100

deployment:
  nearup:
    akash:
      profile: nearup
      count: 1
```

