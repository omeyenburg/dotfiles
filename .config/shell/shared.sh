# Default editor
export EDITOR=nvim

# PKG update alias
alias pkg-update="sudo $HOME/.config/shell/pkg-update.sh"

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
git config status.showUntrackedFiles no

# Neofetch
alias neofetch="neofetch | sed 's/^/    /;$d' && echo ''"

# File explorer
alias exp='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Add mason packages to path
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

OS=$(uname)
if [ "$OS" = "Linux" ]; then
    # Linux-specific settings
    true
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

# Update reminder
printf "Reminder: Update your system with:    pkg-update\n\n"
