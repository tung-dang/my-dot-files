#!/bin/sh
# -*- coding: utf-8 -*-

# `o` with no arguments opens the current directory, otherwise opens the given
o() {
    myPath="$@";
    number_of_args=$#;

    if [ number_of_args -eq 0 ]; then
        myPath=".";
    fi;

    command open "$myPath";
}

# enhance creating a folder
makedir() {
    all_args="$@"

    # words=$(echo $all_args | tr '-' '\n');
    words=${all_args//-/    }
    echo "Words: $words";

    # while -r read words ;
    for w in $words ;
    do
        echo "word: $w"
        glob="*$w*"
        echo "glob: $glob"
        echo $(find . -maxdepth 1 -name "$glob" -print -quit)
        if test -n "$(find . -maxdepth 1 -name "$glob" -print -quit)"
        then
            echo "- Find a potential duplicated folder $w with $all_args";
        fi
    done


    # create a target folder
    echo "- Creating $all_args"
    command mkdir "$all_args";
    command cd "$all_args";
}
