#!/bin/bash

# Set constants
KEYBOARD="cheapino"
KEYMAP="oskar"

# Flash keyboard layout onto keyboard using QMK.
qmk flash -kb $KEYBOARD -km $KEYMAP
