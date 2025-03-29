# Local scripts into PATH
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$PATH:${$(find -L ~/.local/bin -type d -printf %p:)%%:}"
fi

# Starts xorg or wayland
if [ ! $(pidof -s Xorg) ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec ssh-agent startx "$XDG_CONFIG_HOME/X11/xinitrc" awesome &> ~/.cache/startx.log
    # exec ssh-agent startwl hypr &> ~/.cache/startw.log
fi
