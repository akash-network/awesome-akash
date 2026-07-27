# Ollama in a Trusted Execution Environment (TEE)

Run a private LLM inference endpoint on Akash inside a hardware-backed confidential computing environment.

This template deploys [Ollama](https://ollama.com) with `llama3.2:3b` on a GPU, with a single extra line of SDL — `params.tee: cpu-gpu` — that tells the Akash marketplace to place the workload only on providers capable of confidential compute. The container then runs inside a Kata Containers micro-VM with the CPU TEE active (AMD SEV-SNP or Intel TDX, depending on the provider's hardware) and the GPU in NVIDIA Confidential Computing mode.

The point of the demo: **nothing about your container changes.** Same image, same API, same `curl`. The only difference is where and how it executes.

## What TEE gives you here

| Layer | Protection |
| --- | --- |
| Guest memory | Encrypted by the CPU's memory encryption engine; not readable by the host OS, hypervisor, or provider operator |
| CPU↔GPU (PCIe) | All DMA traffic, CUDA kernels, and command buffers encrypted with AES-GCM-256 |
| GPU state | Performance counters disabled, internal firewalls active |
| Isolation | Dedicated kernel per workload in a micro-VM, rather than a shared-kernel container |

In practical terms: your prompts, your completions, and the model weights in flight are not visible to the machine's operator.

## How the SDL requests it

```yaml
services:
  ollama:
    image: ollama/ollama:latest
    params:
      tee: cpu-gpu
```

Rules to know:

- `tee` accepts `cpu` (CPU-only confidential compute) or `cpu-gpu`.
- `cpu-gpu` **requires** GPU resources in the compute profile — the SDL parser rejects it otherwise. A GPU TEE has no meaning without a CPU TEE, since the CPU TEE is the GPU's trust anchor.
- Every service in a deployment group must use the same TEE type, or none at all. Mixed types are rejected.
- You don't need to add a placement attribute yourself. The SDL builder converts the `tee` value into a placement requirement, and only providers advertising that capability will bid.

## Requirements

- A funded Akash wallet and a deployment certificate. [Akash Console](https://console.akash.network) handles both, including the ACT top-up used to pay lease invoices.
- Leases are priced in `uact`. Raise `amount` in the placement block if your bid ceiling is too low to attract bids.
- A TEE-capable provider must be online with a matching GPU. This is a small subset of the network today, so **no bids is the most likely failure mode** — see [Troubleshooting](#troubleshooting).

## Deploy

**Akash Console** — go to [console.akash.network](https://console.akash.network), choose *Build your template*, paste in `deploy.yaml`, and deploy.

**CLI**

```bash
provider-services tx deployment create deploy.yaml \
  --from <your-key> \
  --node https://rpc.akashnet.net:443 \
  --chain-id akashnet-2 \
  --gas-prices 0.025uakt --gas auto --gas-adjustment 1.5
```

Then bid, lease, and send the manifest as usual — see the [CLI deployment guide](https://akash.network/docs/deployments/akash-cli/overview/).

## Get your endpoint

The SDL exposes port `11434` globally. The provider maps it to a random external port, so you need to read the assigned URI after the lease is active.

Console: open the deployment, then the **Leases** tab. The endpoint appears as `http://<provider-host>:<port>`.

CLI:

```bash
provider-services lease-status \
  --dseq <DSEQ> --provider <PROVIDER> --from <your-key> \
  | jq -r '.forwarded_ports.ollama[0] | "http://\(.host):\(.externalPort)"'
```

## Test it

The container pulls `llama3.2:3b` on startup, so give it a minute or two before the first request. Replace the host and port below with your own endpoint:

```bash
curl http://<your-host>:<your-port>/api/generate -d '{
  "model": "llama3.2:3b",
  "prompt": "Which continent is the USA in?",
  "stream": false
}'
```

```json
{
  "model": "llama3.2:3b",
  "created_at": "2026-07-27T17:14:48.038986841Z",
  "response": "The United States of America (USA) is located on the continent of North America."
}
```

Check that the model finished downloading with `/api/tags`, which lists what's available locally:

```bash
curl http://<your-host>:<your-port>/api/tags
```

## Customizing

**Different model** — edit the `ollama pull` line in `args`. Size the GPU and memory to match; `llama3.2:3b` is deliberately small so the demo starts fast.

**CPU-only confidential compute** — set `tee: cpu` and remove the `gpu` block from the compute profile.

**Bid ceiling** — raise `amount` in the placement block if you aren't getting bids. Lease pricing is denominated in `uact` (1 ACT = 1,000,000 uact).

### About the startup command

The `command`/`args` block does something worth explaining, since it isn't Ollama's default behavior:

```bash
/bin/ollama serve &                                   # start the server in the background
until /bin/ollama ps >/dev/null 2>&1; do sleep 1; done # wait for it to accept connections
/bin/ollama pull llama3.2:3b                           # pull the model
wait                                                   # hand the container back to the server
```

Ollama's CLI needs a running server to pull against, so the server starts first and the script polls until it's ready. `wait` keeps the container alive on the server process.

## Limitations and honest caveats

**This template requests confidential compute — it does not attest to it.** Requesting a TEE gets you micro-VM isolation and marketplace placement on a TEE-capable provider. Proving cryptographically that your workload is running in a genuine, untampered TEE requires remote attestation from inside the VM, which produces a signed token you can present to a relying party. That flow is out of scope here. For production use, run the [Intel Trust Authority client](https://docs.trustauthority.intel.com) inside the container to collect CPU and GPU evidence and obtain a composite attestation token.

**Throughput ceiling on Hopper.** On H100/H200, CPU↔GPU transfer inside a TEE goes through a software bounce buffer that caps out around 4 GB/s. This mostly shows up as slower model loading rather than slower token generation. Blackwell GPUs remove the bottleneck with TDISP and PCIe IDE.

**NVLink is not encrypted on Hopper.** Multi-GPU confidential workloads that shard a model across GPUs over NVLink have a plaintext interconnect. Blackwell adds NVLink encryption.

**No persistent storage.** The 20Gi in the profile is ephemeral, so the model re-downloads if the container restarts.

**The endpoint is public.** Port 11434 is exposed globally with no authentication. TEE protects your workload from the host; it does nothing about who can reach the API. Put a reverse proxy with auth in front of it before pointing anything real at it.

**Confidential compute on Akash is still a draft specification** ([AEP-83](https://akash.network/roadmap/aep-83)). Expect the SDL surface and provider availability to move.

## Troubleshooting

**No bids.** Almost always means no TEE-capable provider with a matching GPU is available. Try raising `amount` in the placement block, then loosen constraints: drop the `signedBy` filter, or lower the GPU/memory request. You can also sanity-check that the rest of the SDL works by removing the `params.tee` block entirely — if it gets bids without TEE and none with it, it's a capacity issue, not a config issue.

**Deployment rejected at validation.** Check that `cpu-gpu` is paired with a `gpu` block in the compute profile, and that no other service in the group is missing a matching `tee` value.

**CUDA errors like "system not initialized."** The GPU Operator runs a local verifier as a pre-start hook that checks GPU measurements before your container starts. On failure the container still starts, but the GPU never reaches a ready state and CUDA calls fail. This points at provider-side configuration — try another provider.

**Empty response or connection refused.** The model is probably still downloading. Check the logs, or poll `/api/tags` until the model appears.

## References

- [AEP-83: Confidential Compute via Kata Containers](https://akash.network/roadmap/aep-83) — the SDL spec for `params.tee`
- [AEP-65: Confidential Computing on Akash](https://akash.network/roadmap/aep-65) — rationale and execution model
- [AEP-29: Hardware Attestation](https://akash.network/roadmap/aep-29)
- [Ollama API reference](https://github.com/ollama/ollama/blob/main/docs/api.md)
- [Akash SDL reference](https://akash.network/docs/getting-started/stack-definition-language/)

