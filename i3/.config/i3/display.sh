#!/usr/bin/env bash

# Get monitors connected
connected=$(xrandr -q | grep -e '\sconnected' | cut -d ' ' -f1)

# If there is only one monitor connected
[[ $(echo $connected | wc -w ) -lt 2 ]] && xrandr --output "${connected}" --auto && exit

# Dual monitor setup
for display in $connected; do
  if [[ $display =~ "DP" ]]; then
    secundary=$display
  elif [[ $display =~ "HDMI" ]]; then
    primary=$display
  else
    echo "Nenhum monitor correspondente"
    exit
  fi
done

# Xrandr the primary e secundary monitor
xrandr --output $secundary --auto --output $primary --auto --primary --left-of $secundary
exit
