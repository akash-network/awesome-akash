# Blessnetwork Node on Akash Network

Blessnetwork is the world's first shared computer - a global network powered by everyday devices, from Macbooks to desktops and everything in between. Instead of letting big tech companies like Amazon, Google, and Microsoft dominate the internet infrastructure, Blessnetwork enables individuals to participate and earn rewards.

## Prerequisites

Before deploying a Blessnetwork node on Akash, you need:

- An Akash account with AKT tokens
- The Akash CLI installed
- A Blessnetwork account and backup key

## Configuration

The deployment requires several environment variables:

- `NODE_ROLE`: Set to "worker" for regular nodes
- `AWS_ACCESS_KEY_ID`: S3 credentials for storage
- `AWS_SECRET_ACCESS_KEY`: S3 secret key
- `KEY_PATH`: Path to your Blessnetwork backup key
- `KEY_PASSWORD`: Password for your backup key
- `BOOT_NODES`: Bootstrap nodes for network connection

## Deployment

1. Update the `deploy.yaml` with your credentials:
   - Replace `s3_id` with your AWS access key
   - Replace `s3_key` with your AWS secret key
   - Update `my_backup_key_path` with your key path
   - Set `my_key_password` to your key password

2. Deploy using Akash CLI:
```bash
akash deploy deploy.yaml
```

## Resources

The default deployment uses:
- 0.5 CPU units
- 1024Mi memory
- 512Mi storage

## Network Ports

The node exposes port 9527 for network communication.

## Support

For additional support:
- Join Blessnetwork Discord
- Visit [Blessnetwork Documentation](https://docs.bless.network)
- Akash Network [Discord](https://discord.akash.network)
