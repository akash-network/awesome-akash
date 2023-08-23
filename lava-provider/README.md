![image](https://user-images.githubusercontent.com/23629420/219872517-2adc32b1-5f64-4d48-9a81-1e2ef6b01a53.png)

# Deploy Lava Provider

The launch is described using CloudFlare!

## Step 1 (Deploy)

> "How to use?" CloudMos guide: https://github.com/DecloudNodesLab/Guides/blob/main/English/Cloudmos.md

Deploy https://gitopia.com/DecloudNodesLab/cosmos-universe/tree/master/projects/Lava/lava_provider_deploy.yml .

Set  variables `SSH_PASS`, `MNEMONIC_BASE64`, `CONFIG_LINK`, `LAVAD_NODE` and `LAVAD_GEOLOCATION`.

![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/2c56f21b-7ef3-41aa-a665-2460ca261865)

Select provider.

![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/cb1f53a0-286c-465f-9dd9-4a3948579570)

## Step 2 (CloudFlare)

Go to https://dash.cloudflare.com/ , select your domain name.

In left menu:

- Add "DNS" records TYPE - A, NAME - \<SUBDOMAIN\>, CONTENT - <YOUR_LEASE_IP_FROM_DEPLOY>

![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/774d791c-afdf-4724-973f-0c16504154cf)

- Check "SSL/TLS-Overwiew", need select Full mode (not Full(strict)).

![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/0f57098f-bc61-4093-8cd5-3136d072e073)

- In "Network" enable "gRPS" connection.

![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/b9fc19e0-0015-4484-838d-e764672e6c95)

## Step 3 (run rpcprovider)

After that, it will be convenient to connect to the node via **ssh**.

Run test command:

`lavad test rpcprovider --from $ADDRESS --keyring-backend test --node $LAVAD_NODE --endpoints "<YOUR_SUBDOMAIN.DOMAIN>:443,<CHAIN>"`

Example correct result:

![image](https://github.com/DecloudNodesLab/Projects/assets/23629420/c67de1a0-0099-4a07-9db2-6446290302d0)

Run stake command:

```
lavad tx pairing stake-provider "<CHAIN>" "<AMOUNT_STAKE>ulava" "lava.declab.pro:443,2" 2 --chain-id $CHAIN_ID --from $ADDRESS --provider-moniker <YOUR_MONIKER> --keyring-backend "test" --gas="auto" --gas-adjustment "1.5" --fees 50000ulava --node $LAVAD_NODE -y
```


____

Decloud Nodes Lab

Professional decentralized validator powered by Akash Network.

Site: https://declab.pro

E-mail: decloudlab@gmail.com

Discord: https://discord.gg/rPENzerwZ8
