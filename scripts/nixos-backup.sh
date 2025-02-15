#!/bin/sh

NIXOSDIR="$DOTFILES/nixos"

cat /etc/nixos/home.nix > "$NIXOSDIR/home.nix"
cat /etc/nixos/flake.nix > "$NIXOSDIR/flake.nix"
cat /etc/nixos/configuration.nix > "$NIXOSDIR/configuration.nix"
cat /etc/nixos/macos-configuration.nix > "$NIXOSDIR/macos-configuration.nix"
