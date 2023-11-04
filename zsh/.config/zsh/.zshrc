## Set options
setopt autocd extendedglob
bindkey -v # vi mode
export KEYTIMEOUT=1
stty stop undef
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

## Prompt
autoload -Uz vcs_info # Git setup
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%F{green}[%b]%f '
zstyle ':vcs_info:*' enable git
setopt prompt_subst

PROMPT='$(test ${+HISTFILE} -eq 0 && echo " ")${vcs_info_msg_0_}%F{white}%B%1~%b%f %(!.#.$) '

## History configuration
setopt hist_ignore_space histignorealldups sharehistory
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

## Use modern completion system
autoload -Uz compinit
zstyle ':completion:*' menu select cache-path $XDG_CACHE_HOME/zsh/zcompcache
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

## Aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] &&
  source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

## Functions
# Pause or play every instances of mpv
mpvall() { for i in $(xdotool search --class mpv); do xdotool key --window "$i" p; done ;}

# Local web server
serve() { python3 -m http.server --bind "${1:-127.0.0.1}" "${2:-4242}" ;}

# Put file absolute path on clipboard
cf() { readlink -f "$1" | xclip -sel clip -r ;}

# Fuzzy find into shell history
hh() {
  hist |
  awk '{$1=""; print $0}' | sed -e 's/^[[:space:]]*//' |
  fzf -e --tac --layout=reverse --height=20 --info=hidden |
  wl-copy --trim-newline
  # xclip -r -selection clipboard
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
    vim)  cd ~/.config/nvim;;
    dot)  cd ~/dotfiles;;
    dow)  cd ~/docx/downloads;;
    doc)  cd ~/docx;;
    dev)  cd ~/dev;;
    sh)   cd ~/dev/shell;;
    pic)  cd ~/media/pic;;
    vid)  cd ~/media/vid;;
    smp)  cd ~/media/samp;;
    pro)  cd ~/media/proj;;
    mus)  cd ~/media/mus;;
    emu)  cd ~/media/emu;;
    ani)  cd ~/media/ani;;
    bin)  cd ~/.local/bin;;
    rep)  cd ~/.local/src;;
    wp)   cd ~/.local/share/backgrounds;;
    usb)  cd /mnt/usb1;;
    usb2) cd /mnt/usb2;;
    usb3) cd /mnt/usb3;;
    ext)  cd /mnt/externo;;
    shr)  cd /mnt/share;;
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
    al)     $EDITOR "$XDG_CONFIG_HOME/shell/aliasrc";;
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
    zp)     $EDITOR "$HOME/.zprofile";;
    *)      echo "Precisa de um parâmetro ou argumento inválido";;
  esac
}

# Dircolors
[ -x "/usr/bin/dircolors" ] && test -r "$HOME/.config/dircolors" && eval "$(dircolors -b ~/.config/dircolors)" || eval "$(dircolors -b)"

# Zsh highlight
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# bun completions
[ -s "$HOME/.local/share/bun/_bun" ] && source "$HOME/.local/share/bun/_bun"
