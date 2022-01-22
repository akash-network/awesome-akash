# Run both validator node and chain node using akash

## Prerequisites

- Docker
- Yarn
- [NEAR-CLI](https://github.com/near/near-cli)
- [Kurtosis CLI](https://docs.kurtosistech.com/installation.html)

First we need to understand how it works using localnet, install all prerequisites first:

```
npm install -g near-cli
```

Then install kurtosis :

```
echo "deb [trusted=yes] https://apt.fury.io/kurtosis-tech/ /" | sudo tee /etc/apt/sources.list.d/kurtosis.list
sudo apt update
sudo apt install kurtosis-cli
```