# NEAR Node
[NEAR](https://near.org/) is a development
platform built on a layer-one blockchain. There are
[three different types of NEAR nodes](https://docs.near.org/docs/develop/node/intro/node-types),
and you can run them all on Akash in a single set of deployment files.

## Quick start
Simply use [deploy.yaml](deploy.yaml) as your Akash SDL file. By default, it
runs a mainnet RPC node. Of course, you can change the environment variables 
in the file to run a different type of node. As in any other SDL file, you
can change the resources and pricing as well. There are several methods to
deploy on Akash (i.e. GUI, CLI, and web app). Check out the
[deployment guide](https://docs.akash.network/guides) for more information.

## Features
* Super-fast blockchain data download using [aria2](https://aria2.github.io/).
* Supports all types of NEAR nodes.
* Supports custom INIT commands.
* Simple yet powerful configuration options.
* [Dockerfile](Dockerfile) and [run.sh](run.sh) are included for easy future
update and maintenance.
  
## Demo Video
Running a NEAR node on Akash using Akashlytics:

https://www.youtube.com/watch?v=lDsSuQoPpIc

## Configuration
If you're about to run something rather than a mainnet RPC node, you need to
edit [deploy.yaml](deploy.yaml) to change some environment variables. There
are four main variables you may change:

* **CHAIN_ID**: selects the network (available options: mainnet (default) /
  testnet / localnet)
* **ACCOUNT_ID**: your staking pool account name if this is a validator node
  (leave it empty otherwise)
* **DISABLE_RPC**: set to `true` if you want to disable RPC (leave it empty
  otherwise)
* **ARCHIVE**: set to `true` if this is an archive node (leave it empty
  otherwise)
  
### Example configurations

Here are some example configurations to make things easier.

#### Mainnet archive node without RPC

```
CHAIN_ID=
ACCOUNT_ID=
DISABLE_RPC=true
ARCHIVE=true
```

#### Testnet validator with RPC (no archiving)

```
CHAIN_ID=testnet
ACCOUNT_ID=icanblowlikeelephantsdo.pool.f863973.m0
DISABLE_RPC=
ARCHIVE=
```

Note: You should change `ACCOUNT_ID` to your own staking pool. You can create
a staking pool by following the
[official guide](https://wiki.near.org/network/validator-guides/running-a-validator#deploy-the-staking-pool).
You can find your validator key at `/srv/near/validator_key.json` inside the
container. You can run
`akash provider lease-shell --from <key-name> --dseq <dseq-number> --provider=<provider-address> near cat /srv/near/validator_key.json`
with your own variables to access it. You may want to learn more about how to
[execute a shell command](https://docs.akash.network/release-notes/v0.14.0#remote-shell-command-execution)
and how to
[access shell](https://docs.akash.network/release-notes/v0.14.0#access-the-deployment-shell-cli)
on Akash deployments.

## Notes
* When the container is deployed for the first time, it starts to download
the huge data file for testnet/mainnet. It takes some time for the node to
be ready. You can [check the logs](https://docs.akash.network/guides/cli/part-10.-send-the-manifest#view-your-logs)
to track the progress.
  
* Make sure your SDL resources configuration meets the
[recommended hardware specification](https://docs.near.org/docs/develop/node/validator/hardware#recommended-hardware-specifications)
or you might face problems.

## Maintenance
When you build an image from the [Dockerfile](Dockerfile), it automatically
checks for the latest stable version of NEAR core, so if NEAR is updated to
a new version in future, all you have to do is to rebuild the image with
[docker build](https://docs.docker.com/engine/reference/commandline/build/).

The customized [run.sh](run.sh) script takes care of all manual node setup.
Everything will be fine unless there is a big fundamental change in NEAR.
