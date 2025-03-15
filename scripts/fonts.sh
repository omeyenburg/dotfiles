#!/bin/sh

if [ -d /etc/nixos ]; then
    echo Consider using the nixos config to install fonts.
    exit
fi

mkdir -p "$HOME"/.local/share/fonts
cd "$HOME"/.local/share/fonts || exit

# Download fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraMono.tar.xz

ls

# Unpack fonts
tar -xJf FiraCode.tar.xz
tar -xJf FiraMono.tar.xz

ls
rm *.tar.xz

# Load fonts
fc-cache -f -v

echo Successfully installed fonts.
