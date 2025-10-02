# shellcheck disable=SC2016

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$PATH:$HOME/.local/bin"

# macOS-specific settings
if [ "$(uname)" = "Darwin" ]; then
    # Disable homebrew autoupdate
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Enable terminal colors
    [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color
fi

# Shell specific settings
if [[ "$SHELL" = */bin/bash ]]; then
    # Ignore duplicate commands in command history
    export HISTCONTROL=ignoredups:erasedups
    export HISTFILESIZE=100000
    export HISTSIZE=10000

    shopt -s histappend
    shopt -s checkwinsize
    shopt -s extglob
    shopt -s globstar
    shopt -s checkjobs

    # Disable history expansion with ! that I don't use.
    set +H

    # Source /etc/bashrc for interactive shell configurations
    if [ -z "$__ETC_BASHRC_SOURCED" ] && [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi

    # Custom shell promt
    # Colors are surrounded with octal codes instead
    # of \[ and \], because these are bash specific.
    default_color='\001\033[0m\002'
    bold_red='\001\033[0;31m\002'
    bold_green='\001\033[0;32m\002'
    bold_blue='\001\033[0;34m\002'
    bold_purple='\001\033[0;35m\002'
    bold_cyan='\001\033[0;36m\002'

    parse_git_branch() {
        branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/;s/(HEAD \(.*\))/\1/')

        if [[ $branch ]]; then
            echo -e "${default_color} on ${bold_purple} $branch"
        fi
    }

    parse_nix_shell() {
        if [[ $SHELL = /nix* ]]; then
            echo -e "${default_color} via ${bold_blue} nix shell"
        fi
    }

    parse_root() {
        if [ "$(whoami)" = "root" ]; then
            echo -e "${default_color} as ${bold_red}root"
        fi
    }

    create_prompt() {
        PROMPT_DIRTRIM=3
        PS1="${bold_cyan}\w\$(parse_git_branch)\$(parse_nix_shell)\$(parse_root)\n${bold_green}❯${default_color} "
    }

    PROMPT_COMMAND='create_prompt'
elif [ "$SHELL" = "/bin/zsh" ]; then
    # Ignore duplicate commands in command history
    setopt HIST_IGNORE_ALL_DUPS
fi

# Program settings & aliases
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
    export DIRENV_LOG_FORMAT=""
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash --cmd cd)"
    alias z=__zoxide_z
    alias zi=__zoxide_zi
    alias b="cd -"
fi

if command -v bat &>/dev/null; then
    export BAT_THEME="Catppuccin Mocha"
    alias cat="bat"
fi

if command -v eza &>/dev/null; then
    alias ls="eza"
fi

if command -v git &>/dev/null; then
    gitdiff() {
        git diff --color $@ | less
    }
    alias git="LANG=en_GB git"
fi

if command -v tmux &>/dev/null; then
    alias t=~/.config/tmux/t.sh
    complete -W "exit kill $(~/.config/tmux/t.sh list)" t
fi

if command -v nvim &>/dev/null; then
    export EDITOR=nvim
    export MANPAGER="nvim +Man!"
elif command -v vim &>/dev/null; then
    export EDITOR=vim
fi

if command -v yazi &>/dev/null; then
    y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }
fi

alias la="ls -A"
