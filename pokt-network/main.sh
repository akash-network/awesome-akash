#!/bin/bash
TZ=Europe/London && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get install -y -qq wget gcc make git nvme-cli nano unzip runit pv aria2 lz4
runsvdir -P /etc/service &
if [[ -n $SSH_PASS ]]
then
apt-get install -y ssh
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && (echo $SSH_PASS; echo $SSH_PASS) | passwd root && service ssh restart
fi

if ! [ -x "$(command -v go)" ]; then
  wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.20.1.linux-amd64.tar.gz
  PATH=$PATH:/usr/local/go/bin && echo $PATH
  go version && echo 'export PATH='$PATH:/usr/local/go/bin >> /root/.bashrc
fi

mkdir -p /root/.pocket/config

if [ ! -d "pocket-core" ]; then
  git clone https://github.com/pokt-network/pocket-core.git
fi

cd pocket-core

# Fetch all tags from the remote
git fetch --tags

# If the current checked out tag isn't the specified version, switch to it
CURRENT_TAG=$(git describe --tags)
if [ "$CURRENT_TAG" != "$VERSION" ]; then
  git checkout tags/$VERSION
  # Build the binary for the new tag
  go build -o /usr/bin/pocket /pocket-core/app/cmd/pocket_core/main.go && pocket version
fi

# ============================= Setting a custom keyfile.json =======================
if [[ -n $KEYFILE_BASE64 ]]
then
echo $KEYFILE_BASE64 | base64 -d > /tmp/keyfile.json
apt-get install -y expect
cat > /root/import <<EOF
#!/usr/bin/expect -f
spawn pocket accounts import-armored /tmp/keyfile.json
expect "Enter decrypt pass"
send "$KEY_PASS\r"
expect "Enter decrypt pass"
send "$KEY_PASS\r"
expect eof
EOF
chmod +x /root/import && /root/import

cat > /root/create_validator <<EOF
#!/usr/bin/expect -f
spawn pocket accounts set-validator $ADDRESS
expect "Enter the password:"
send "$KEY_PASS\r"
expect eof
EOF
chmod +x /root/create_validator && /root/create_validator
pocket accounts get-validator
rm /root/create_validator /root/import /tmp/keyfile.json
fi
# =================================================================================
if [[ -n $CHAINS_LINK ]]
then
wget -O /root/.pocket/config/chains.json $CHAINS_LINK
fi
if [[ -n $CHAINS_BASE64 ]]
then
echo $CHAINS_BASE64 | base64 -d > /root/.pocket/config/chains.json
fi
mkdir -p $HOME/.pocket/config

# This errors due to missing GENESIS_LINK envar, but this doesn't seem to be needed for the mainnet?
curl -o $HOME/.pocket/config/genesis.json $GENESIS_LINK

echo "== Downloading snapshot =="

mkdir -p $HOME/.pocket/data
if [ ! "$(ls -A $HOME/.pocket/data)" ]; then
  echo "No data in $HOME/.pocket/data. Downloading..."
  latestFile=$(curl https://pocket-snapshot.liquify.com/files/pruned/latest.txt)
  echo "Downloading the snapshot"
  curl -s "https://pocket-snapshot.liquify.com/files/pruned/$latestFile" | tar xf - -C "$HOME/.pocket"
else
  echo "Data exists in $HOME/.pocket/data. Skipping download."
fi

echo "== Finished Downloading snapshot =="

echo "=== Run node ==="
mkdir -p /root/pocket/log
cat > /root/pocket/run <<EOF
#!/bin/bash
exec 2>&1
exec pocket start --simulateRelay --seeds="$SEEDS" --$CHAIN
EOF
mkdir /tmp/log/
cat > /root/pocket/log/run <<EOF
#!/bin/bash
exec svlogd -tt /tmp/log/
EOF
chmod +x /root/pocket/log/run /root/pocket/run
ln -s /root/pocket /etc/service && ln -s /tmp/log/current /LOG

sleep 20
for ((;;))
  do
    tail -100 /LOG && sleep 5m
  done
fi
fred-icon
AskFred
dragger-icon