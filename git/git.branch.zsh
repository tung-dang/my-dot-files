#!/bin/sh

# Show the list of local branches
alias gb='git branch --color -v'
alias gbr='git branch -r'

# rename current branch
alias g_branch_rename='git branch -m '

# delete local branch
g_remove_current_local_branch() {
    current_branch_name=$(git rev-parse --abbrev-ref HEAD)

    echo " - Switch to master branch:"
    git checkout master

    echo " - Removing local branch: $current_branch_name"
    git branch -D "$current_branch_name"
}

# remove merged branches. Thanks @Nathanh Hoad:
# https://nathanhoad.net/git-how-to-remove-merged-branches
# https://plus.google.com/115587336092124934674/posts/dXsagsvLakJ
alias git_remove_merged_branches='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

g_get_current_branch_name() {
    #current_branch_name=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
    branch=$(git rev-parse --abbrev-ref HEAD)
    printf "%s" "$branch";
}

# delete branch and remote branch
g_remove_branch_local_and_remote() {
    git branch -D "${1}"
    git push origin --delete "${1}"
    git pull
}

g_remove_branch_remote() {
    git push origin --delete "${1}"
    git pull
}

# Rename and remote branch at the same time
g_branch_rename_local_and_remote () {
    old_branch=${1}
    new_branch=${2}

    # Rename branch locally
    git branch -m $old_branch $new_branch
    # Delete the old remote branch
    git push origin ":$old_branch"
    # Push the new branch, set branch to track the new remote
    # git push --set-upstream origin $new_branch
    # From: http://stackoverflow.com/questions/4753888/git-renaming-branches-remotely
    # git push origin origin/$old_branch:refs/heads/$new_branch ":$old_branch"
    git branch -u "origin/$new_branch" "$new_branch"
}


# rebase with a target branch
# @usage: grb master
# It will do following steps:
# 1. Checkout master
# 2. Pull origin master branch
# 3. Back to the original branch
# 4. Rebase the original branch with master
grb() {
    current_branch_name=$(g_get_current_branch_name);
    target_branch_name=${1}

    printf '+ Current branch: %s' "$current_branch_name"
    printf '+ Switch to target branch & pull: %s' "$target_branch_name"
    git checkout "$target_branch_name" && git pull

    git checkout "$current_branch_name"

    printf "+ Start to rebase"
    git rebase "$target_branch_name"
}

# merge with a target branch
# @usage: gmerge master
gmerge() {
    # TODO: save stash and pop up the stash if have

    current_branch_name=$(g_get_current_branch_name);
    target_branch=${1}
    git checkout "$target_branch" && git pull
    git checkout "$current_branch_name"
    git merge "$target_branch"
}

# Copy the current branch name to the clipboard.
g_copy_branch_name () {
    branch=$(g_get_current_branch_name);
    printf "%s" "$branch"
    echo "$branch" | tr -d '\n' | tr -d ' ' | pbcopy
}

g_lis_merged_branch() {
  for branch in `git branch -r --merged | grep -v HEAD`; do
    echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch;
  done | sort -r
}

g_list_merged_branch_2() {
  while read branch; do
    git log --no-walk $(git show-ref -s $branch);
  done < <( git branch -r --no-merged | egrep -v "(origin/master)" )
}

g_list_merged_branch_3() {
  while read branch; do
    git show-ref $branch;
  done < <(git branch -r --merged | grep -v master)
}


