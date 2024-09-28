# Default editor
export EDITOR=nvim

# ls command
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Vim
alias vim="nvim"
alias vic="nvim --cmd 'let g:keyboard_layout = \"Colemak\"'"
alias nvic="nvim --cmd 'let g:keyboard_layout = \"Colemak\"'"

# Git
alias git="LANG=en_GB git"
alias gitlog="python3 ~/.config/shell/gitlog.py"
git config --global core.excludesfile "$HOME/.config/git/gitignore_global"
git config --global fetch.autoFetch true

# Neofetch
alias neofetch="neofetch | sed 's/^/    /;/^[[:space:]]*$/d'"

# Add mason packages to path
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

OS=$(uname)
if [ "$OS" = "Linux" ]; then
    # Linux-specific settings

    # Update reminder
    echo "Reminder: Update your system with:"
    echo "  sudo apt update && sudo apt upgrade"
    echo ""
elif [ "$OS" = "Darwin" ]; then
    # macOS-specific settings

    # Disable homebrew autoupdate
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Enable colors
    [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color
fi

if [ "$SHELL" = "/bin/bash" ]; then
    # Ignore duplicate commands in command history
    export HISTCONTROL=ignoredups:erasedups
elif [ "$SHELL" = "/bin/zsh" ]; then
    # Ignore duplicate commands in command history
    setopt HIST_IGNORE_ALL_DUPS
fi
