# shellcheck disable=SC2016

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

export EDITOR=nvim
export MANPAGER="nvim +Man!"

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

# shell specific settings
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

    # Source /etc/bashrc for interactive shell configurations
    if [ -z "$__ETC_BASHRC_SOURCED" ] && [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi
elif [ "$SHELL" = "/bin/zsh" ]; then
    # Ignore duplicate commands in command history
    setopt HIST_IGNORE_ALL_DUPS
fi

# initialize direnv
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
    export DIRENV_LOG_FORMAT=""
fi

# initialize zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash --cmd cd)"
    alias z=__zoxide_z
    alias zi=__zoxide_zi
    alias b="cd -"
fi

alias git="LANG=en_GB git"
alias la="ls -A"
alias ll="ls -alF"
alias books="xdg-open file:///home/oskar/books && exit"

# Tmux sessions
alias t=~/.config/tmux/t.sh
complete -W "exit kill $(t list)" t

# Obsidian vaults
obsidianopen() {
    obsidian "obsidian://open?vault=$1" &
    disown
}

# Yazi
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Short git log output
gitlog() {
    awk_max='
BEGIN { max1 = 0; max2 = 0; max3 = 0 }
{
    if (length($0) && substr($0, 1, 1) != " ") {
        if (length($1) > max1) max1 = length($1)
        if (length($2) > max2) max2 = length($2)
        gsub(/ seconds?/, "s", $3)
        gsub(/ minutes?/, "m", $3)
        gsub(/ hours?/,   "h", $3)
        gsub(/ days?/,    "d", $3)
        gsub(/ weeks?/,   "w", $3)
        gsub(/ months?/,  "mo", $3)
        gsub(/ years?/,   "y", $3)
        if (length($3) > max3) max3 = length($3)
    }
}
END { print max1, max2, max3 }
'

    awk_parse='
BEGIN { max1 = int(max1); max2 = int(max2); max3 = int(max3) }
{
    if (length($0) && substr($0, 1, 1) != " ") {
        message = sprintf("%-" max1 "s", $1)
        author = sprintf("%-" max2 + 1 "s", $2 ",")
        time = $3
        date = $4

        gsub(/ seconds?/, "s", time)
        gsub(/ minutes?/, "m", time)
        gsub(/ hours?/,   "h", time)
        gsub(/ days?/,    "d", time)
        gsub(/ weeks?/,   "w", time)
        gsub(/ months?/,  "mo", time)
        gsub(/ years?/,   "y", time)
        time = sprintf("%-" max3 + 3 "s", "(" time ")," )

        changes = "0 files changed"
        insertions = 0
        deletions = 0

        getline
        split($0, parts, ",")
        for (i = 1; i <= length(parts); i++) {
            gsub(/^[ \t]+|[ \t]+$/, "", parts[i])
            if (match(parts[i], /[0-9]+/)) {
                value = substr(parts[i], RSTART, RLENGTH)
            }
            if (match(parts[i], /files? changed/)) {
                changes = parts[i]
            }
            else if (match(parts[i], /insertion/)) {
                insertions = value
            }
            else if (match(parts[i], /deletion/)) {
                deletions = value
            }
        }

        if (insertions > 0 && deletions > 0) {
            changes = changes " (+" insertions ", -" deletions ")"
        }
        else if (insertions > 0) {
            changes = changes " (+" insertions ")"
        }
        else if (deletions > 0) {
            changes = changes " (-" deletions ")"
        }

        print message " " author " " date " " time " " changes
    }
}
'

    stats=$(git log -5 $@ --pretty=format:'%s|%an|%ar|%ad' --date=format:'%d.%m.%Y' --shortstat)
    read max1 max2 max3 <<<$(echo "$stats" | awk -F'|' "$awk_max")
    echo "$stats" | awk -v max1="$max1" -v max2="$max2" -v max3="$max3" -F'|' "$awk_parse"
}

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

export PROMPT_DIRTRIM=3
export PS1="${bold_cyan}\w\$(parse_git_branch)\$(parse_nix_shell)\$(parse_root)\n${bold_green}❯${default_color} "
