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

**Ports:** container `8080` / `9067` / `18232` / `18233` stay inside the pod. This SDL does not request a dedicated IP. TCP `global: true` exposes become **random high ports** on the provider host. The dashboard (`8080 as 80` + `http_options`) is usually an **ingress hostname**. **Leases → URIs** is the public address for each service.

After deploy, open the **`app` URI** from the lease. That is the dashboard and HTTP API. The stack self-bootstraps: `ths-server init` once on the wallet volume, then `serve` retries until Zakura RPC and lightwalletd answer.

1. **Dashboard / API** — `app` URI (ingress). Browser.
2. **lightwalletd** — `lightwalletd` URI (`host:<random-port>`, TLS off).
3. **Zakura JSON-RPC** — `zakura` URI for the 18232 expose (`host:<random-port>`).

Images are **v0.4.1** (`thus-spoke-zakura-app` and `thus-spoke-zakura-lightwalletd`). Zakura is `zakuracore/zakura:1.6.0`, the pin compiled into the 0.4.1 launcher.

## Relation to the production templates

- **Zcash - Zakura** / **Zcash - Zebra** are Mainnet (or Testnet) validating nodes with optional snapshot bootstrap and a colocated lightwalletd for real wallets.
- **This template** is a short-lived Regtest lab. It is not a Mainnet node.

## Resources

Default: 2 CPU / 8 GiB RAM / 20 GiB for Zakura; smaller sidecar disks for LWD and the dashboard.

## Links

- Book: <https://github.com/zcashlabs/thus-spoke-zakura/tree/main/book>
- ZecHub Akash guides: <https://zechub.wiki/guides/akash-network-zebra>
