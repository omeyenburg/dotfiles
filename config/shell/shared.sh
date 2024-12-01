# Default editor
export EDITOR=nvim

# PKG update alias
# alias pkg-update="sudo $HOME/.config/shell/pkg-update.sh"

# ls command
alias ll="ls -alF"
alias la="ls -A"
# alias l="ls -CF"

# Vim
alias vim="nvim"
alias vic="nvim --cmd 'let g:keyboard_layout = \"Colemak\"'"
alias nvic="nvim --cmd 'let g:keyboard_layout = \"Colemak\"'"

# Git
alias git="LANG=en_GB git"
alias gitlog="python3 ~/.config/shell/gitlog.py"

# File explorer
# alias exp='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# Add mason packages to path
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

# Add ~/.local/bin to path
export PATH="$PATH:$HOME/.local/bin"

# Custom command line prompt
export PS1="\u:\w\$ "

# macOS-specific settings
if [ "$(uname)" = "Darwin" ]; then
    # Disable homebrew autoupdate
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Enable terminal colors
    [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color
fi

if [ "$SHELL" = "/bin/bash" ]; then
    # Ignore duplicate commands in command history
    export HISTCONTROL=ignoredups:erasedups
elif [ "$SHELL" = "/bin/zsh" ]; then
    # Ignore duplicate commands in command history
    setopt HIST_IGNORE_ALL_DUPS
fi
