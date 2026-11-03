# Thus Spoke Zakura (Regtest)

**Web payments:** [Console](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-thus-spoke-zakura) (`console.akash.network`) — traditional web checkout.

**Native Akash payments (Keplr):** [Air](https://air.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-thus-spoke-zakura) (`air.akash.network`).

Disposable **Zcash Regtest** stack matching the local [`ths`](https://github.com/zcashlabs/thus-spoke-zakura) launcher: Zakura + lightwalletd + the Thus Spoke Zakura dashboard/API.

Test coins have no value. Do not send mainnet ZEC to addresses this environment prints.

Upstream: <https://github.com/zcashlabs/thus-spoke-zakura> (v0.4.1)

## What you get

| Service | Image | Port (container) | Purpose |
| --- | --- | --- | --- |
| `app` | `ghcr.io/zcashlabs/thus-spoke-zakura-app:0.4.1` | 8080 → public 80 | Dashboard + HTTP API |
| `zakura` | `zakuracore/zakura:1.6.0` (ths 0.4.1 pin) | 18232 RPC, 18233 P2P | Regtest consensus |
| `lightwalletd` | `ghcr.io/zcashlabs/thus-spoke-zakura-lightwalletd:0.4.1` | 9067 | CompactTxStreamer gRPC |

Akash maps each expose to a random high port on the provider. Use the lease URIs.

After deploy, open the **`app` service URI** (container 8080 published as 80). That is the Thus Spoke Zakura dashboard and HTTP API. The stack self-bootstraps: `ths-server init` runs once on the wallet volume, then `serve` retries until Zakura RPC and lightwalletd answer.

Also published:

1. **Dashboard / API** — `app` URI (port 80 mapping). Use this in a browser.
2. **lightwalletd** — `lightwalletd` URI (9067 mapping, TLS off) for compact clients.
3. **Zakura JSON-RPC** — `zakura` URI (18232 mapping) for `ths rpc`-style calls.

Images are **v0.4.1** (`thus-spoke-zakura-app` and `thus-spoke-zakura-lightwalletd`). Zakura is `zakuracore/zakura:1.6.0`, the pin compiled into the 0.4.1 launcher.

## Relation to the production templates

- **Zcash - Zakura** / **Zcash - Zebra** are Mainnet (or Testnet) validating nodes with optional snapshot bootstrap and a colocated lightwalletd for real wallets.
- **This template** is a short-lived Regtest lab. It is not a Mainnet node.

## Resources

Default: 2 CPU / 8 GiB RAM / 20 GiB for Zakura; smaller sidecar disks for LWD and the dashboard.

## Links

- Book: <https://github.com/zcashlabs/thus-spoke-zakura/tree/main/book>
- ZecHub Akash guides: <https://zechub.wiki/guides/akash-network-zebra>
