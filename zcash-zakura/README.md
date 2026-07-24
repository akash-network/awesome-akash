# Zcash - Zakura

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://air.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-zcash-zakura)

Zakura is a Zcash full node written in Rust (forked from Zebra), with faster sync, native pruning, snapshot bootstrap, optional zcashd compatibility mode, and an experimental high-performance P2P stack.

Source: <https://github.com/zakura-core/zakura>  
Snapshots: <https://zakura.com/snapshots/>  
Docker: <https://hub.docker.com/r/zakuracore/zakura>

## What this template does

Deploys `zakuracore/zakura:1.0.3` on Akash with:

- Mainnet P2P on container port **8233** (provider maps a public high port)
- **Persistent** state volume at `/home/zebra/.cache/zakura`
- **Snapshot bootstrap** on first start when the volume is empty:
  1. Fetches a Valar Group `snapshots.json` manifest
  2. Selects the entry with role `latest` (configurable)
  3. Streams `tar.zst` into the cache dir
  4. Starts `zakurad` (via the image entrypoint) so the node continues from the snapshot height instead of genesis

### Default: pruned snapshot (quick tip sync)

| Setting | Default |
| --- | --- |
| Image | `zakuracore/zakura:1.0.3` |
| Network | Mainnet |
| Snapshot kind | `pruned` (~11 GiB download) |
| Manifest | `https://zakura.valargroup.dev/mainnet-pruned/snapshots.json` |
| Storage mode | `pruned` |
| Persistent disk | 50 GiB |
| CPU / RAM | 4 / 16 GiB |

Pruned snapshots keep consensus state and a retention window of blocks (not full history). Ideal for a validating node that only needs to stay near the tip.

### Archive snapshot (full history)

To bootstrap from the **archive** manifest the site documents as raw data  
(`https://zakura.valargroup.dev/mainnet/snapshots.json`, ~251 GiB):

1. Set env:
   - `SNAPSHOT_KIND=archive`
   - Remove or set `ZAKURA_STATE__STORAGE_MODE=archive`
2. Raise storage to **350 GiB+** (and prefer more RAM if possible)
3. Optionally set  
   `SNAPSHOT_MANIFEST_URL=https://zakura.valargroup.dev/mainnet/snapshots.json`

## Snapshot environment variables

| Variable | Default | Description |
| --- | --- | --- |
| `SNAPSHOT_ENABLE` | `true` | Set `false` to sync from genesis / existing peers only |
| `SNAPSHOT_KIND` | `pruned` | `pruned` or `archive` (selects default manifest URL) |
| `SNAPSHOT_ROLE` | `latest` | Manifest role: `latest`, `daily`, or `monthly` |
| `SNAPSHOT_NETWORK` | `mainnet` | Used in default manifest paths |
| `SNAPSHOT_MANIFEST_URL` | _(derived)_ | Override full manifest URL |
| `SNAPSHOT_URL` | _(empty)_ | Pin a specific tarball; skips manifest selection |
| `SNAPSHOT_SHA256` | _(empty)_ | Optional pin checksum (used with verify / `SNAPSHOT_URL`) |
| `SNAPSHOT_VERIFY` | `false` | If `true`, download fully and `sha256sum -c` before extract (needs extra free disk) |

Bootstrap is **idempotent**: if `state/` already exists or `.snapshot-bootstrap.json` is present on the volume, download is skipped.

Manifest fields used (from Valar JSON): `roles`, `height`, `size`, `sha256`, `filename`, `url` / `urls`, `snapshot_kind`.

## Other configuration

Zebra-style config via `ZAKURA_*` env vars (legacy `ZEBRA_*` is translated by the image entrypoint):

| Variable | Purpose |
| --- | --- |
| `ZAKURA_NETWORK__NETWORK` | `Mainnet` / `Testnet` |
| `ZAKURA_NETWORK__LISTEN_ADDR` | P2P bind (default `[::]:8233`) |
| `ZAKURA_NETWORK__EXTERNAL_ADDR` | Public `host:port` if peers should dial you |
| `ZAKURA_STATE__CACHE_DIR` | Must match the storage mount |
| `ZAKURA_STATE__STORAGE_MODE` | `pruned` or `archive` |
| `ZAKURA_RPC__LISTEN_ADDR` | Enable JSON-RPC (off by default) |
| `ZAKURA_METRICS__ENDPOINT_ADDR` | Prometheus (optional) |
| `ZAKURA_HEALTH__LISTEN_ADDR` | `/healthy` and `/ready` (optional) |

## Testnet

Uncomment the Testnet network env vars and P2P port **18233** in `deploy.yaml`. Point manifests with `SNAPSHOT_NETWORK=testnet` if Valar publishes testnet snapshots at the same layout.

## Notes

- Akash does **not** bind your service to the literal public port 8233; check the lease URI for the published host:port. Set `ZAKURA_NETWORK__EXTERNAL_ADDR` to that endpoint if you want better inbound peer reachability.
- Pruned mode is one-way: you cannot reopen a pruned DB as archive without resyncing.
- Image starts as root only long enough for volume ownership, then drops to UID **10001** (`zebra`) via `entrypoint.sh`.
- For zcashd wallet/RPC compatibility, see Zakura’s [zcashd-compat](https://github.com/zakura-core/zakura/blob/main/book/src/user/zcashd-compat.md) docs (not enabled in this template).
