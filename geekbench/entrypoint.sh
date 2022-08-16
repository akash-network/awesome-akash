#!/usr/bin/env sh
set -e

if [ -n "$EMAIL" ] && [ -n "$KEY" ]; then
  ./bin/geekbench5 -r $email $key
  echo ""
fi

PARAMS=""

if [ -n "$UPLOAD" ]; then
  PARAMS="$PARAMS --upload"
fi

if [ -n "$NO_UPLOAD" ]; then
  PARAMS="$PARAMS --no-upload"
fi

./bin/geekbench5 $PARAMS
