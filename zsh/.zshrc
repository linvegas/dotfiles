# Set options
setopt autocd
setopt rcquotes
bindkey -v # vi mode
export KEYTIMEOUT=1

# Set up the prompt
autoload -Uz colors && colors
autoload -Uz promptinit %% promptinit

autoload -Uz vcs_info # Git setup
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%F{14}(%b)%f '
zstyle ':vcs_info:*' enable git
setopt prompt_subst

PROMPT='${vcs_info_msg_0_}💠 %F{11}%B%1~%b%f %(!.#.>) '

# History configuration
setopt histignorealldups sharehistory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
_comp_options+=(globdots)

# Scripts
export PATH="$PATH:$HOME/.scripts"

# General aliases
alias ls='ls -aA -h -G -X --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias tree="tree -a -C"
alias rm="rm -I"
alias du="du -h"
alias bat="bat --color=auto"
alias mkdir="mkdir -p -v"
alias history="fc -l 1"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gl="git log"
alias gd="git diff"
alias gp="git push"

# Terminal Apps aliases
alias mplay="ncmpcpp"
alias mpv="mpv --hwdec=auto --autofit=60%x60%"

# Functions
function webcam() {
  mpv av://v4l2:/dev/video${1:-0} --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg
}

# Zsh highlight
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
