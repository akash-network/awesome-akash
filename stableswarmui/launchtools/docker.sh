#!/usr/bin/env bash
if [[ -n "$LINK_MODEL" ]];then
bash model "$LINK_MODEL"
fi
# Launch as normal, just ensure launch mode is off and host is global (to expose it out of the container)
bash ./launch-linux.sh --launch_mode none --host 0.0.0.0
