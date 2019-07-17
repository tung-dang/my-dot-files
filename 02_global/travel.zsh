#!/usr/bin/env bash

# Fuzzy find file/dir
ff() {  find . -type f -name "${1}";}
fff() { find . -type f -name "*${1}*";}
fd() {  find . -type d -name "${1}";}
fdf() { find . -type d -name "*${1}*";}


# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
v() {
	if [ $# -eq 0 ]; then
		vim .;
	else
		vim "$@";
	fi;
}


# Makes a directory and changes to it.
mkd() {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

## go to a folder if have
## @usage cdTo folder_name
cdTo() {
    arg_folder_name="$1"

     # -d - FILE exists and is a directory.
    if [ -d "$arg_folder_name" ]
    then
        echo "- Discover '$arg_folder_name' folder and go into it";
        cd "$arg_folder_name"
    fi
}
