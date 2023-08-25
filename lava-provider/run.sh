#!/bin/bash
if [[ -z $MNEMONIC_BASE64 ]] || [[ -z $BINARY_LINK ]] || [[ -z $LAVAD_GEOLOCATION ]] || [[ -z $CHAIN_ID ]] || [[ -z $LAVAD_NODE ]] 
then 
echo Service stopped! Check env MNEMONIC_BASE64, BINARY_LINK, LAVAD_GEOLOCATION, LAVAD_NODE and CHAIN_ID in your SDL!
sleep infinity
fi
if [[ -n $SSH_PASS ]]; then echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && (echo $SSH_PASS; echo $SSH_PASS) | passwd root && service ssh restart; fi
wget -O /usr/bin/lavad $BINARY_LINK 
chmod +x /usr/bin/lavad
lavad init "Lava Provider on Akash Network" --chain-id $CHAIN_ID
(echo $MNEMONIC_BASE64 | base64 -d )|lavad keys add wallet --recover --keyring-backend test
if [[ -n $CONFIG_LINK ]]; then wget -O /root/rpcprovider.yml $CONFIG_LINK ; fi
ADDRESS=`lavad keys show wallet  -a --keyring-backend test`
echo 'export CHAIN_ID='${CHAIN_ID} >> /root/.bashrc ;echo 'export LAVAD_NODE='${LAVAD_NODE} >> /root/.bashrc ;echo 'export ADDRESS='${ADDRESS} >> /root/.bashrc ;echo 'export LAVAD_GEOLOCATION='${LAVAD_GEOLOCATION} >> /root/.bashrc ;  source ~/.bashrc
sleep 2
mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/CN=localhost"
cp -pvi /etc/nginx/sites-available/default /root/nginx.default.bkp
sed -i 's/worker_processes auto;/worker_processes 1;/g' /etc/nginx/nginx.conf
cat > /etc/nginx/sites-available/default << 'EOF'
server {
    listen 443 ssl http2;
    server_name _;
    ssl_certificate /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx.key;
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
    error_log /var/log/nginx/debug.log debug;

    location / {
        proxy_pass https://127.0.0.1:2001;
        grpc_pass grpcs://127.0.0.1:2001;
    }
}
EOF
service nginx start
runsvdir -P /etc/service &
mkdir -p /root/lavap/log    
cat > /root/lavap/run <<EOF 
#!/bin/bash
exec 2>&1
exec lavad rpcprovider --geolocation $LAVAD_GEOLOCATION --from $ADDRESS --keyring-backend test --chain-id lava-testnet-2
EOF
mkdir -p /tmp/lavap/log/
cat > /root/lavap/log/run <<EOF 
#!/bin/bash
exec svlogd -tt /tmp/lavap/log/
EOF
chmod +x /root/lavap/log/run /root/lavap/run 
ln -s /root/lavap /etc/service && ln -s /tmp/lavap/log/current /LOG_PROV
sleep 10
while true ; do tail -f /LOG_PROV ; done
