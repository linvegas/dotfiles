# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Variables
export HISTCONTROL=ignoredpus
export HISTSIZE=1000
export HISTFILESIZE=1000
export PATH="$PATH:$HOME/.local/bin"

# Options
shopt -s autocd
shopt -s histappend
set -o vi

# System aliases
alias reboot="sudo reboot"
alias off="sudo shutdown now"

# General aliases
alias ls='ls -A -X --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias tree="tree -a -C"
alias rm="rm -I"
alias du="du -h"
alias mkdir="mkdir -p -v"
alias so="source ~/.bashrc"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gl="git log"
alias gd="git diff"
alias gp="git push"

# Terminal Apps aliases
alias mpv="mpv --autofit=60%x60% --fs"
alias webcam="mpv --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg av://v4l2:/dev/video0"

# Git prompt

gitarch="/usr/share/git/completion/git-prompt.sh"
[[ -f "$gitarch" ]] && source $gitarch

gitubuntu="/usr/lib/git-core/git-sh-prompt"
[[ -f "$gitubuntu" ]] && source $gitubuntu

# Prompt
if [ "$EUID" -ne 0 ]
  then export PS1='\[\e[1;34m\]$(__git_ps1 "(%s) ")\[\e[m\]\[\e[1;32m\]\W\[\e[m\] \$ '
	else export PS1='[Root]\h \W \$ '
fi
