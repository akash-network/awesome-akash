# Substrate Node

A fresh FRAME-based Substrate node, ready for hacking rocket :rocket:

## Docker images

* [ubinix5warun/substrate-node:v3-dev](https://hub.docker.com/layers/166944139/ubinix5warun/substrate-node/v3-dev/images/sha256-a2561b52172e902d4d63b265ba3379b53b633fc1b4289e3ed15ad35aa1146fde?context=repo)
    * [Dockerfile](https://github.com/ubinix-warun/substrate-node-template/blob/gr11-hackathon/container/Dockerfile)
    * [Build images](https://github.com/ubinix-warun/substrate-node-template/blob/gr11-hackathon/build-image.sh)

## Connect to WebSocket

Found host and externalPort from akask, use socat to proxy.

```
akash provider lease-status --node $AKASH_NODE --home ~/.akash --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --provider $AKASH_PROVIDER

...
"forwarded_ports": {
    "web": [
      {
        "host": "cluster.provider-0.prod.ams1.akash.pub",
        "port": 9944,
        "externalPort": 30190,
      ....
}
```

```
socat TCP-LISTEN:9944,fork TCP:cluster.provider-0.prod.ams1.akash.pub:30190
```