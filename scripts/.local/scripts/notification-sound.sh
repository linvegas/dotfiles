#!/usr/bin/env sh

SYS_SOUND_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/sounds"

aplay -q "$SYS_SOUND_DIR"/notify.wav
