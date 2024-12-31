#!/bin/sh

# Default editor
export EDITOR=nvim

# ls
alias ll="ls -alF"
alias la="ls -A"

# Vim
# alias vim="nvim"
# alias vic="nvim --cmd 'let g:keyboard_layout = \"Colemak\"'"
# alias nvic="nvim --cmd 'let g:keyboard_layout = \"Colemak\"'"

# Fastfetch
source "$HOME/.config/fastfetch/run.sh"

# Git
alias git="LANG=en_GB git"
alias gitlog="python3 ~/.config/shell/gitlog.py"

# Yazi
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Add mason packages to path
# export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

# Add ~/.local/bin to path
export PATH="$PATH:$HOME/.local/bin"

# macOS-specific settings
if [ "$(uname)" = "Darwin" ]; then
    # Disable homebrew autoupdate
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Enable terminal colors
    [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color
fi

if [[ "$SHELL" = */bin/bash ]]; then
    # Ignore duplicate commands in command history
    export HISTCONTROL=ignoredups:erasedups

    # Source /etc/bashrc for interactive shell configurations
    if [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi
elif [ "$SHELL" = "/bin/zsh" ]; then
    # Ignore duplicate commands in command history
    setopt HIST_IGNORE_ALL_DUPS
fi

# Custom command line prompt
# export PS1="\u:\w\$ "
eval "$(starship init bash)"
