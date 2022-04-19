#!/usr/bin/env bash
apt-get update &&
  apt-get upgrade -y &&
  DEBIAN_FRONTEND=noninteractive apt-get install -y cmake pkg-config libssl-dev git clang build-essential curl netcat git &&
  git clone https://github.com/NodleCode/chain &&
  cd chain

curl https://sh.rustup.rs -sSf | sh -s -- -y &&
  export PATH=$PATH:$HOME/.cargo/bin &&
  scripts/init.sh &&
  cargo build -p nodle-parachain --$PROFILE &&
  cp /chain/target/$PROFILE/nodle-parachain /usr/local/bin

mv /usr/share/ca* /tmp &&
  rm -rf /usr/share/* &&
  mv /tmp/ca-certificates /usr/share/ &&
  rm -rf /usr/lib/python* &&
  curl https://raw.githubusercontent.com/paritytech/polkadot/08c200f6540f67c16846d3152de50f0fbbc2a73d/node/service/res/rococo.json >/rococo.json

if [[ $PRUNING == "" ]]; then
exec nodle-parachain --name $NAME --chain $CHAIN $STARTUP
else
exec nodle-parachain --name $NAME --chain $CHAIN --pruning $PRUNING $STARTUP
fi
