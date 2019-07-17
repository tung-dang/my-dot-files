#!/usr/bin/env bash

info () {
    echo -ne "[\033[0;32mMSG\033[m] " 1>&2
    echo "$@" 1>&2
}

notice () {
    echo -ne "[\033[0;35mHMM\033[m] " 1>&2
    echo "$@" 1>&2
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    echo -ne "[\033[0;31mERR\033[m] " 1>&2
    echo "$@" 1>&2
}


# Variant of http://www.etalabs.net/sh_tricks.html, mimics GNU & bash echo.
echo() (
  fmt=%s end='\n' IFS=' '
  while [ $# -gt 1 ] ; do
    case "$1" in ([!-]*|-*[!neE]*) break;; esac # not a flag
    case "$1" in (*n*) end='';; esac # no newline
    case "$1" in (*e*) fmt=%b;; esac # interpret backslash escapes
    case "$1" in (*E*) fmt=%s;; esac # don't interpret backslashes
    shift
  done
  printf "$fmt$end" "$*"
)