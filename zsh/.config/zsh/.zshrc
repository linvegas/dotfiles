# Set options
setopt autocd
bindkey -v # vi mode
export KEYTIMEOUT=1

# Autoload
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

# Prompt
autoload -Uz vcs_info # Git setup
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%F{14}(%b)%f '
zstyle ':vcs_info:*' enable git
setopt prompt_subst

PROMPT='${vcs_info_msg_0_}✳️  %F{blue}%B%1~%b%f %(!.#.>) '

# History configuration
setopt histignorealldups sharehistory
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history"
export HISTSIZE=1000
export SAVEHIST=1000

# Use modern completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# Local scripts
export PATH="$PATH:$HOME/.local/bin"

# General aliases
alias ls='ls -A -X --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias tree="tree -a -C"
alias rm="rm -I"
alias du="du -h"
alias mkdir="mkdir -p -v"
alias history="fc -l 1"
alias so="source ~/.config/zsh/.zshrc"

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
alias sxiv="sxiv -f"
alias zathura="zathura --mode=fullscreen"

# Clean home aliases
alias nvidia_settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings"
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"

# Functions
webcam() { mpv --really-quiet av://v4l2:/dev/video${1:-0} --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg }

goto() {
  case $1 in
    "img") cd ~/media/img;;
    "vid") cd ~/media/vid;;
    "mus") cd ~/media/music;;
    "emu") cd ~/media/emul;;
    "smp") cd ~/media/samps;;
    "pro") cd ~/media/proj;;
    "bin") cd ~/.local/bin;;
    "dev") cd ~/dev/test-zone/bash-script;;
    "rep") cd ~/git/;;
    "ext") cd /media/$USER/EXTERNO;;
    "ssd") cd /mnt/SSD-2;;
    "ani") cd /mnt/SSD-2/anime;;
    "mor") cd /mnt/SSD-2/morbus;;
    *) echo "goto img|vid|mus|emu|smp|pro|bin|dev|rep|ext|ssd|ani|mor";;
  esac
}

share() {
  curl -s -F "file=@$1" https://0x0.st |\
  tee >(xclip -selection c) &&\
  echo "📋Seu link foi copiado!"
}

# Dircolors
[[ -x /usr/bin/dircolors ]] && test -r ~/.config/dircolors && eval "$(dircolors -b ~/.config/dircolors)" || eval "$(dircolors -b)"

# Zsh highlight
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
