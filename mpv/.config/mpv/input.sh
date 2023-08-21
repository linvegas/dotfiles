#!/usr/bin/env sh

[ ! -S "/tmp/mpv-socket" ] && exit

file_name=$(
  echo '{ "command": ["get_property", "path"]}' |
    socat - "/tmp/mpv-socket" | jq -r '.data'
)
work_dir=$(
  echo '{"command": ["get_property", "working-directory"]}' |
    socat - "/tmp/mpv-socket" | jq -r '.data'
)

echo "${work_dir}/${file_name}" | xclip -r -sel clip &&
  notify-send "MPV" "File copied"

