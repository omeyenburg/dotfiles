export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-21.0.2.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
export PATH="$HOME/Library/Python/3.11/bin:$PATH"
#export PATH="$HOME/.language_servers/jdt-language-server/bin:$PATH"
export PATH="$HOME/.nvim-macos/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1

alias vim="nvim"

[[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
