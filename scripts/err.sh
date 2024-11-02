#!/bin/sh

RED="\033[0;31m"
NON="\033[0m"

function err() {
    if [ $SCRIPT_NAME ]; then
        echo -e "${RED}Error in module $SCRIPT_NAME: $@${NON}" 1>&2;
    else
        echo -e "${RED}Error: $@${NON}" 1>&2;
    fi
    exit 1;
}
