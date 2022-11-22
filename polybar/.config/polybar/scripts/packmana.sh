#!/usr/bin/env sh

[ -x "$(command -v pacman)" ] && pacman -Q | wc -l && exit
[ -x "$(command -v xbps-query)" ] && xbps-query -Rl | wc -l && exit
