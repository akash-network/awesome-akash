#!/bin/bash
set -e

test -e /root/.bitcoin || mkdir -p /root/.bitcoin
chown -Rh root:root /root/.bitcoin

# Default BITCOIN_ARGS if unset
if [ -z "$BITCOIN_ARGS" ]; then
  BITCOIN_ARGS="-txindex=1"
fi

# Conditionally add -server=1 -rpcbind=0.0.0.0 if RPC credentials are set
if [ -n "$RPCUSER" ] && [ -n "$RPCPASSWORD" ]; then
  echo "Generating rpcauth for user=$RPCUSER"
  /usr/local/bin/rpcauth.py "$RPCUSER" "$RPCPASSWORD" --output /root/.bitcoin/rpcauth.conf >/dev/null

  case "$BITCOIN_ARGS" in
    *-server*)  ;;  # already set
    *) BITCOIN_ARGS="$BITCOIN_ARGS -server=1" ;;
  esac
  case "$BITCOIN_ARGS" in
    *-rpcbind*) ;;  # already set
    *) BITCOIN_ARGS="$BITCOIN_ARGS -rpcbind=0.0.0.0" ;;
  esac
  case "$BITCOIN_ARGS" in
    *-rpcallowip*) ;;  # already set
    *) BITCOIN_ARGS="$BITCOIN_ARGS -rpcallowip=0.0.0.0/0" ;;
  esac

  BITCOIN_ARGS="-rpcauthfile=/root/.bitcoin/rpcauth.conf $BITCOIN_ARGS"
fi

echo "Starting bitcoind with args: $BITCOIN_ARGS"
exec bitcoind $BITCOIN_ARGS
