# Make nvim the default editor
export EDITOR=nvim

# Aliases for ls cmd
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add mason packages to path
export PATH="$PATH:/home/oskar/.local/share/nvim/mason/bin"

OS=$(uname)
if [ "$OS" = "Linux" ]; then
    # Linux-specific settings

    # Update reminder
    echo "Reminder: Update your system with:"
    echo "  sudo apt update && sudo apt upgrade"
    echo ""
elif [ "$OS" = "Darwin" ]; then
    # macOS-specific settings

fi
