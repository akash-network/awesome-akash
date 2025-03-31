# Codex

This deployment only deploys Codex the node, refer to [codex/full](../codex/full/) for full setup.

[Codex](https://codex.storage) is a durable, decentralised storage protocol designed to safeguard the world's most valuable information. Join the testnet to help secure a resilient digital future.

Codex recently announced launch of `testnet` - please follow a [Discord](https://discord.gg/codex-storage) guide to participate!

## Deploy

You will need to provide a `PRIV_KEY` and `PUBLIC_IP` environment variables in the deployment.

Private key is any Ethereum Wallet private key (keep in mind the security risks of pasting your key into an Akash deployment manifest!). You can generate one using any wallet or by using a CLI command

```
openssl rand --hex 32
```

The environment variable `PUBLIC_IP` refers to the public IP of the deployment - once you perform initial deployment (with empty `PUBLIC_IP`), check the assigned IP and update the deployment, so that other nodes in the network can connect to your node.
