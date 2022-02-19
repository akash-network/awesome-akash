# NEAR on Akash

## Requirements

- An Akash wallet with at least 6AKT.
- [Akashlytics](https://akashlytics.com/) has been installed.
- If you want to deploy validator, you'd better create a [filebase](https://filebase.com/) account.

## Environments

|name|Description|Necessary|
|----|----|----|
|BACKUP_URL|Node data file for rapid deployment.|No|
|NET|The type of network you want to deploy.|Yes|
|ACCOUNT|Your near account.|No|
|S3_KEY|The S3 key for backup.|No|
|S3_SECRET|The S3 secret for backup.|No|
|S3_HOST|The S3 host for backup.|No|
|KEY_PATH|The storage location of the file in S3,it can be the bucket name directly.|No|

## Deploy rpc node
You can deploy directly with the yaml file below.

## Deploy validator node
You'd better configure all the environment variables to ensure that your node's critical data(node_key.json, validator_key.json) can be backed up and restored.

----

Please check whether you are using the latest version of the image on the [docker hub page](https://hub.docker.com/r/glacierluo/near_node/tags) before using it. Due to the mechanism of Akash, the update of the image needs to be controlled through tag.

``` yaml
---
version: '2.0'
services:
  nearnode:
    image: glacierluo/near_node:0.6
    expose:
      - port: 3030
        to:
          - global: true
      - port: 24567
        to:
          - global: true
    env:
      # Node data file for rapid deployment.
      - BACKUP_URL=https://near-protocol-public.s3-accelerate.amazonaws.com/backups/mainnet/rpc/data.tar
      # The type of network you want to deploy.
      - NET=mainnet
      # Your near account.
      - ACCOUNT=
      # The S3 key for backup.
      - S3_KEY=
      # The S3 secret for backup.
      - S3_SECRET=
      # The S3 host for backup.
      - S3_HOST=https://s3.filebase.com
      # The storage location of the file in S3,it can be the bucket name directly.
      - KEY_PATH=

profiles:
  compute:
    nearnode:
      resources:
        cpu:
          units: 2
        memory:
          size: 4Gi
        storage:
          size: 500Gi
  placement:
    dcloud:
      pricing:
        nearnode:
          denom: uakt
          amount: 100000

deployment:
  nearnode:
    dcloud:
      profile: nearnode
      count: 1

```