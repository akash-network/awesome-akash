#!/bin/bash

remove_quotes() {
  local str="$1"
  str="${str%\"}"
  str="${str#\"}"
  echo "$str"
}

ALGO=$(remove_quotes "$ALGO")
PASSWORD=$(remove_quotes "$PASSWORD")
POOL=$(remove_quotes "$POOL")
WALLET_ADDRESS=$(remove_quotes "$WALLET_ADDRESS")
OPTIONS=$(remove_quotes "$OPTIONS")


export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root
sleep infinity
/root/CryptoDredge -a $ALGO -o $POOL -u $WALLET_ADDRESS -p $PASSWORD $OPTIONS
