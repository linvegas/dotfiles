#!/usr/bin/env sh

pid_file="/tmp/bspwm-scratchpad"

if [ ! -f "$pid_file" ] || [ ! "$(xargs -i sh -c 'bspc query -N {}' < "$pid_file")" ]; then
  pid=$(bspc query -N -n)
  echo "$pid" > "$pid_file"
  bspc node "$pid" --flag hidden
else
  pid=$(cat "$pid_file")
  bspc node "$pid" --flag hidden
  bspc node -f "$pid"
fi
