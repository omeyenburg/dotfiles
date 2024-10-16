#!/bin/bash

# Set constants
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
QMK_DIR="$HOME/.qmk_firmware"
KEYBOARD_NAME="cheapino"

# Create symlink for the entire keyboard folder
echo "Creating symlink for $KEYBOARD_NAME..."
ln -s "$SCRIPT_DIR/$KEYBOARD_NAME" "$QMK_DIR/keyboards/$KEYBOARD_NAME"
echo "Keyboard folder symlink created successfully!"
