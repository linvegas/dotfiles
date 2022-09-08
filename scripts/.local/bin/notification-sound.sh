#!/usr/bin/env sh

SYS_SOUND_DIR="$XDG_DATA_HOME/sys-sounds"

aplay -D pulse -q $SYS_SOUND_DIR/notify.wav
