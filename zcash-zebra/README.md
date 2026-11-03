# Zcash - Zebra

**Web payments:** [Console](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-zcash-zebra) (`console.akash.network`) — traditional web checkout.

**Native Akash payments (Keplr):** [Air](https://air.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-zcash-zebra) (`air.akash.network`).

Zebra is the Zcash Foundation’s Rust full node (`zebrad`). This template deploys **Zebra 7.0.0** on Akash with persistent state, env-based configuration, Prometheus/health endpoints, and a colocated lightwalletd.

Source: <https://github.com/ZcashFoundation/zebra>  
Docker: <https://hub.docker.com/r/zfnd/zebra>  
ZecHub Akash guide: <https://github.com/ZecHub/zechub/blob/main/site/guides/Akash_Network_zebra.md>

## Defaults

| Item | Value |
| --- | --- |
| Image | `zfnd/zebra:7.0.0` (digest-pinned) |
| Network | Mainnet |
| P2P | container `8233` (`global: true` → random high port on the lease URI) |
| State mount | `/home/zebra/.cache/zebra` (persistent, 350 GiB) |
| CPU / RAM | 4 / 16 GiB |

Config is entirely via `ZEBRA_SECTION__KEY` environment variables (see [zebrad config](https://docs.rs/zebrad/latest/zebrad/config/struct.ZebradConfig.html)). The image entrypoint creates cache dirs and drops to UID **10001**.

## Why this layout

- **Persistent volume** — without `persistent: true`, a redeploy or restart can wipe the chain DB and force a full resync.
- **No `zebrad generate` TOML** — 6.x loads env vars natively; generating a file only risks stale/deprecated keys.
- **Env scrub** — drops bare `ZEBRA_*` keys (no `__`) that break config-rs if a host injects them; keeps valid `ZEBRA_SECTION__KEY` settings.
- **`MAX_CONNECTIONS_PER_IP=8`** — Akash’s reverse proxy often presents many peers as one source IP; the default of `1` starves connectivity.
- **`CHECKPOINT_SYNC=true`** — faster initial sync under checkpoint trust (Zebra default, set explicitly).

## Common tweaks

**Public reachability** — copy the P2P line from **Leases → URIs** (a random high port, not 8233) and set:

```yaml
- "ZEBRA_NETWORK__EXTERNAL_ADDR=<provider-host>:<mapped-p2p-port>"
```

This template does not request a dedicated IP. That is a paid `endpoints.kind: ip` extra if you want a stable public `host:8233`.

**RPC** is on internally for lightwalletd (`ZEBRA_RPC__ENABLE_COOKIE_AUTH=false`). Keep the 8232 expose `global: false`.

**Feature flags** — `ENABLE_METRICS`, `ENABLE_HEALTH`, `ENABLE_RPC`, `ENABLE_LIGHTWALLETD` (`true`/`false`). The start script applies them before `zebrad start`.

**lightwalletd** — `electriccoinco/lightwalletd:v0.6.1` on container port 9067 (global). Wallets use the mapped lease URI. For a Regtest dashboard stack, see **Thus Spoke Zakura**.

**Testnet** — switch network env, listen addr `18233`, P2P expose, and you can drop storage toward ~50 GiB.

**Metrics / health** — optional `ZEBRA_METRICS__ENDPOINT_ADDR` / `ZEBRA_HEALTH__LISTEN_ADDR` (ports 9999 / 8080 in the SDL comments).

## Notes

- Initial Mainnet sync still takes substantial time and bandwidth; plan for the full 350 GiB disk as the state grows.
- For a faster tip-oriented node with snapshot bootstrap, see the **Zcash - Zakura** template in this repo.
- zcashd-compat supervised mode exists upstream (`zfnd/zebra` compat tags / `--zcashd-compat`); this template runs plain Zebra only.
