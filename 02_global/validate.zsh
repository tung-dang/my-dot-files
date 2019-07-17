#!/usr/bin/env bash

# Executable
is-executable() {
    BIN=`command -v "$1" 2>/dev/null`
    [[ ! $BIN == "" && -x $BIN ]] && true || false
}

is-supported() {
    if [ $# -eq 1 ]; then
        eval $1 > /dev/null 2>&1 && true || false
    else
        eval $1 > /dev/null 2>&1 && echo -n "$2" || echo -n "$3"
    fi
}

# Clean caches
cleanup() {
    is-executable npm && npm cache clean
    is-executable brew && brew cleanup
    is-executable brew && brew cask cleanup
}
