#!/bin/sh
. ./scripts/append.sh

SHELLRC=".bashrc"
LINES='source $HOME/.config/shell/shared.sh
source .config/fastfetch/run.sh'

append $HOME/$SHELLRC "$LINES"
