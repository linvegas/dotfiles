setopt autocd prompt_subst

export KEYTIMEOUT=1

# Git prompt
autoload -Uz vcs_info # Git setup
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%F{magenta}%f'
zstyle ':vcs_info:*' enable git

# Anom prompt icon
anom_mode() {
    test ${+HISTFILE} -eq 0 && echo " "
}

PROMPT='%F{red}$(anom_mode)%f%n@%F{green}%m ${vcs_info_msg_0_}%f[%B%1~%b] %(!.#.$) '

# History
setopt hist_ignore_space histignorealldups sharehistory
export HISTFILE="$HOME/.cache/zsh/zsh_history"
export HISTSIZE=128000
export SAVEHIST=128000

# Zsh cache dir
[ ! -d "$HOME/.cache/zsh" ] && mkdir -p "$HOME/.cache/zsh"

# Directory colors
if [ -x "$(command -v dircolors)" ]; then
    [ -f "$HOME/.config/dircolors" ] \
        && eval "$(dircolors -b $HOME/.config/dircolors)" \
        || eval "$(dircolors -b)"
fi

# Completion
autoload -Uz compinit && compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select=2

# Shell extension files
[ -f "$HOME/.config/shell/aliasrc" ] && source "$HOME/.config/shell/aliasrc"
[ -f "$HOME/.config/shell/fnrc" ] && source "$HOME/.config/shell/fnrc"

# Zsh highlighting
if [ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
