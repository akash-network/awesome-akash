# What is Radicle?

[Radicle](https://radicle.xyz/) is an open source, peer-to-peer code collaboration stack built on Git. Unlike centralized code hosting platforms, there is no single entity controlling the network. Repositories are replicated across peers in a decentralized manner, and users are in full control of their data and workflow.

This manifest deploys Radicle Seed node. Seeds host the repositories and hence are the backbone of the network.

The container images deployed is based on [radicle-docker](https://app.radicle.xyz/nodes/seed.radicle.garden/rad:zNd4qti1Jc69mCBQAdBeK3Avzy4R/tree/Dockerfile) and hosted on [Quay.io](https://quay.io/repository/vpavlin0/radicle-seed?tab=tags)

## Setup
The deployment does not seed any repositories by default - you can explicitly enable them via `$RAD_SEEDS` environment variable which accepts a semicolon (`;`) separated list of Radicle repository IDs.

Akash Network exposes your service on a random port which is then forwarded to the port selected in the manifest (i.e. `8776`). For your node to be disoverable you will need to

1. Find the random port assigned to your deployment
2. Update the `RAD_EXTERNAL_ADDR` variable with the public address and port (e.g. `RAD_EXTERNAL_ADDR=provider.url:65432`).

The deployment also allows enable radicle-httpd HTTP API server by setting `RAD_HTTP_ENABLE` to `true`. If ythe API is enabled, you can also pin repositories which will show up when you call `GET /api/v1/repos` by listing them in `RAD_PINNED_REPOS` (separated by `;`). Pinned repositories are also automatically seeded.

## Usage

You can simply seed existing repositories, but you can also use your node to publish your own Git repos. To connect to your node, you will need to know the external addres and Node ID, which can be found at the start of the logs or by running the following command in the deplyoment console.

```
rad self --nid
```