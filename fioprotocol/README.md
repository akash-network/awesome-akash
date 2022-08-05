# FIO Protocol

[https://fioprotocol.io](https://fioprotocol.io)

Making crypto products easier so anyone can use them.

FIO - the Foundation for Interwallet Operability, is a decentralized consortium of blockchain organizations and community members supporting the ongoing development, integration, and promotion of the FIO Protocol. 

This deployment will bring up a full v1-history node on the FIO mainnet and expose the REST-API (80/443) and P2P (random) ports. The node will pull a recent database archive which includes all blocks and history indexes. It allows bringing a fully-synced API node online in usually under 30 minutes.

The pod will mount a 100G persistent volume at `/var/lib/fio`. Because the nodeos process must run as pid 1 and the volume is mounted with root permissions the startup script is run as root, file permissions are updated, then privileges are dropped to a regular user. Container source is available on [github]( https://github.com/blockpane/fio-docker)

