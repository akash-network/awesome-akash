__CAUTION!! following my tutorial might result in lost of money/token, please do not use your own money before you're 100% confidence that what you're doing is right, always ask for some token from [Akash official discord channel](https://discord.com/invite/DxftX67) for akash and for near testnet in [Openshard alliance](https://discord.com/invite/t9Kgbvf), i will not responsible for any money/token losses that may occur while you're following my tutorial__

# Run both validator node and RPC node using akash

In this tutorial i'm gonna show you how to run Near validator node and RPC node on a single deployment file, for this tutorial im gonna deploy it in *near testnet*

## Video Demo

https://www.youtube.com/watch?v=Gl6phYYUfHQ

## Prerequisites

- [Akashlytics](https://akashlytics.com/)

## Step 1 - Open akashlytics and deploy our node

For this tutorial i'm gonna deploy in near testnet, first open your akashlytics and deploy this yaml file:

```yaml
---
version: "2.0"

services:
  near:
    image: spiritbro1/near-validator:testnet # there is two tag for this testnet and mainnet
    env:
      - NEAR_ENV=testnet # change this to either guildnet or testnet or mainnet
      - SSH_PASS=cantseemee # change this to a more secure pass
      - ACCOUNT_ID=**.pool.f863973.m0 # change ** to your desired name for staking pool contract
    expose:
      - port: 3030
        as: 3030
        to:
          - global: true
      - port: 22
        as: 22
        to:
          - global: true

profiles:
  compute:
    near:
      resources:
        cpu:
          units: 4
        memory:
          size: 16Gi
        storage:
          size: 300Gi
  placement:
    westcoast:
      attributes:
        host: akash
      pricing:
        near:
          denom: uakt
          amount: 5000

deployment:
  near:
    westcoast:
      profile: near
      count: 1
```

The image for this `deploy.yaml` file is `image: spiritbro1/near-validator:testnet` testnet, why? because when i first try to deploy it i saw an update in [official validator telegram channel](https://t.me/near_validators/4669) at first i use version 1.23.1 but after the update the testnet is now version 1.24.1 you can check that respectively in their rpc for testnet https://rpc.testnet.near.org/status and for mainnet https://rpc.mainnet.near.org/status and see the `version` value. There is two tag for our validator docker image:

- spiritbro1/near-validator:testnet
- spiritbro1/near-validator:mainnet

And for respective image has it's own value that you need to fill, in order for our validator node to run flawlessly,
so for `spiritbro1/near-validator:testnet` docker image you need to pass value like this :

```
- NEAR_ENV=testnet # change this to either guildnet or testnet 
- SSH_PASS=cantseemee # change this to a more secure pass
- ACCOUNT_ID=**.pool.f863973.m0 # change ** to your desired name for staking pool contract
```

Where `NEAR_ENV` can be filled with either `guildnet` or `testnet`, and `SSH_PASS` is for password to connect to your ssh later, and `ACCOUNT_ID` is id to be able to be listed as validator on explorer testnet for example you can fill it with `spiritbro.pool.f863973.m0` and for `spiritbro1/near-validator:mainnet` :

```
 - NEAR_ENV=mainnet # this is optional
 - SSH_PASS=cantseemee # change this to a more secure pass default secret
 - ACCOUNT_ID=**.poolv1.near # change ** to your desired name for staking pool contract default none
```

Where `NEAR_ENV` is optional default mainnet, and the other is the same as on testnet. Two open port is `3030` and `22`, port `3030` is for opening RPC node you can open that later by opening in browser `<your provider url>:<port>/status` and you can see your RPC just like when you see [testnet RPC](https://rpc.testnet.near.org/status), and port `22` basically used for two things:

- First is when your node is fully synced, you need to check whether your validator key is the same as your staking key later, and using ssh you can easily stop any process so you don't need to redeploy your akash instance, and to finish the setup like `near login` we need to ssh to our instance.

- Second reason is if you stuck and you got an error you can ask me or some admin in [openshard alliance](https://discord.com/invite/t9Kgbvf) or [near official discord channel](http://near.chat/) for assistance. But be careful you need to make sure that the person you ask for help has admin role on it.

```
 cpu:
          units: 4
        memory:
          size: 16Gi
        storage:
          size: 300Gi
```

For this one basically wrong because in official documentation [here](https://docs.near.org/docs/develop/node/validator/hardware) you need to have at least 8 core CPU, 8 GB RAM, and 500 GB SSD, i change it to 4 core CPU, 16 GB RAM and 300 GB SSD is because i didn't get any bid, so if you really want to deploy this to mainnet later i suggest you change that to official recommended spec, because right now we gonna demo it, so this is spec basically sufficient. And after that click `Create Deployment` to deploy in akashlytic.

<center><img src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ppm5y81cq3fjbzi36xxz.png"/></center>

After that accept one of the bid :

<center><img src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/tijkdts0mguxm73zo01n.png"/></center>

After you successfully accept the bid you will get something like this :

<center><img src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4zrrmo5tkakn6lzog7r4.png"/></center>

You will see something like `30768:3030` which is the forwarded port for our RPC it getting forwarded to port `30768` and if you want to see the url just click on one of the forwarded port and you will see something like this:

<center><img src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/oetfd6t6smohgk5ltlm0.png"/></center>

It means that our rpc node is fully run. 

Step 2 - List our validator node on testnet explorer

We need to see now if our validator node is fully setup this is the step on how we can check if our node is fully setup :

- First we need to check whether the necessary file is downloaded the necessary files are validator_key.json, node_key.json, config.json, data, genesis.json you can check if all of this present by ssh to your akash deployment and issue this command `ls /app/near_home`

- If all of that is present we need to see if snapshot data is downloaded we can check that by seeing akash log if you see something like this :

<center><img src="" /></center>
