#!/bin/sh
#
# undo last commit, keep the changes
alias g_reset_1='git reset HEAD~1'

#undo last commit, erase the. Naturally, be careful when using the last option as your local files will be discarded!
alias g_reset_2='git reset --hard HEAD~1'

#To remove all untracked files and folders:
alias g_clean='git clean -fd'

# https://github.com/blog/2019-how-to-undo-almost-anything-with-git
# throw last commit
alias g_throw_last_commit='git reset --hard HEAD^'

# Reset
alias grevertall='git reset --hard'

# revert a commit if it was pushed to remote origin. This is safe commit
alias g_revert='git revert '

# reverts the second to last commit
alias g_revert='git revert HEAD^'

# rever a commit if it was not pushed to remote origin.
# Like edit comment of the last commit
alias g_revert_local='git commit --amend'

# Undo your last commit, but don't throw away your changes
alias g_undo=git reset --soft HEAD^

#Scenario: You've made some commits locally (not yet pushed), but everything is terrible, you want to undo the last three commits—like they never happened.
# Undo with: git reset <last good SHA> or git reset --hard <last good SHA>
# What's happening: git reset rewinds your repository's history all the way back to the specified SHA. It's as if those commits never happened. By default, git reset preserves the working directory. The commits are gone, but the contents are still on disk. This is the safest option, but often, you'll want to "undo" the commits and the changes in one move—that's what --hard does.
