#!/bin/sh

function exists() {
    if [ -e $1 ]; then
        echo 1
    else
        echo 0
    fi
}

function test {
    echo 1=$(exists "./exists.sh")
    echo 0=$(exists "./.sh")
}
