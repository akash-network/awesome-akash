#!/bin/bash

if [ -z "$SSH_PUBKEY" ]; then
  echo "$(date): Error: SSH_PUBKEY is not set"
else
  echo "$SSH_PUBKEY" > ~/.ssh/authorized_keys
  pubkey_preview="${SSH_PUBKEY:0:20}***"
  echo "$(date): SSH_PUBKEY (${pubkey_preview}) written to ~/.ssh/authorized_keys"
fi

/usr/sbin/sshd

exec "$@"

