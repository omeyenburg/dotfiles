# Make nvim the default editor
export EDITOR=nvim

# Aliases for ls cmd
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Aliases for vim
alias vim="nvim"
alias vic="nvim --cmd 'let g:keyboard_layout = \"Colemak\"'"
alias nvic="nvim --cmd 'let g:keyboard_layout = \"Colemak\"'"

# Aliases for git
alias git="LANG=en_GB git"
alias gitlog="python3 ~/.config/shell/gitlog.py"
# alias gitlog="git log --pretty=format:'%<(20)%an %<(20)%ar %s' -10"

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
