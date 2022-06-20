# Basic Variables
export EDITOR="vim"
export BROWSER="firefox"

# Clean up ~/
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export LESSHISTFILE="-"

# Local scripts
export PATH="$PATH:$HOME/.local/bin"

# Starts xorg
 if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
   exec ssh-agent startx "$XDG_CONFIG_HOME/X11/xinitrc" --
 fi
