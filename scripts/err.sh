#!/bin/sh

function err() {
    if [ $SCRIPT_NAME ]; then
        echo -e "\033[0;31mError in module $SCRIPT_NAME: $@" 1>&2;
    else
        echo -e "\033[0;31mError: $@" 1>&2;
    fi
    exit 1;
}
