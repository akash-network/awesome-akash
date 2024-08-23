# Dria Compute Node

A [Dria](https://dria.co/) Compute Node is a unit of computation within the Dria Knowledge Network. It's purpose is to process tasks given by the Dria Admin Node, and receive rewards for providing correct results.

## Setup

Check [dkn-compute-node](https://hub.docker.com/r/firstbatch/dkn-compute-node/tags) Docker repository to see if there is a new version and update `dkn` service `image`.

You need to provide an Ethereum wallet private key in `DKN_WALLET_SECRET_KEY` environment variable. The walelt address derived from this key represents your identity in Dria network.

You can also modify models supported by your node in `DKN_MODELS` environment variable. Consult the [guide](https://firstbatch.notion.site/How-to-Run-a-Node-ed2bef2c8eec4dd280286f2e081e51d2) to see the options.