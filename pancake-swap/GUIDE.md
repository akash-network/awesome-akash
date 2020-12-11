# Deploying Serum Dex on Akash

This is a guide to deploying [Pancake Swap Interface](https://github.com/pancakeswap/pancake-swap-interface) on [Akash](https://akash.network) in a non-custodial way. Akash is a permissionless and censorship-resistant cloud network that guarantees sovereignty over your data and your applications. With Akash, you’re in complete control of all aspects of the life cycle of an application with no middleman.

## Before We Begin

This is a technical guide, best suited to a reader with basic Linux command line knowledge. The audience for this guide is intended for includes:

* Application developers with little or no systems administration experience, wanting to deploy applications on the decentralized cloud.
* System administrators with little or no experience with infrastructure automation, wanting to learn more.
* Infrastructure automation engineers that want to explore decentralized cloud.
* Anyone who wants to get a feel for the current state of the decentralized cloud ecosystem.

You will need the below setup before we being:

1) Install Akash: Make sure to have Akash client installed on your workstation, check [install guide](https://docs.akash.network/guides/install) for instructions.
2) Choose Your Akash Network: You'll need to know information about the network you're connecting your node to. See [Choosing a Network](https://docs.akash.network/guides/version) for how to obtain any network-related information.
3) Fund Your Account: You'll need a AKT wallet with funds to pay for your deployment. See the [funding guide](https://docs.akash.network/guides/funding)
creating a key and funding your account.
4) Install Docker: You'll need docker running on your workstation, follow this [guide](https://docs.docker.com/get-docker/) to setup Docker on your workstation..
5) Setup Container Registry: To stage your containers to deploy onto Akash. We'll Docker Hub in this guide. [Signup](https://docs.docker.com/docker-hub/) for a free Docker Hub account if you haven't.
6) Setup Builpacks.io: Builpacks.io is a Cloud Native Buildpacks transform your application source code into images that can run on any cloud. Install `pack` tool using this [guide](https://buildpacks.io/docs/tools/pack/#install).

### Set up your Environment

We will be using shell variables throughout this guide for convenience and clarity.  Ensure you have the below set of variables defined on your shell, you can use `export VARNAME=...`:

|Name|Description|
|---|---|
|`AKASH_NODE`| Akash network configuration base URL. See [here](/guides/version.md).|
|`AKASH_CHAIN_ID`| Chain ID of the Akash network connecting to. See [here](/guides/version.md).|
|`ACCOUNT_ADDRESS`| The address of your account.  See [here](/guides/wallet/README.md#account-address).|
|`KEY_NAME` | The name of the key you will be deploying from. See [here](/guides/wallet/README.md) if you haven't yet setup a key|

Verify you have correct `$AKASH_NODE`, that you have populated while [configuring the connection](/guides/version) using `export AKASH_NODE=$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)`.

```sh
echo $AKASH_NODE $AKASH_CHAIN_ID
```

You should see a response similar to:

```
tcp://rpc-edgenet.akashdev.net:2665 akash-edgenet-1
```

Your values may differ depending on the network you're connecting to, `tcp://rpc-edgenet.akashdev.net:2665` and `akash-edgenet-1` are details for [edgenet](https://github.com/ovrclk/net/tree/master/edgenet).

Verify you have the key set up and your account has sufficient balances, see the [funding guide](/guides/wallet/funding.md) otherwise:

My local key is named `alice`, the below command should return the name you've used:

```sh
echo $KEY_NAME 
```
The above should return a response similar to:

```
alice
```

Populate `ACCOUNT_ADDRESS` from `KEY_NAME` and verify:

```sh
export ACCOUNT_ADDRESS="$(akash keys show $KEY_NAME -a)"

echo $ACCOUNT_ADDRESS

akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx
```

Check your account has sufficient balance by running:

```sh
akash query bank balances --node $AKASH_NODE $ACCOUNT_ADDRESS
```

You should see a response similar to:

```
balances:
- amount: "93000637"
  denom: uakt
pagination:
  next_key: null
  total: "0"
```

Please note the balance indicated is is denominated in uAKT (AKT * 10^-6), in the above example, the account has a balance of *93 AKT*. We're now setup to deploy.

## Create the Deployment

Create a deployment configuration `deploy.yaml` to deploy the `yuravorobei/pancake-swap` for [Pancake Swap Interface](https://github.com/pancakeswap/pancake-swap-interface) Node JS app container using [SDL](https://docs.akash.network/documentation/sdl):

```sh
cat > deploy.yaml <<EOF
---
version: "2.0"

services:
  web:
    image: yuravorobei/pancake-swap
    expose:
      - port: 8080
        as: 80
        to:
          - global: true

profiles:
  compute:
    web:
      resources:
        cpu:
          units: 0.1
        memory:
          size: 512Mi
        storage:
          size: 1Gi
  placement:
    westcoast:
      signedBy:
        anyOf:
          - "akash1vz375dkt0c60annyp6mkzeejfq0qpyevhseu05"
      pricing:
        web: 
          denom: uakt
          amount: 3000

deployment:
  web:
    westcoast:
      profile: web
      count: 1
```

Alternatively, you can use cURL to download:

```
curl -s https://raw.githubusercontent.com/ovrclk/awesome-akash/master/pancake-swap/deploy.yaml > deploy.yaml
```

You may use the sample deployment file as-is or modify it for your own needs as desscribed in our [SDL (Stack Definition Language](https://docs.akash.network/documentation/sdl) documentation. 

{% hint style="warn" %}

Please note if you are running on the testnet, you are limited in the amount of testnet resources you may request. 

{% endhint %}

To deploy on Akash, run:

```sh
akash tx deployment create deploy.yaml --from $KEY_NAME --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --fees 5000uakt -y
```

In this step, you post your deployment, the Akash marketplace matches you with a provider via auction. To create a deployment use akash deployment. The syntax for the deployment is `akash tx deployment create <config-path> --from <key-name>`.


You can check the status of your lease by running:

```
akash query market lease list --owner $ACCOUNT_ADDRESS --node $AKASH_NODE --state active

```

```yaml
- lease_id:
    dseq: "115884"
    gseq: 1
    oseq: 1
    owner: akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx
    provider: akash1y8xhp9ekxctahvex7842h607lmwp50q0n89tw0
  price:
    amount: "51"
    denom: uakt
  state: active
pagination:
  next_key: null
  total: "0"
```
In the above example, we can see that a lease is created using for *51 uakt* or *0.0000051 AKT* per block to execute the container.

For convenience and clarity for future referencing, we can extract the below set of values to shell variables that we will be using to reference the deployment:

| Attribute | Value |
| --- | --- |
| `PROVIDER` | `akash1y8xhp9ekxctahvex7842h607lmwp50q0n89tw0` |
| `DSEQ` | `115884` |
| `OSEQ` | `1` |
| `GSEQ` | `1` |

Verify we have the right values populated by running:

```sh
echo $PROVIDER $DSEQ $OSEQ $GSEQ
```

You should see a response similar to:

```
akash1y8xhp9ekxctahvex7842h607lmwp50q0n89tw0 115884 1 1
```

Upload the manifest using the values from above step:

```sh
akash provider send-manifest deploy.yaml --node $AKASH_NODE --dseq $DSEQ --oseq $OSEQ --gseq $GSEQ --owner $ACCOUNT_ADDRESS --provider $PROVIDER 
```

Your image is now deployed, once you uploaded the manifest. You can retrieve the access details by running the below:

```sh
akash provider lease-status --node $AKASH_NODE --dseq $DSEQ --oseq $OSEQ --gseq $GSEQ --provider $PROVIDER --owner $ACCOUNT_ADDRESS
```

You should see a response similar to:

```json
{
  "services": {
    "web": {
      "name": "web",
      "available": 1,
      "total": 1,
      "uris": [
        "phzz2bcjjoz7jhvderxo5d.provider1.akashdev.net"
      ],
      "observed-generation": 0,
      "replicas": 0,
      "updated-replicas": 0,
      "ready-replicas": 0,
      "available-replicas": 0
    }
  },
  "forwarded-ports": {}
}
```

You can access the application by visiting the hostnames mapped to your deployment. In above example, its http://phzz2bcjjoz7jhvderxo5d.provider1.akashdev.net

## Service Logs

You can view the logs for your applicaiton using `akash provider service-logs`, for example:

```sh
akash provider service-logs --node $AKASH_NODE --dseq $DSEQ --oseq $OSEQ --gseq $GSEQ --provider $PROVIDER --owner $ACCOUNT_ADDRESS --service web
```

You should see a response similar to:

```
[web-7447d7769-c6t4f] yarn run v1.22.10
[web-7447d7769-c6t4f] $ /workspace/node_modules/.bin/serve build
[web-7447d7769-c6t4f] INFO: Accepting connections at http://localhost:5000
```

## Close your deployment

When you are done with your application, close the deployment. This will deprovision your container and stop the token transfer. Close deployment using deployment by creating a `deployment-close` transaction:

```sh
akash tx deployment close --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --dseq $DSEQ --owner $ACCOUNT_ADDRESS --from $KEY_NAME -y --fees 5000uakt
```
Additionally, you can also query the market to check if your lease is closed:

```sh
akash query market lease list --owner $ACCOUNT_ADDRESS --node $AKASH_NODE 
```
You should see a response similar to:

```yaml
leases:
- lease_id:
    dseq: "115884"
    gseq: 1
    oseq: 1
    owner: akash1j8s87w3fctz7nlcqtkl5clnc805r240443eksx
    provider: akash1y8xhp9ekxctahvex7842h607lmwp50q0n89tw0
  price:
    amount: "186"
    denom: uakt
  state: closed
pagination:
  next_key: null
  total: "0"
```