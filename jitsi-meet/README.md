# Jitsi Meet

[Jitsi Meet](https://jitsi.org/jitsi-meet/) is an open-source video conferencing solution.

The `deploy.yaml` uses the official Jitsi Docker images to deploy a multi-service setup on Akash including web, prosody, jicofo, and jvb components.

## Configuration

Update the environment variables in `deploy.yaml`:
- `PUBLIC_URL`: Your domain (e.g., `https://meet.yourdomain.com`)
- `LETSENCRYPT_DOMAIN`: Your domain
- `LETSENCRYPT_EMAIL`: Your email
- `DOCKER_HOST_ADDRESS`: Your public IP

## Ports

- 80/443: Web interface
- 10000 UDP: Media streaming