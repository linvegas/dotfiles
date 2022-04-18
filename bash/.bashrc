#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Auto cd into directories
shopt -s autocd

# System
alias reboot="sudo reboot"
alias off="sudo shutdown now"

# Terminal
alias ls='ls -aA -h -G -X --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias tree="tree -a -C"
alias rm="rm -I"
alias du="du -h"
alias bat="bat --color=auto"

# Terminal Apps
alias mplay="ncmpcpp"
alias mpv="mpv --hwdec=auto --autofit=60%x60%"
alias sxiv="sxiv -b"

# Prompt
if [ "$EUID" -ne 0 ] 
	then export PS1='🌀 \[\e[1;32m\]\W\[\e[m\] \$ '
	else export PS1='[Root]\h \W \$ '
fi
