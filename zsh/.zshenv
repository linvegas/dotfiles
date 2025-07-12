# Basic XDG stuff
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Zsh config dir
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Options
export EDITOR="nvim"
export PF_INFO="ascii title os kernel shell pkgs wm memory"
export CALCURSE_PAGER="bat"

# $HOME clean up
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
export HISTFILE="$XDG_DATA_HOME/history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export GOPATH="$XDG_DATA_HOME/go"
export HEML_HOME="$XDG_DATA_HOME/helm"
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export BUN_INSTALL="$XDG_DATA_HOME/bun"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export OPAMROOT="$XDG_DATA_HOME/opam"
export LESSHISTFILE="-"

# Setting PATH env
export PATH="$PATH:$XDG_DATA_HOME/npm/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$BUN_INSTALL/bin"

# Local scripts
if [ -d "$HOME/.local/scripts" ]; then
    export PATH="$PATH:${$(find -L ~/.local/scripts -type d -printf %p:)%%:}"
fi
