#!/bin/sh

function err() {
    echo -e "\033[0;31mError in module $SCRIPT_NAME: $@" 1>&2;
    exit 1;
}
