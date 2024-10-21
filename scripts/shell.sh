#!/bin/sh
. ./scripts/append.sh

SHELLRC=".bashrc"
LINES='source $HOME/.config/shell/shared.sh'

append $HOME/$SHELLRC "$LINES"
