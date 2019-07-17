#!/bin/sh

# Git log find by commit message
glf() { git log --all --grep="$1"; }

## In A Git Repository, How Do We List Files Have Been Changed After A Specific Date?
## http://www.toptal.com/git/tips-and-practices
g_log_since_date() {
    # ${1}=2015-05-26
    for h in `git log --pretty=format:"%h" --since="${1}"`; do
        git show --pretty="format:" --name-only  $h
    done | sort | uniq
}

# Reflog
alias grl='git reflog'

g_log_current_branch() {
    current_branch_name=$(g_get_current_branch_name);
    git cherry -v master $current_branch_name
}