#!/bin/sh

# General
alias g='git'
alias gs='git status'

# Pull & Push
alias gpl='git pull'
gps() {
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  git push --set-upstream origin $current_branch
}

alias gaa='git add .'
alias gac='git add . && git commit -v -m'
alias gci='git commit -m'
alias gcom='git checkout master'



# Use the last commit message and amend your stuffs.
alias g_amend='git commit --amend -C HEAD'

# Changes
alias gw='git whatchanged'

# Ammend previous commit
alias gcaa='gca --amend'

alias g_sync='git pull -r && git push'
alias gpsf='git push --force'


# Git show
alias gpr='git fetch origin -v; git fetch upstream -v; git merge upstream/master'

# Merge
alias gm='git merge --no-ff'
alias gmf='git merge --ff-only'

alias gcp='git cherry-pick'

# remove untracked files and folders
alias gca='git clean -fd'

# Scenario: You accidentally added application.log to the repository, now every time you run the application, Git reports there are unstaged changes in application.log. You put *.log in the .gitignore file, but it's still there—how do you tell git to to "undo" tracking changes in this file?
alias g_remove_remote_files_only='git rm -r --cached'
