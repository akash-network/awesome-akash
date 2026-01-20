## vidulum is a blockchain built using Cosmos SDK and Tendermint and created with Starport

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-vidulum)


The default image is exposing RPC API, if that's not something you want to, make sure to remove `26657` from the deploy.yaml file.

By default, the image is setting the moniker to the container name, use `vidulumd start --help` in order to see what you can customize should you need to.

If you plan to register a validator, make sure you back-up the `priv_validator_key.json` & `node_key.json` in the `/root/.vidulum/config` directory.

- https://github.com/vidulum/mainnet
