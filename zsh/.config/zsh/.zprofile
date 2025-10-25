# Starts xorg or wayland
if [ ! $(pidof -s Xorg) ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec ssh-agent startx "$XDG_CONFIG_HOME/X11/xinitrc" i3 &> ~/.cache/startx.log
    # exec ssh-agent startwl hypr &> ~/.cache/startw.log
fi
