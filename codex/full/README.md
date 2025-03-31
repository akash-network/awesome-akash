# Codex

This template provides full setup of Codex node and Codex App with basic authentication. Refer to [codex-node](../codex-node/) for basic node deployment.

[Codex](https://codex.storage) is a durable, decentralised storage protocol designed to safeguard the world's most valuable information. Join the testnet to help secure a resilient digital future.

Codex recently announced launch of `testnet` - please follow a [Discord](https://discord.gg/codex-storage) guide to participate!

## Deploy

### Codex Node

You will need to provide a `PRIV_KEY` and `CODEX_NAT` environment variables in the deployment.

Private key is any Ethereum Wallet private key (keep in mind the security risks of pasting your key into an Akash deployment manifest!). You can generate one using any wallet or by using a CLI command

```
openssl rand --hex 32
```

The environment variable `CODEX_NAT` refers to the public IP of the deployment - once you perform initial deployment (with empty `CODEX_NAT`), check the assigned IP and update the deployment, so that other nodes in the network can connect to your node.

### Reverse Proxy

We use Nginx as a reverse proxy to add authentication to both Codex App and Codex Node REST API. The reverse proxy is configured with basic auth credentials provider in environment variables    `BASIC_AUTH_USER` and `BASIC_AUTH_PASS`. Make sure you change the password!

There is also an environment variable `DOMAIN` which should be set to your domain name (e.g., mycodexstorage.com). Setting this environment variable will also use Let's Encrypt to generate SSL certificates to enable secure communication between your machine, Codex App and Codex Node REST API.