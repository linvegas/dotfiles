#!/usr/bin/env bash

# Initialize monitor list
declare -A monitors
i=0

# Check for connected monitors and add to list
for d in $(xrandr -q | grep "\sconnected" | awk '{print $1}'); do
  monitors[i]=$d
  i=$((i+1))
done

# If there is only one monitor connected
if [[ ${#monitors[@]} -lt 2 ]]; then
  xrandr --output "${monitors[@]}" --auto
  echo "Um monitor encontrado"
  exit
fi

# Dual monitor setup
for j in "${monitors[@]}"; do
  if [[ $j =~ "DP" ]]; then
    secundary=$j
    xrandr --output $secundary --auto
  elif [[ $j =~ "HDMI" ]]; then
    primary=$j
    xrandr --output $primary --auto --primary --left-of $secundary
  else
    echo "No monitor founded"
    exit
  fi
done
echo "Dois monitores encontrados"
