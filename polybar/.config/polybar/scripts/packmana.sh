#!/usr/bin/env sh

[ -x "$(command -v pacman)" ] && pacman -Q | wc -l && exit
