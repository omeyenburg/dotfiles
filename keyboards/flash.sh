#!/bin/sh

# Set constants
KEYBOARD="cheapino"
KEYMAP="colemak"

# Flash keyboard layout onto keyboard using QMK.
qmk flash -kb $KEYBOARD -km $KEYMAP
