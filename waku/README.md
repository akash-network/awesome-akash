# What is Waku?

[Waku](https://waku.org/) is a family of robust, censorship-resistant communication protocols designed to enable privacy-focused messaging for web3 apps.

In other words, Waku allows you to build decentralized applications which require any form of message transfer (e.g. chats, push notifications, event broadcasting, weak consensus/coordination, message queues). You can build your own application protocols on top of plug&play Waku protocols, which ensure your node will be well connected with the network and your messages will be broadcasted reliably.

Waku also includes protocols friendly to resource restricted / adaptive devices like smartphones or laptops which may not have a lot of compute power or bandwith.

# Who is this deployment for?

The deployment manifests in this folder target users who wish to support the Waku Network as a node operator (i.e. making the network more robust, decentralized and private), but also users who would like to build an application on top of waku.

The [deployment.minimal.yaml](./deployment.minimal.yaml) is the easiest way to support the Waku Network as it only enables `relay` protocol (which is the backbone of the network) and discovery protocols (so that your know can discover other peers)

The [deployment.full.pg.yaml](./deployment.full.pg.yaml) is more comprehensive deployment which enables additional protocols (`filter`, `lightpush`, `store`) targetting resource restricted devices (i.e. those not able or willing to run the `relay` protocol) or devices with potential to not be always online.

# How to

Waku nodes need to be able to advertise public IP address (included in the multiaddress). Due to a way how Akash handles IP leases, we need to do a "two step deployment":

1. Deploy "broken" app
2. Fix it by updating the deployment with real public IP

## Minimal

1. Deploy [deployment.minimal.yaml](./deployment.minimal.yaml)
1. Get the leased IP and uncomment and update the argument in `services.node.args`:
    ```
    --nat=extip:{MY_IP}
    ```

## Full with Postgres

This deployment not only deploys Waku node, but also a Postgres database serving as an archive for the `store` protocol

1. Deploy [deployment.full.pg.yaml](./deployment.full.pg.yaml)
   * You may want to change the `POSTGRES_PASSWORD` in `services.node.env` and `services.postgres.env` (make sure both values match!)
1. Get the leased IP
1. Configure your DNS with the leased IP (i.e. create the A record for the domain you want to use for your waku noed)
1. Update the environment variables in `services.node.env`:
    ```
      - DOMAIN= #Your domain goes here
      - IP_ADDR= #Leased IP goes here
      - NODEKEY= #Optional: ECDSA PrivateKey used by your node - your PeerID is calculated based on this, so if you want to preserve your PeerID across restarts, use this option
    ```

After applying the updated deployment, you should see Let's Encrypt certificates being provisioned in logs and then node starting and relaying messages.

## After Deploy

Two important pieces of information about your node are the node's multiaddresses and ENR. You can find both early in the logs output after the deployment.

```
[node]: INF 2023-08-14 13:59:38.175+00:00 PeerInfo                                   topics="waku node" tid=1 file=waku_node.nim:796 peerId=16U*9q9fq5 addrs=@[]
[node]: INF 2023-08-14 13:59:38.175+00:00 Listening on                               topics="waku node" tid=1 file=waku_node.nim:803 full=[/dns4/waku.myrandomdemos.online/tcp/60000/p2p/16Uiu2HAmDdZ1brt7nq717ugWSK1EcGdaxUMVmHeVFzcPGb9q9fq5][/dns4/waku.myrandomdemos.online/tcp/8000/wss/p2p/16Uiu2HAmDdZ1brt7nq717ugWSK1EcGdaxUMVmHeVFzcPGb9q9fq5]
[node]: INF 2023-08-14 13:59:38.175+00:00 DNS: discoverable ENR                      topics="waku node" tid=1 file=waku_node.nim:804 enr=enr:-OG4QIzHr0Xd9OJVY3cDxqmDvwprccDQcRL0km9LR-q0MnjwFXZsqri_mnFwECqzVOxi78YierreeH9DUyYpdCeWZvIBgmlkgnY0gmlwhLhporWKbXVsdGlhZGRyc7hCAB42GXdha3UubXlyYW5kb21kZW1vcy5vbmxpbmUG6mAAIDYZd2FrdS5teXJhbmRvbWRlbW9zLm9ubGluZQYfQN4DiXNlY3AyNTZrMaEDDn10Z_V6Qh_BJV0BA_Y7wuTaApavCGi0WiIoZkMlGXyDdGNwgupgg3VkcIIjLYV3YWt1Mg8
```

You can verify that your deployment was successful and your node is reachable by connecting to it using [wakucanary](https://github.com/waku-org/nwaku/releases/latest) tool or, if you used the full deployment, by connecting via WSS using one of the [js-waku-examples](https://examples.waku.org/light-js/).

You can monitor your deployment with Prometheus and use a Grafana dashboard available in https://github.com/waku-org/nwaku-compose/tree/master/monitoring

You should see basic metrics printed in logs as well:
```
[node]: INF 2023-08-15 10:39:37.807+00:00 Relay peer connections                     topics="waku node peer_manager" tid=1 file=peer_manager.nim:683 inRelayConns=4/160 outRelayConns=17/80 totalConnections=24/300 notConnectedPeers=137 outsideBackoffPeers=5
[node]: INF 2023-08-15 10:39:39.460+00:00 Finished dialing multiple peers            topics="waku node peer_manager" tid=1 file=peer_manager.nim:532 successfulConns=0 attempted=3
[node]: INF 2023-08-15 10:39:40.532+00:00 Total connections initiated                topics="waku node metrics" tid=1 file=waku_metrics.nim:56 count=0.0
[node]: INF 2023-08-15 10:39:40.532+00:00 Total messages                             topics="waku node metrics" tid=1 file=waku_metrics.nim:57 count=231479.0
[node]: INF 2023-08-15 10:39:40.532+00:00 Total store peers                          topics="waku node metrics" tid=1 file=waku_metrics.nim:58 count=0.0
[node]: INF 2023-08-15 10:39:40.532+00:00 Total peer exchange peers                  topics="waku node metrics" tid=1 file=waku_metrics.nim:59 count=0.0
[node]: INF 2023-08-15 10:39:40.532+00:00 Total lightpush peers                      topics="waku node metrics" tid=1 file=waku_metrics.nim:60 count=0.0
[node]: INF 2023-08-15 10:39:40.532+00:00 Total filter peers                         topics="waku node metrics" tid=1 file=waku_metrics.nim:61 count=0.0
[node]: INF 2023-08-15 10:39:40.532+00:00 Total active filter subscriptions          topics="waku node metrics" tid=1 file=waku_metrics.nim:62 count=0.0
[node]: INF 2023-08-15 10:39:40.532+00:00 Total errors                               topics="waku node metrics" tid=1 file=waku_metrics.nim:63 count=1.0
[node]: INF 2023-08-15 10:40:10.532+00:00 Total connections initiated                topics="waku node metrics" tid=1 file=waku_metrics.nim:56 count=0.0
```

Notice the `inRelayConns` and `outRelayConns` - those represent the number of nodes in peer-to-peer relay network you are connected to.

Notice the `Total messages` metric - this represents how many messages went through your node.

# Links

* [Nwaku Akash repository](https://github.com/vpavlin/nwaku-akash)
* [nwaku](https://github.com/waku-org/nwaku)
* [Waku Docs](https://docs.waku.org/)
* [js-waku](https://github.com/waku-org/js-waku)