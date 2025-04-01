# Codex

[Codex](https://codex.storage) is a durable, decentralised storage protocol designed to safeguard the world's most valuable information. Join the testnet to help secure a resilient digital future.

Codex recently announced launch of `testnet` - please follow a [Discord](https://discord.gg/codex-storage) guide to participate!

## Deploy

This template deploys 3 services inside the deployment:

* Codex node
* Codex App (allows you to interact with your Codex node via UI)
* Nginx (allows you to interact with the UI and node REST API securely via encrypted connection and with authentication)

### Codex Node

You will need to provide a `PRIV_KEY` and `PUBLIC_IP` environment variables in the deployment.

Private key is any Ethereum Wallet private key (keep in mind the security risks of pasting your key into an Akash deployment manifest!). You can generate one using any wallet or by using a CLI command

```
openssl rand --hex 32
```

The environment variable `PUBLIC_IP` refers to the public IP of the deployment - once you perform initial deployment (with empty `PUBLIC_IP`), check the assigned IP and update the deployment, so that other nodes in the network can connect to your node.

### Reverse Proxy

We use Nginx as a reverse proxy to add authentication to both Codex App and Codex Node REST API. The reverse proxy is configured with basic auth credentials provider in environment variables    `BASIC_AUTH_USER` and `BASIC_AUTH_PASS`. Make sure you change the password!

You are also expected to provide a DNS name in `DOMAIN` environment variable. The domain name must point to the IP address configured in`PUBLIC_IP`. Setting this environment variable will use Let's Encrypt to generate SSL certificates to enable secure communication between your machine, Codex App and Codex Node REST API. Otherwise all communication is unencrypted - including the authentication credentials!

You will be able to access your Codex App at `https://${DOMAIN}` and REST API at `https://${DOMAIN}/api` after successfuly deployment.