# Sifchain-ui container

Running Sifchain-UI DEX on Akash.

## Motivation

I've noticed [Sifchain DEX](https://dex.sifchain.finance) is running slow sometimes and realized why not to host my own copy of [Sifchain-UI](https://github.com/Sifchain/sifchain-ui) since it's open source?

And then it helps its decentralization! :-)

## Features

- [Dockerfile](./Dockerfile) produces a tiny 47MB image which is super quick to deploy;
- [Makefile](./Makefile) lets you quickly test and use the image locally!
- The image is self auto-updating:
  - it checks for a new release at https://github.com/Sifchain/sifchain-ui/releases every 2 hours and updates itself;

## Notes on TLS

Whilst `localhost`, `127.0.0.0/8` addresses are not restricted (which makes testing easy), browsers deny using HTTPS resources (e.g. Sifchain/Keplr `rpcUrl` addresses) from a non-HTTP's page.

This container generates a self-signed TLS certificate, so you can access your deployment over a nodePort mapped to 443/tcp in the container. To find it use `akash provider lease-status ...` command.
It will work, but you will have to accept a self-signed certificate.

Or you can terminate TLS elsewhere, e.g. https://www.youtube.com/watch?v=HDNPABvkmG0

# Running Sifchain UI DEX in Akash or locally

## Dependencies

Install `make` and [docker](https://docs.docker.com/engine/install/).

## My image

To use my image just deploy the `deploy.yaml` file on Akash.

## Own image

If you want to build your own image then follow these steps:

**Setup:**

1. Register an account at the Docker Hub https://hub.docker.com
2. Run `docker login` to login with your Docker Hub account
3. Set `ns` variable in `Makefile` to your Docker Hub account

**Build:**

1. Run `make` to build & push your image to your Docker Hub
2. Now you can deploy `deploy.yaml` on Akash!

> `make` automatically sets `image` to yours in `deploy.yaml`

# Help

```
make             - runs build push update-sdl clean stages
make build       - builds the docker image
make test        - runs the docker image locally, access Sifchain over http://127.0.0.1:8080
make push        - pushes the docker image to https://hub.docker.com
make update-sdl  - update `image` in `deploy.yaml` file
make clean       - removes old images (keeps last two)
```

# Links

- https://sifchain.finance
- https://dex.sifchain.finance
- https://github.com/Sifchain/sifchain-ui

