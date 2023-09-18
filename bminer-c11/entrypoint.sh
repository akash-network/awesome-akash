#!/usr/bin/env bash
remove_quotes() {
  local str="$1"
  str="${str%\"}"
  str="${str#\"}"
  echo "$str"
}

for var_name in OPTIONS; do
  eval "value=\$$var_name"
  value=$(remove_quotes "$value")

  if [ -z "$value" ]; then
      echo "Please examine the SDL and be sure to set $var_name."
      sleep 300
      exit
  else
    eval "$var_name=\"$value\""
  fi
done

# Check if bminer is already downloaded
if [ ! -f "/root/bminer" ]; then

    ASSET_URL="https://www.bminercontent.com/releases/bminer-v16.4.11-2849b5c-amd64.tar.xz"

    wget $ASSET_URL -O /root/bminer.tar.xz

    # Extract to the current directory without the top-level folder
    tar --strip-components=1 -xf /root/bminer.tar.xz -C .

    # Delete the downloaded archive
    rm /root/bminer.tar.xz
    chmod +x /root/bminer
fi

echo "Startup takes up to ~60 seconds"
while :
do
/root/bminer $OPTIONS
sleep 1
done
