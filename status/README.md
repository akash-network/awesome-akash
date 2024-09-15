# Status.app Bootnode

[Status](https://status.app) is an open source, decentralised crypto communication super app. This deployment manifest allows you to run a bootstrap and service node allowing your (and others) to discover peers and receive/publish messages from resource restricted devices (e.g. phones). Apart from potentially being useful to you as a user directy, it also helps harden and decentralize the communication infrastructure ([Waku](http://waku.org)) which Status leverages.

# Setup

It is recommended to provide a `NODEKEY` environment variable which is the node private key used to derive a `peerId` - public identifier of the node. If you do not provide it, a random key will be generated on restart.

The node requires a public IP, so once you initially deploy, you need to find the leased IP address and provide it in `IP_ADDR` environment variable and update the deployment. This will result in node being able to advertise itself to the network.

Once the node starts, check the logs for the public multiaddress (e.g. `/ip4/${IP_ADDR/60000/${PEER_ID}`}) - this address can then be used to connect to your node.