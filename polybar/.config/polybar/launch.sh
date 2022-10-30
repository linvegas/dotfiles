#!/usr/bin/env sh

# kills polybar first
killall -q polybar
while pgrep -u "$(id -u)" -x polybar >/dev/null; do sleep 1; done

# Xrandr one line about monitors connected, not actual monitor name
monitors=$(xrandr --query | grep -e "\sconnected")

# Actual launch
if [ "$(echo "$monitors" | wc -l)" -eq 1 ]; then

  POLYMONITOR="$(echo "$monitors" | cut -d" " -f1)" polybar --reload mainbar &

else

  printf "%s\n" "$monitors" |
  while IFS= read -r m; do
    case $m in
      *primary*)
        POLYMONITOR="$(echo "$m" | cut -d" " -f1)" polybar --reload mainbar &;;
      *)
        POLYMONITOR="$(echo "$m" | cut -d" " -f1)" polybar --reload sidebar &;;
    esac
  done

fi

