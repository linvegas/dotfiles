# Basic XDG stuff
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# export XDG_DESKTOP_DIR="$HOME/docs/desktop"
# export XDG_DOWNLOAD_DIR="$HOME/docs/downloads"
# export XDG_TEMPLATES_DIR="$HOME/docs/templates"
# export XDG_PUBLICSHARE_DIR="$HOME/docs/publico"
# export XDG_DOCUMENTS_DIR="$HOME/docs"
# export XDG_MUSIC_DIR="$HOME/mus"
# export XDG_PICTURES_DIR="$HOME/pics"
# export XDG_VIDEOS_DIR="$HOME/vids"

# Local XDG stuff
# export XDG_SAMPLES_DIR="$HOME/media/samp"
# export XDG_PROJECTS_DIR="$HOME/media/proj"
# export XDG_EMULATION_DIR="$HOME/media/emu"
# export XDG_ANIME_DIR="$HOME/media/ani"
# export XDG_MANGA_DIR="$HOME/media/mang"
# export XDG_DOTFILES_DIR="$HOME/dotfiles"
# export XDG_PROGRAMMING_DIR="$HOME/dev"

# Zsh config dir
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Options
export EDITOR="nvim"
export PF_INFO="ascii title os kernel shell pkgs wm memory"
export CALCURSE_PAGER="bat"
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK_THEME="adw-gtk3-dark"

# $HOME clean up
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
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
