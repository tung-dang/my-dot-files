#!/usr/bin/env sh

temp_branch="temp_branch"

echo " Remove all stashes"
git stash clear

git checkout --orphan temp_branch
git add -A  # Add all files and commit them
git commit
git branch -D master  # Deletes the master branch
git branch -m master  # Rename the current branch to master
git push -f origin master  # Force push master branch to github
git gc --aggressive --prune=all     # remove the old files
