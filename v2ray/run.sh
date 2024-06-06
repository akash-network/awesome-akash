#!/bin/sh
if [ -n "$ID" ]; then
  cat > /config.json <<EOF
{
  "inbounds": [
    {
      "port": 1010,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "$ID",
            "security": "auto",
            "alterId": 0
          }
        ]
      }
    },
    {
      "port": 1080,
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "userLevel": 0
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF
else
  apk add --no-cache wget
  wget -O /config.json $CONFIG_LINK
  apk del wget
fi

/v2ray run
