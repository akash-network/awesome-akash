# Dria Compute Node

[Dria](https://dria.co/) unites consumer hardware to generate high-quality, high-throughput, low-cost synthetic data. [Dria Knowledge Network](https://dria.co/edge-ai) is a decentralized network that allows many AI agents to collaborate on tasks that improve AI/ML models with synthetic data.

A [Dria Compute Node](https://github.com/firstbatchxyz/dkn-compute-node) is a unit of computation within the Dria Knowledge Network, and it serves local / API-based LLMs to handle tasks within the network, and get rewards for it.

## Setup

Check [dkn-compute-node](https://hub.docker.com/r/firstbatch/dkn-compute-node/tags) Docker repository to see if there is a new version and update `dkn` service `image`.

You need to provide an Ethereum wallet private key in `DKN_WALLET_SECRET_KEY` environment variable. The walelt address derived from this key represents your identity in Dria network.

You can also modify models supported by your node in `DKN_MODELS` environment variable. Consult the [guide](https://firstbatch.notion.site/How-to-Run-a-Node-ed2bef2c8eec4dd280286f2e081e51d2) to see the options.

Make sure your node follows resource recommendations in [Minimum Specs](https://github.com/firstbatchxyz/dkn-node-specs) guide.
