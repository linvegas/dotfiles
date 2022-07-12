# Set options
setopt autocd
setopt extendedglob
bindkey -v # vi mode
export KEYTIMEOUT=1

# Autoload
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

# Prompt
autoload -Uz vcs_info # Git setup
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f '
zstyle ':vcs_info:*' enable git
setopt prompt_subst

PROMPT='${vcs_info_msg_0_}%F{blue}%B%1~%b%f %(!.#.>>) '

# History configuration
setopt histignorealldups sharehistory
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# Use modern completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# General aliases
alias ls='ls -X --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias tree="tree -a -C"
alias rm="rm -I"
alias du="du -h"
alias mkdir="mkdir -p -v"
alias history="fc -l 1"
alias so="source ~/.config/zsh/.zshrc"
alias off="sudo shutdown now"
alias reboot="sudo reboot"

# Python
alias py="python3"
alias pyon="source env/bin/activate"

# Ubuntu aliases
alias apt="nala"
alias aptup="sudo nala update && sudo nala upgrade"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gl="git log"
alias gd="git diff"
alias gp="git push"

# Media app aliases
alias mpv="mpv --autofit=60%x60% --fs"
alias sxiv="sxiv -f -b"
alias zathura="zathura --mode=fullscreen"

# Clean home aliases
alias nvidia_settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings"
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"

# Functions

# Open webcam on mpv
cam() {
  mpv --really-quiet av://v4l2:/dev/video${1:-0} \
  --demuxer-lavf-format=video4linux2 \
  --demuxer-lavf-o-set=input_format=mjpeg,video_size=1280x720 \
  || notify-send "Nenhuma camera conectada"
}

# share any file under 500mb using 0x0.st server
share() {
  curl -s -F "file=@$1" https://0x0.st |\
  tee >(xclip -selection c) &&\
  echo "📋Seu link foi copiado!"
}

# cd to specified path
g() {
  case "$@" in
    dot) cd ~/dotfiles;;
    dow) cd ~/docx/downloads;;
    pic) cd ~/media/pic;;
    vid) cd ~/media/vid;;
    mus) cd ~/media/mus;;
    emu) cd ~/media/emu;;
    smp) cd ~/media/samp;;
    pro) cd ~/media/proj;;
    bin) cd ~/.local/bin;;
    dev) cd ~/dev/test-zone/bash-script;;
    rep) cd ~/dev/repo;;
    usb) cd /mnt/usb1;;
    ext) cd /mnt/EXTERNO;;
    ssd) cd /mnt/SSD;;
    ani) cd /mnt/SSD/anime;;
    mor) cd /mnt/SSD/morbus;;
    *) echo "goto dot|pic|vid|mus|emu|smp|pro|bin|dev|rep|ext|ssd|ani|mor";;
  esac
}

# shorcut for config files
v() {
  case "$@" in
    term)  $EDITOR "$XDG_CONFIG_HOME/alacritty/alacritty.yml";;
    bash)  $EDITOR "$HOME/.bashrc";;
    bpro)  $EDITOR "$HOME/.bash_profile";;
    dunst) $EDITOR "$XDG_CONFIG_HOME/dunst/dunstrc";;
    i3)    $EDITOR "$XDG_CONFIG_HOME/i3/config";;
    poly)  $EDITOR "$XDG_CONFIG_HOME/polybar/config.ini";;
    tmux)  $EDITOR "$XDG_CONFIG_HOME/tmux/tmux.conf";;
    vim)   $EDITOR "$HOME/.vim/vimrc";;
    xini)  $EDITOR "$XDG_CONFIG_HOME/X11/xinitrc";;
    xres)  $EDITOR "$XDG_CONFIG_HOME/X11/xresources";;
    zsh)   $EDITOR "$XDG_CONFIG_HOME/zsh/.zshrc";;
    zpro)  $EDITOR "$HOME/.zprofile";;
    *)     echo "Precisa de um parâmetro ou argumento inválido";;
  esac
}

# Dircolors
[[ -x /usr/bin/dircolors ]] && test -r ~/.config/dircolors && eval "$(dircolors -b ~/.config/dircolors)" || eval "$(dircolors -b)"

# Zsh highlight
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
