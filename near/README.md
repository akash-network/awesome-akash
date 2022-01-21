# NEAR Node

Deploy a [Near](https://near.org) blockchain validator or a regular node easily with Akash.

## Deployment Steps

* Setup your Akash account by following steps on [docs.akash.network](https://docs.akash.network/guides/cli/part-2.-create-an-account)
* Create your network, configuration, certificate following the steps on Akash docs.
* (optional) Enter your account-id into the `deploy.yaml` if you want to run the node as a validator.  
* Deploy Near node by using the `deploy.yaml` file and issuing the command below:  
`akash tx deployment create deploy.yaml --from $AKASH_KEY_NAME --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --fees 5000uakt -y`
