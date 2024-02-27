#!/usr/bin/env bash
remove_quotes() {
  local str="$1"
  str="${str%\"}"
  str="${str#\"}"
  echo "$str"
}

for var_name in POOL WALLET_ADDRESS OPTIONS; do
  eval "value=\$$var_name"
  value=$(remove_quotes "$value")

  if [ -z "$value" ]; then
    if [[ "$var_name" != "OPTIONS" ]]; then #Do not require user options to be set.
      echo "Please examine the SDL and be sure to set $var_name."
      sleep 300
      exit
    fi
  else
    eval "$var_name=\"$value\""
  fi
done


# Fetch GPU information
echo "GPU Information:"
echo "><><><><><><><><"
nvidia-smi
echo "><><><><><><><><"
./xmrig/xmrig --url $POOL --user $WALLET_ADDRESS $OPTIONS