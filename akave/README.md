# Akave

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-akave)

[Akave](https://akave.com) is a decentralized, on-chain data platform built for AI and large-scale workloads. It provides S3-compatible object storage (O3) that can be accessed from Akash deployments using standard AWS CLI tooling.

This template deploys a lightweight service on Akash that connects to Akave O3 storage, uploads a test object, and serves an auto-refreshing HTML page listing all objects in the configured bucket with pre-signed download URLs.

## Prerequisites

- An [Akash](https://console.akash.network/) account with funds
- [Akave Cloud](https://console.akave.com/) credentials (Access Key ID, Secret Access Key, Endpoint URL)
- An Akave bucket — see [Bucket Management](https://docs.akave.xyz/akave-o3/bucket-management/create-list-delete-buckets/)

## Setup

1. Open the [Akash Console](https://console.akash.network/) and click **Deploy**.
2. Select **Upload your SDL** and use the `deploy.yaml` from this folder.
3. Replace the environment variables in the `env` section:

| Variable | Description |
|---|---|
| `AKAVE_ENDPOINT` | Your [Akave Endpoint URL](https://docs.akave.xyz/akave-o3/introduction/akave-environment/) |
| `AKAVE_BUCKET` | Your Akave bucket name |
| `AKAVE_ACCESS` | Your Akave Access Key ID |
| `AKAVE_SECRET` | Your Akave Secret Access Key |
| `REFRESH_INTERVAL` | Seconds between HTML page refreshes (default: `60`) |

> **Note:** These values are set in the `env` section of the SDL and are not exposed after deployment.

4. Name your deployment, fund the escrow, select a provider, and deploy.

## Usage

Once deployed, the service will:

- [Initialize the storage connection](https://docs.akave.xyz/akave-o3/introduction/setup/) using the AWS CLI
- [Upload a test object](https://docs.akave.xyz/akave-o3/object-management/upload-download-delete-objects/) to verify the integration
- [List objects](https://docs.akave.xyz/akave-o3/object-management/upload-download-delete-objects/) in the bucket
- [Generate pre-signed URLs](https://docs.akave.xyz/akave-o3/presigned-urls/generate-and-use-presigned-urls/) for downloading objects

Visit the deployment URI to see the live object listing page.

## Extending

To add more functionality, modify the SDL using:

- [Akave O3 Docs](https://docs.akave.xyz/akave-o3/)
- [AWS boto3 (Python)](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)
- [AWS SDK for JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started.html)

## Docs

[Akave Documentation](https://docs.akave.xyz/) | [Akave Cloud Console](https://console.akave.com/) | [Akave on Akash Guide](https://docs.akave.xyz/solutions-and-integrations/akash/)
