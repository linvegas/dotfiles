#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="vim"
export TERMINAL="alacritty"
export BROWSER="firefox"

export PATH="$PATH:$HOME/.scripts"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export MUSIC_DIR="$HOME/media/music"

export VDPAU_DRIVER="nvidia"

# Starts xorg
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
