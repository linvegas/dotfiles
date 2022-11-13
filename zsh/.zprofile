# Basic Variables
export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="alacritty"

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
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export LESSHISTFILE="-"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export HEML_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/helm"

# Local scripts and configurations
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/bin/muhstuff"
export PATH="$PATH:$XDG_DATA_HOME/npm/bin"
export PF_INFO="ascii title os kernel shell pkgs wm memory"
export CALCURSE_PAGER="bat"
export QT_QPA_PLATFORMTHEME="qt5ct"

# export LG_WEBOS_TV_SDK_HOME="$HOME/dev/webOS_TV_SDK"
# if [ -d "$LG_WEBOS_TV_SDK_HOME/CLI/bin" ]; then
#   export WEBOS_CLI_TV="$LG_WEBOS_TV_SDK_HOME/CLI/bin"
#   export PATH="$PATH:$WEBOS_CLI_TV"
# fi

# Starts xorg
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec ssh-agent startx "$XDG_CONFIG_HOME/X11/xinitrc" -- &> ~/.cache/startx.log
  # exec ssh-agent sway --unsupported-gpu -- &> ~/.cache/startw.log
fi
