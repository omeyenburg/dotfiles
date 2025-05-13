#!/bin/sh

program=$1
CRASHDIR=/var/crash
core=$(ls -t $CRASHDIR | head -1)
gdb "$program" "$CRASHDIR/$core"
