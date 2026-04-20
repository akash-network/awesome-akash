#!/bin/bash
apt-get update && apt-get install -y curl git openssh-server
mkdir -p /run/sshd
mkdir -p /root/.ssh && chmod 700 /root/.ssh
if [ -n "$SSH_PUBKEY" ]; then echo "$SSH_PUBKEY" >> /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys; fi
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> /root/.bashrc
git config --global user.email "agent@akash"
git config --global user.name "Akash Agent"
cd /workspace
if [ ! -d "autoresearch-at-home" ]; then git clone https://github.com/mutable-state-inc/autoresearch-at-home.git; fi
cd autoresearch-at-home
git pull
uv sync
echo "==> Running data preparation..."
uv run prepare.py
if [ -n "$ENSUE_API_KEY" ]; then echo "$ENSUE_API_KEY" > .autoresearch-key && echo "==> Collaborative mode enabled. Connect via SSH and point your agent at collab.md."; else echo "==> Solo mode. Connect via SSH and point your agent at program.md."; fi
echo "==> Environment ready. Connect via SSH to start the agent loop."
/usr/sbin/sshd -D
