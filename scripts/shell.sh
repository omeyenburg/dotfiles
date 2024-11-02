#!/bin/sh
source ./scripts/append.sh

SHELLRC=".bashrc"
LINES='source $HOME/.config/shell/shared.sh
source $HOME/.config/fastfetch/run.sh'

append $HOME/$SHELLRC "$LINES"
