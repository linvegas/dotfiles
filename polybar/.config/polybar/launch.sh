#!/usr/bin/env bash

# kills polybar first
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 5; done

# Names and number of monitors
monitors=$(xrandr --query | grep " connected" | cut -d" " -f1)
count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)

# Actual launch
if [ $count = 1 ]; then

  POLYMONITOR=$monitors polybar --reload mainbar &

else

  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do

    if [[ $m =~ "DP" ]]; then
      POLYMONITOR=$m polybar --reload sidebar &

    elif [[ $m =~ "HDMI" ]]; then
      POLYMONITOR=$m polybar --reload mainbar &

    else
      POLYMONITOR=$m polybar --reload sidebar &
    fi
  done

fi

echo "LOL, bars got launched"
