#!/bin/bash

ALGO=$(sed -e 's/^"//' -e 's/"$//' <<<"$ALGO") #Remove quotes
PASSWORD=$(sed -e 's/^"//' -e 's/"$//' <<<"$PASSWORD")
POOL=$(sed -e 's/^"//' -e 's/"$//' <<<"$POOL")
WALLET_ADDRESS=$(sed -e 's/^"//' -e 's/"$//' <<<"$WALLET_ADDRESS")
OPTIONS=$(sed -e 's/^"//' -e 's/"$//' <<<"$OPTIONS")

/root/nbminer -a $ALGO -o $POOL -u $WALLET_ADDRESS -p $PASSWORD $OPTIONS
