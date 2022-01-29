__CAUTION!! following my tutorial might result in lost of money/token, please do not use your own money before you're 100% confidence that what you're doing is right, always ask for some token from [Akash official discord channel](https://discord.com/invite/DxftX67) for akash and for near testnet in [Openshard alliance](https://discord.com/invite/t9Kgbvf), i will not responsible for any money/token losses that may occur while you're following my tutorial__

# Run both validator node and RPC node using akash

In this tutorial i'm gonna show you how to run Near validator node and RPC node on a single deployment file, for this tutorial im gonna deploy it in *near testnet*

## Video Demo

https://www.youtube.com/watch?v=fZQe3xY-Q_8

## Video Tutorial

https://www.youtube.com/watch?v=Gl6phYYUfHQ

## Prerequisites

- [Akashlytics](https://akashlytics.com/)
- [Near Testnet Wallet](https://wallet.testnet.near.org/)
- [Discord Account](https://discord.com/)
- Windows WSL or Linux Based OS to ssh to our akash instance

## Step 1 - Open akashlytics and deploy our node

For this tutorial i'm gonna deploy in near testnet, first open your akashlytics and deploy this yaml file:

```yaml
---
version: "2.0"

services:
  near:
    image: spiritbro1/near-validator:testnet # there is two tag for this testnet 
    env:
      - NEAR_ENV=testnet # change this to either guildnet or testnet 
      - SSH_PASS=cantseemee # change this to a more secure pass
      - ACCOUNT_ID=**.pool.f863973.m0 # change ** to your desired name for staking pool contract for guildnet use xx.stake.guildnet
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

The image for this `deploy.yaml` file is `image: spiritbro1/near-validator:testnet` testnet, why? because when i first try to deploy it i saw an update in [official validator telegram channel](https://t.me/near_validators/4669) at first i use version 1.23.1 but after the update the testnet is now version 1.24.0 you can check that respectively in their rpc for testnet https://rpc.testnet.near.org/status and for mainnet https://rpc.mainnet.near.org/status and see the `version` value. That's why i differentiate between testnet and mainnet image because the version is different. There is two tag for our validator docker image:

- spiritbro1/near-validator:testnet
- spiritbro1/near-validator:mainnet

And both of the image has it's own value that you need to fill, in order for our validator node to run flawlessly,
so for `spiritbro1/near-validator:testnet` docker image you need to pass value like this :

```
- NEAR_ENV=testnet # change this to either guildnet or testnet 
- SSH_PASS=cantseemee # change this to a more secure pass
- ACCOUNT_ID=**.pool.f863973.m0 # change ** to your desired name for staking pool contract for guildnet use xx.stake.guildnet
```

Where `NEAR_ENV` can be filled with either `guildnet` or `testnet`, and `SSH_PASS` is for password to connect to your ssh later, and `ACCOUNT_ID` is id to be able to be listed as validator on explorer testnet for example you can fill it with `spiritbro.pool.f863973.m0` and for `spiritbro1/near-validator:mainnet` :

```
 - NEAR_ENV=mainnet # this is optional
 - SSH_PASS=cantseemee # change this to a more secure pass default secret
 - ACCOUNT_ID=**.poolv1.near # change ** to your desired name for staking pool contract default none
```

Where `NEAR_ENV` is optional default mainnet, and the other is the same as on testnet. Two open port is `3030` and `22`, port `3030` is for opening RPC node you can open that later by opening in browser `<your provider url>:<port>/status` and you can see your RPC just like when you see [testnet RPC](https://rpc.testnet.near.org/status), and port `22` basically used for two things:

- First is when your node is fully synced, you need to check whether your validator key is the same as your staking key, and by using ssh you can easily stop any process so you don't need to redeploy your akash instance, and to finish the setup like `near login` we need to ssh to our instance.

- Second reason is if you stuck and you got an error you can ask me or some admin in [openshard alliance](https://discord.com/invite/t9Kgbvf) or [near official discord channel](http://near.chat/) for assistance. But be careful you need to make sure that the person you ask for help has admin role on it.

```
 cpu:
          units: 4
        memory:
          size: 16Gi
        storage:
          size: 300Gi
```

For this one basically wrong, and i do this so i can demo it to you, because in official documentation [here](https://docs.near.org/docs/develop/node/validator/hardware) you need to have at least 8 core CPU, 8 GB RAM, and 500 GB SSD, i change it to 4 core CPU, 16 GB RAM and 300 GB SSD because i didn't get any bid, so if you really want to deploy this to mainnet later i suggest you change that to official recommended spec, because right now we gonna demo it, so this is spec basically sufficient. And after that click `Create Deployment` to deploy in akashlytic.

<img align="center" src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ppm5y81cq3fjbzi36xxz.png"/>

After that accept one of the bid :

<img align="center" src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/tijkdts0mguxm73zo01n.png"/>

After you successfully accept the bid you will get something like this :

<img align="center" src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/4zrrmo5tkakn6lzog7r4.png"/>

You will see something like `30768:3030` which is the forwarded port for our RPC it getting forwarded to port `30768` and if you want to see the url just click on one of the forwarded port and you will see something like this:

<img align="center" src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/oetfd6t6smohgk5ltlm0.png"/>

It means that our rpc node is fully run. 

## Step 2 - List our validator node on testnet explorer

We need to see now if our validator node is fully setup this is the step on how we can check if our node is fully setup :

- First we need to check whether the necessary file is downloaded the necessary files are validator_key.json, node_key.json, config.json, data, genesis.json you can check if all of this present by ssh to your akash deployment and issue this command `ls /app/near_home`

- If all of that is present we need to see if snapshot data is downloaded we can check that by seeing akash log if you see something like this :

<img src="https://dev-to-uploads.s3.amazonaws.com/uploads/articles/xhq5tk1a1elrrmu4qb8y.png" align="center" />

Then that means your snapshot data is being downloaded total snapshot data since this tutorial created is approximately 180 GB, you should wait for it to fully complete

- If snapshot data is fully downloaded usually this is the log that we will get in our akash log :

<img src="https://user-images.githubusercontent.com/62529025/150729872-8038d8e2-fcb2-460b-a416-1c22bf2ede26.png" align="center"/>

As you can see it said "Downloading" which means that it will continue to download block that is still not being able to be covered in snapshot data if we don't see any "Downloading" text that means that our node is fully sync with all of the other node. If that's the case, now we can finally be able to be a staking validator, and list our node on [testnet explorer](https://explorer.testnet.near.org/nodes/validators), you need to also have [testnet id](https://wallet.testnet.near.org/) first we need to ssh to our akash deployment, use this command to ssh to your akash deployment :

```bash
ssh -p <forwarded port> root@<provider url>
```

After that issue this command :

```
near login
```

You will see something like this :

<img src="https://user-images.githubusercontent.com/62529025/150730605-42b349e6-11b8-4004-b38c-d2b08c42a089.png" align="center" />

Open that url and follow the instruction after getting redirected put your testnet account id on the terminal and click enter like this :

<img align="center" src="https://user-images.githubusercontent.com/62529025/150730793-f8489967-a0e2-421e-bdd1-aa56ecf0f60f.png"/>

After that create a staking pool contract by issuing this command in the terminal:

```bash
near call pool.f863973.m0 create_staking_pool '{"staking_pool_id": "<pool id>", "owner_id": "<accountId>", "stake_public_key": "<public key>", "reward_fee_fraction": {"numerator": 5, "denominator": 100}}' --accountId="<accountId>" --amount=30 --gas=300000000000000
```

For example if you want to name your pool spiritbro.pool.f863973.m0 you will input `<pool id>` as `spiritbro` full contract argument can be seen [here](https://explorer.testnet.near.org/transactions/CupMEge18egggjJ4oY7bHNj732PJ1EtzRbhBq2KW6rhB), after you finish calling that contract it will look like this :

<img src="https://user-images.githubusercontent.com/62529025/150731565-7d200d17-7f5b-4d6b-a277-36fc4328904c.png" align="center" />

If it says `true` at the bottom then you're successfully creating staking pool contract, next step is to ask for some testnet token in [Openshard alliance](https://discord.com/invite/t9Kgbvf) then go to `#testnet-token` channel, this is some example of how to properly ask :

<img src="https://user-images.githubusercontent.com/62529025/150732026-eb2b4bc4-f29b-4d20-88d4-8b26be356080.png" align="center">

You need to show that public key in staking pool and in you `validator-key.json` is equal, one way to do that is to issue both of these command respectively:

```bash
near view spiritbro.pool.f863973.m0 get_staking_key '{}'

cat /app/near_home/validator_key.json | grep public_key

```

Then copy paste the result of that command to `#testnet-token` channel and somebody will give you some token usually `@Dav` will give you one, full conversation can be seen [here](https://discord.com/channels/727469632537231373/897100900924002366/934738506960478248), Then check whether you are already eligible for seat on [testnet explorer](https://explorer.testnet.near.org/nodes/validators) search for your pool id usually for the first time after you get token from `@Dav` you will see your pool id in testnet explorer like this:

<img src="https://user-images.githubusercontent.com/62529025/150732770-ed3f7d65-af3c-44bf-9a0f-c554ef97a388.png" align="center"/>

If you got that now you can ping your contract, issue this command in your ssh:

```
near call <staking pool id> ping '{}' --accountId <accountId> --gas=300000000000000
```

To make sure our node will always be in testnet explorer validator list we need to ping it every epoch, 1 epoch is equal 12 hours so let's make cronjob in our ssh, issue this command:

```bash
crontab -e
```

And then put this script inside crontab:

```bash
0 */12 * * * /usr/bin/near call <staking pool id> ping '{}' --accountId <accountId> --gas=300000000000000
```

Then close your crontab by using `ESC -> :wq -> ENTER`, after that let's wait two epoch until our node is fully activated, first epoch after our proposal accepted our node in testnet explorer will look like this:

<img src="https://user-images.githubusercontent.com/62529025/150733616-a9ed9254-5077-46a0-bb36-5229049a892a.png" align="center"/>

And the next epoch will look like this: 

<img src="https://user-images.githubusercontent.com/62529025/150733733-750f5022-cad9-47d8-ad5a-5dfa6c7923cd.png" align="center"/>

And that means congratulations, you're successfully running validator node and RPC node on akash.

## Conclusion 

Now after you learn how to run validator node and RPC node on akash, you can try it on mainnet, don't forget to always try it in testnet first before put it on the mainnet. You can also find all of the docker image that i use here on [here](https://github.com/spiritbro1/near-docker-image), to be honest i never run it on mainnet yet but obviously the step to deploy it similiar again if you not have any confidence on doing it please ask the expert first, before you do something wrong, i'm not responsible for any wrongdoing that you may had if you do something wrong always ask expert before going mainnet.

## References

- https://bootcamp.openshards.io/
- https://explorer.testnet.near.org/nodes/validators
- https://wiki.near.org/network/validator-guides/running-a-validator
- https://docs.near.org/docs/concepts/epoch
- https://docs.near.org/docs/develop/node/validator/hardware
