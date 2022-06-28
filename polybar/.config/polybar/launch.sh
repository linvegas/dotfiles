#!/usr/bin/env bash

# Terminate already running bar instances
#polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 5; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    POLYMONITOR=$m polybar --reload main &
  done
else
  polybar --reload main &
fi

echo "Bars launched..."
