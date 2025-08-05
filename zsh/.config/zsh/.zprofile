# Starts xorg or wayland
if [ ! $(pidof -s Xorg) ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec ssh-agent startx "$XDG_CONFIG_HOME/X11/xinitrc" xfce &> ~/.cache/startx.log
    # exec ssh-agent startwl hypr &> ~/.cache/startw.log
fi
