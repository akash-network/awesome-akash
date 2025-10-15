#!/bin/bash
set -e

test -e /root/.bitcoin || mkdir -p /root/.bitcoin
chown -Rh root:root /root/.bitcoin

# Default BITCOIN_ARGS if unset
if [ -z "$BITCOIN_ARGS" ]; then
  BITCOIN_ARGS="-txindex=1"
fi

# If both RPCUSER and RPCPASSWORD are set, generate rpcauth credentials and
# add default RPC-related flags to BITCOIN_ARGS unless already present:
#   -server=1              → enable RPC server
#   -rpcbind=0.0.0.0       → bind RPC to all interfaces
#   -rpcallowip=0.0.0.0/0  → allow RPC from any IP (safe within pod as it's scoped to pod CIDR)
# Also prepend -rpcauthfile to load the generated credentials.
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
