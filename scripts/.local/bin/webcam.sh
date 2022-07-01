#!/usr/bin/env sh

mpv_opt="--autofit=50%x50% --really-quiet --title='webcam'"

webcam_opt="av://v4l2:/dev/video${1:-0} --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg,video_size=1280x720"

mpv $mpv_opt $webcam_opt || notify-send "Nenhuma câmera conectada"
