#!/usr/bin/env bash

# No mercy for polybar
killall -q polybar

# Watch it's funeral
while pgrep -u $UID -x polybar >/dev/null; do sleep 5; done

# New boss, time for managment
if type "xrandr" > /dev/null; then

  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do

    if [[ $m =~ "DP" ]]; then
      POLYMONITOR=$m polybar --reload sidebar &

    elif [[ $m =~ "HDMI" ]]; then
      POLYMONITOR=$m polybar --reload mainbar &

    else
      POLYMONITOR=$m polybar --reload sidebar &
    fi
  done
else

  polybar --reload mainbar &
fi

# Revenge
echo "LOL, bars got launched"
