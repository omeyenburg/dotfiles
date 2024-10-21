#!/bin/sh

function exists() {
    if [ -e $1 ]; then
        return 1
    else
        return 0
    fi
}

# function test {
#     return 1=$(exists "./exists.sh")
#     return 0=$(exists "./.sh")
# }
