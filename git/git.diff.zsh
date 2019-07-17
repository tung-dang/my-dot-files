#!/bin/sh
#
# Diff unstaged changes
alias gd='git diff --color --ignore-space-at-eol'
# Diff staged changes ("The next commit")
alias gdi='git diff --color --ignore-space-at-eol --cached'
alias gdc="git diff --color --ignore-space-at-eol --cached"
# Diff statged changes with a tool
alias gdti='git difftool --color --ignore-space-at-eol --cached'
# Diff last
alias gdl="git diff HEAD~1 HEAD"
