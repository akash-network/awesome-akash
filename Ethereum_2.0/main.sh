#!/bin/bash
cp /usr/lib/go-1.18/bin/go /usr/bin/
runsvdir -P /etc/service &
# ++ Download validator keys ++
mkdir /root/validator_keys
sleep 2
echo $DEPOSIT_JSON_BASE64 | openssl base64 -d > /root/validator_keys/$DEPOSIT_FILE_NAME
sleep 2
echo $KEYSTORE_JSON_BASE64 | openssl base64 -d > /root/validator_keys/$KEYSTORE_FILE_NAME

echo $ACCOUNT_ETH_PASS > /root/validator_keys/pass.txt

# > Run SSH connection
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo $SSH_PASS; echo $SSH_PASS) | passwd root && service ssh restart
# <

# ===== Istall and runnig Erigon =====
git clone https://github.com/ledgerwatch/erigon.git
cd erigon
git checkout stable
make

# >> Create Erigon service on runit
mkdir /root/erigon && mkdir /root/erigon/log
mkdir -p /home/erigon/jwtsecret/
cat > /root/erigon/run <<EOF 
#!/bin/bash
exec 2>&1
exec /erigon/build/bin/erigon --chain=$NETWORK --datadir="/home/erigon/datadir/" --authrpc.jwtsecret="/home/erigon/jwtsecret/jwt.hex" --ws --private.api.addr="localhost:9090" --snapshots=true --externalcl --http.api=engine,eth,net --prune.r.before=4367322 --prune htc --http.vhosts "*" --http.port 8545 --http.addr 0.0.0.0 --http.corsdomain "*"
EOF
cat > /root/erigon/log/run <<EOF 
#!/bin/bash
mkdir /var/log/erigon
exec svlogd -tt /var/log/erigon
EOF
chmod +x /root/erigon/run
chmod +x /root/erigon/log/run
ln -s /root/erigon /etc/service
# <<

echo == Install Erigon service is complete. Check Erigon logs command in shell "tail -f /var/log/erigon/current" ==
sleep 10
# ===================================

# -------- Install and running Lighthouse ---------
wget -O lighthouse.tar.gz $LIGHTHOUSE_LINK
tar -C /usr/bin -xf lighthouse.tar.gz
sleep 2
# ++++ import account ++++
lighthouse --network $NETWORK account validator import --directory /root/validator_keys/ --datadir /home/lighthouse --password-file /root/validator_keys/pass.txt --reuse-password
rm /root/validator_keys/pass.txt

# >> Create Lighthouse service on runit 

mkdir /root/lighthouse && mkdir /root/lighthouse/log
cat > /root/lighthouse/run <<EOF 
#!/bin/bash
exec 2>&1
exec lighthouse bn --network $NETWORK --datadir /home/lighthouse --http --checkpoint-sync-url=$SNAP_URL --execution-endpoint=http://127.0.0.1:8551 --execution-jwt=/home/erigon/jwtsecret/jwt.hex --metrics --suggested-fee-recipient $RECEPIENT
EOF
cat > /root/lighthouse/log/run <<EOF 
#!/bin/bash
mkdir /var/log/lighthouse
exec svlogd -tt /var/log/lighthouse
EOF
chmod +x /root/lighthouse/run
chmod +x /root/lighthouse/log/run
sleep 1m
ln -s /root/lighthouse /etc/service
# <<
# -------------------------------------------------

echo ================================================================================
echo =     Check Erigon logs command in shell "tail -f /var/log/erigon/current"     =
echo = Check Lighthouse logs command in shell "tail -f /var/log/lighthouse/current" =
echo ================================================================================

sleep infinity
