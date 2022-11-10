## Set options
setopt autocd
setopt extendedglob
bindkey -v # vi mode
export KEYTIMEOUT=1
stty stop undef

## Autoload
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

## Prompt
autoload -Uz vcs_info # Git setup
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f '
zstyle ':vcs_info:*' enable git
setopt prompt_subst

PROMPT='$(test ${+HISTFILE} -eq 0 && echo " ")${vcs_info_msg_0_}%F{white}%B%1~%b%f %(!.#.$) '

## History configuration
setopt hist_ignore_space
setopt histignorealldups sharehistory
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

## Use modern completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select cache-path $XDG_CACHE_HOME/zsh/zcompcache
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

## General aliases
alias ls="ls -X --color=auto --group-directories-first"
alias la="ls -A"
alias ll="ls -lh"
alias rm="rm -I -v"
alias mv="mv -v"
alias cp="cp -v"
alias mkdir="mkdir -p -v"
alias stow="stow -v"
alias du="du -h"
alias grep="grep --color=auto"
alias tree="tree -a -C"
alias hist="fc -l 1"
alias so="source ~/.config/zsh/.zshrc"
alias fale="espeak -v roa/pt-BR"
alias c="clear"
alias vim="nvim"
alias hx="helix"
alias anom=" unset HISTFILE"
alias lf="lf-uber"

# System
alias off="sudo shutdown now"
alias reboot="sudo reboot"
alias suspend="sudo systemctl suspend"

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
alias mpv="mpv --hwdec=auto --autofit=60%x60% --fs"
alias sxiv="sxiv -b -a"
alias zt="zathura"
# alias ncmpcpp="ncmpcpp-uber"
alias play="aplay -D pipewire"

# Clean home aliases
alias nvidia-settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings"
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"

## Functions

# Fuzzy find into shell history
hh() {
  hist |
  awk '{$1=""; print $0}' | sed -e 's/^[[:space:]]*//' |
  fzf -e --tac --layout=reverse --height=20 --info=hidden |
  xclip -r -selection clipboard
}

# Open webcam on mpv
cam() {
  mpv --really-quiet av://v4l2:/dev/video${1:-0} \
  --demuxer-lavf-format=video4linux2 \
  --demuxer-lavf-o-set=input_format=mjpeg,video_size=1280x720 \
  || notify-send "Nenhuma camera conectada"
}

# Share any file under 500mb using 0x0.st server
share() {
  curl -s -F "file=@$1" https://0x0.st |\
  tee >(xclip -selection c) &&\
  echo "📋Seu link foi copiado!"
}

# cd to specified path
g() {
  case "$@" in
    nvi)  cd ~/.config/nvim;;
    dot)  cd ~/dotfiles;;
    dow)  cd ~/docx/downloads;;
    doc)  cd ~/docx;;
    dev)  cd ~/dev;;
    sh)   cd ~/dev/learn/shell;;
    pic)  cd ~/media/pic;;
    vid)  cd ~/media/vid;;
    smp)  cd ~/media/samp;;
    pro)  cd ~/media/proj;;
    mus)  cd ~/media/mus;;
    emu)  cd ~/media/emu;;
    ani)  cd ~/media/ani;;
    bin)  cd ~/.local/bin;;
    rep)  cd ~/.local/src;;
    usb)  cd /mnt/usb1;;
    usb2) cd /mnt/usb2;;
    usb3) cd /mnt/usb3;;
    ext)  cd /mnt/externo;;
    ssd)  cd /mnt/ssd;;
    mor)  cd /mnt/ssd/morbus;;
    *)    echo "g nvi|dot|dow|doc|pic|vid|smp|pro|mus|emu|ani|bin|rep|dev|usb|usb2|usb3|ext|ssd|mor";;
  esac
}

# Edit personal scripts
vv() {
  cd "$HOME/.local/bin"

  local file=$(fzf --height=20 --layout=reverse --info=hidden --preview='')

  [ -z "$file" ] && cd - > /dev/null 2>&1 && return

  $EDITOR "$file"
  cd - > /dev/null 2>&1
}

# Shorcut for config files
v() {
  case "$@" in
    term)   $EDITOR "$XDG_CONFIG_HOME/alacritty/alacritty.yml";;
    dunst)  $EDITOR "$XDG_CONFIG_HOME/dunst/dunstrc";;
    picom)  $EDITOR "$XDG_CONFIG_HOME/picom/picom.conf";;
    i3)     $EDITOR "$XDG_CONFIG_HOME/i3/config";;
    mpd)    $EDITOR "$XDG_CONFIG_HOME/mpd/mpd.conf";;
    mplay)  $EDITOR "$XDG_CONFIG_HOME/ncmpcpp/config";;
    poly)   $EDITOR "$XDG_CONFIG_HOME/polybar/config.ini";;
    tmux)   $EDITOR "$XDG_CONFIG_HOME/tmux/tmux.conf";;
    v|vim)  $EDITOR "$XDG_CONFIG_HOME/nvim/init.vim";;
    xini)   $EDITOR "$XDG_CONFIG_HOME/X11/xinitrc";;
    xres)   $EDITOR "$XDG_CONFIG_HOME/X11/xresources";;
    z|zsh)  $EDITOR "$XDG_CONFIG_HOME/zsh/.zshrc";;
    zpro)   $EDITOR "$HOME/.zprofile";;
    *)      echo "Precisa de um parâmetro ou argumento inválido";;
  esac
}

# Dircolors
[ -x /usr/bin/dircolors ] && test -r ~/.config/dircolors && eval "$(dircolors -b ~/.config/dircolors)" || eval "$(dircolors -b)"

# Zsh highlight
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
