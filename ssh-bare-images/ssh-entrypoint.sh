#!/bin/bash

echo "$SSH_PUBKEY" | tee ~/.ssh/authorized_keys; \
/usr/sbin/sshd

exec "$@"
