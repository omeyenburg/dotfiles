#!/usr/bin/env bash

echo "My dotfiles setup utility

Available commands:

  make git
    Configure Git with custom settings.

  make tmux
    Install TPM (Tmux Plugin Manager) and tmux plugins.
    Note: You may need to press <leader>+I inside tmux
          to complete plugin installation.

  make link
    Create symbolic links for dotfiles in ~/, ~/.config/, and ~/.local/bin.

  make fonts
    Install FiraCode and FiraMono fonts.

  make theme-install
    Install the Catppuccin Mocha theme for bat.

  make theme-update
    Generate CSS files for Waybar and Wofi.

  make qmk
    Link QMK configuration for the Cheapino keyboard.

  make firefox-config
    Generate the user.js file for Firefox configuration.

  make nixos-backup
    Copy NixOS configuration files from /etc/nixos/ to ./nixos/.
"
