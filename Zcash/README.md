# Zcash Node

A fresh Up-to-date Ubuntu install running Zcashd and tooling.

Zcashd & Zcash-cli allow you to run a full node and interact with it via a command-line interface. The zcashd full node downloads a copy of the Zcash blockchain, enforces rules of the Zcash network, and can execute all functionalities. The zcash-cli allows interactions with the node (e.g. to tell it to send a transaction).

## Connect to the Node

Found host and externalPort from akask.

```
akash provider lease-status --owner $OWNER --provider $PROVIDER --dseq $DSEQ --gseq $GSEQ --oseq $OSEQ
```

This returns output like this 

```
{
  "services": {
    "akash": {
      "name": "akash",
      "available": 1,
      "total": 1,
      "uris": [
        "5uo6vs083l803f6bndtdd45bg0.ingress.example.com
      ],
      "observed-generation": 0,
      "replicas": 0,
      "updated-replicas": 0,
      "ready-replicas": 0,
      "available-replicas": 0
    }
  },
  "forwarded-ports": {
    "akash": [
      {
        "port": 21,
        "externalPort": 31573,
        "proto": "TCP",
        "available": 1,
        "name": "akash"
      },
      {
        "port": 8232,
        "externalPort": 32028,
        "proto": "TCP",
        "available": 1,
        "name": "akash"
      },
      {
        "port": 8233,
        "externalPort": 32469,
        "proto": "TCP",
        "available": 1,
        "name": "akash"
      }
    ]
  }
}
```

In the section `forwarded-ports` you can see that port 32407 (this number is different in your deployment) is forwarded to port 26657, 
which is the RPC interface. Now you can query the node to confirm it is up, or SSH into root (set-password).

```
ssh root@5uo6vs083l803f6bndtdd45bg0.ingress.example.com -p 31573
```
