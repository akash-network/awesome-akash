# Logos Blockchain Node

Deploy a [Logos Blockchain](https://github.com/logos-blockchain/logos-blockchain) node on Akash Network.

Logos Blockchain is a privacy-preserving, censorship-resistant blockchain for decentralized network states. It combines zero-knowledge proofs, a mix network (Blend) for anonymity, and a modular service architecture.

## Quick Start

Deploy using the SDL in this directory. On first boot the node automatically:
1. Runs `logos-blockchain-node init` against the testnet bootstrap peers to generate `user_config.yaml`
2. Starts the node with that config

The generated config and all chain state are written to `/state`, which is mounted as a persistent volume so they survive pod restarts.

## Ports

| Port | Protocol | Exposed | Description |
|------|----------|---------|-------------|
| 8080 | TCP | No (localhost only) | HTTP API |
| 3000 | UDP | Yes | libp2p P2P networking |
| 3400 | UDP | Yes | Blend mix-network |

The HTTP API (8080) is intentionally not exposed publicly. To query it, exec into the running container:

```bash
curl http://localhost:8080/cryptarchia/info
```

Your node will be in `Bootstrapping` mode for a few minutes with `slot` and `height` steadily increasing. After that it moves to `Online` mode.

Compare against the fleet at the [Logos Testnet dashboard](https://testnet.blockchain.logos.co/web/).

## First-time Setup (setting the correct external IP)

The node needs to advertise its publicly reachable IP to the network. On Akash, the leased IP is not visible from inside the container (egress goes through the cluster IP, not the leased IP), so it must be set manually:

1. Deploy with `EXTERNAL_IP` left empty — the node starts with NAT traversal
2. Find the leased IP in the Akash Console
3. Back up the config: `base64 -w 0 /state/user_config.yaml`
4. Update the SDL: set `EXTERNAL_IP=<leased-ip>` and `USER_CONFIG_BASE64=<backup>`
5. Redeploy — `init` reruns with `--external-address /ip4/<leased-ip>/udp/3000/quic-v1`, keys restored from backup

From this point the IP is stable and restores work without any manual steps.

## Backup and Restore

`user_config.yaml` holds your node identity and wallet keys. It lives on the persistent volume but is lost if the lease is closed.

**Backup** — exec into the container and run:
```bash
base64 -w 0 /state/user_config.yaml
```

**Restore** — paste the base64 output into the `USER_CONFIG_BASE64` env var in the SDL before deploying. The startup script will write the config to disk instead of running `init`, preserving your node identity and keys.

## Getting Funds

Find your wallet key in the generated config:

```bash
grep -A3 known_keys /state/user_config.yaml
```

Then request tokens from the [testnet faucet](https://testnet.blockchain.logos.co/web/faucet/) (credentials from the Logos team via [Discord](https://discord.gg/logos-network)).

## Resources

The SDL provisions:
- 2 vCPU
- 4 Gi RAM
- 20 Gi persistent storage for chain state + config

Adjust these in `profiles.compute` to match your needs.
