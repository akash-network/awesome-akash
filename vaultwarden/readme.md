# Vaultwarden Server

From [the official Docker Hub image page](https://hub.docker.com/r/vaultwarden/server):

Alternative implementation of the Bitwarden server API written in Rust and compatible with upstream Bitwarden clients, perfect for self-hosted deployment where running the official resource-heavy service might not be ideal. Image is based on Rust implementation of Bitwarden API.

The `deploy.yaml` uses the official Docker image to deploy a basic configuration of Vaultwarden Server on Akash using persistent storage. Vaultwarden also requires HTTPS due to its use of [web crypto APIs](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto).

See the Vaultwarden Wiki (https://github.com/dani-garcia/vaultwarden/wiki/) for more information on how to configure and run the Vaultwarden server.
