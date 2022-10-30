#!/usr/bin/env sh

# kills polybar first
killall -q polybar
while pgrep -u "$(id -u)" -x polybar >/dev/null; do sleep 1; done

# Names and number of monitors
monitors=$(xrandr --query | grep -e "\sconnected")

# Actual launch
if [ "$($monitors | wc -l)" -eq 1 ]; then

  POLYMONITOR="$($monitors | cut -d" " -f1)" polybar --reload mainbar &

else

  for m in $monitors; do

    case $m in
      *primary*) POLYMONITOR="$($m | cut -d" " -f1)" polybar --reload mainbar &;;
      *) POLYMONITOR="$($m | cut -d" " -f1)" polybar --reload sidebar &;;
    esac

  done

fi

echo "LOL, bars got launched"
