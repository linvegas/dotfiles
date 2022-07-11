#!/usr/bin/env sh

mpv_opt="--autofit=50%x50% --really-quiet --title='webcam'"

case $2 in
  480) cam_res="854x480";;
  720) cam_res="1280x720";;
  *) cam_res="640x480";;
esac

webcam_opt="av://v4l2:/dev/video${1:-0} --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg,video_size=${cam_res}"

mpv $mpv_opt $webcam_opt || notify-send "Nenhuma câmera conectada"
