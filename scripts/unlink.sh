#!/bin/sh

find $HOME -maxdepth 1 -type l -delete
find $HOME/.config -maxdepth 1 -type l -delete
