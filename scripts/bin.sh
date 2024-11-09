#!/bin/sh

BINARY_DIRECTORY="$HOME/.local/bin/"

mkdir -p $HOME/.local/bin/
cp "$DOTFILES"bin/* $BINARY_DIRECTORY 2>/dev/null || (echo "Failed to copy binaries" && exit 1)
echo "Copied binaries into $BINARY_DIRECTORY"
