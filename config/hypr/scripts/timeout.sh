#!/bin/sh

# Sleep for $1 seconds, then kill all processes with a regex matching $2
sleep "$1"
pkill -f "$2"
