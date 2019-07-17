#!/usr/bin/env bash

# This is a dangerous script because it will remove all commits of current branch.
# Use this for personal purpose only.
# @author: Tung Dang <tung.dang.js@gmail.com>

#=============================================================
# Declare global variables or constants
TODAY=$(date +"%Y%m%d-%H%M%n")

#=============================================================
get_current_branch_name() {
    branch_name=$(git symbolic-ref -q HEAD)
    branch_name=${branch_name##refs/heads/}
    branch_name=${branch_name:-HEAD}

    # return value;
    echo ${branch_name};
}

git_commit_all_files() {
    echo "## Commit all files..."
    git add . --all --verbose
    git commit -m "$TODAY - before cleaning all commits"
}

confirm_before_exec() {
    # Confirm before executing this dangerous scripts.
    read -p "- This is a dangerous script. Do you want to continue? (yes/no)" confirm;

    if [ "$confirm" != "yes" ]; then
        echo "- Aborting by user" >&2
        exit 1;
    fi

    echo "- Continue executing...";
}

#=============================================================
# entry point
main() {
    confirm_before_exec

    #=============================================================
    # Check all neccesary information

    current_branch_name="$(get_current_branch_name)";
    # check length of string is zero
    if [ -z "$current_branch_name" ]; then
        echo "- Can not find current git branch => Aborted!"
        exit 1;
    # else
    #   readonly current_branch_name;
    fi

    echo "- Affect current branh: $current_branch_name";

    #=============================================================

    IS_HAS_UNCOMMITTED=$(git diff --exit-code --quiet --cached 2>&1)

    if ! ${IS_HAS_UNCOMMITTED}; then
        echo "- Aborting due to uncommitted changes in the index" >&2
        exit 1;
    fi

    git_commit_all_files

    echo "- Creating a temp branch..."
    git checkout --orphan newBranch

    git_commit_all_files

    echo "- Deleting current branch: $current_branch_name"
    git branch -D "$current_branch_name"

    echo "- Rename the temp branch to current branch"
    git branch -m "$current_branch_name"

    git push --set-upstream origin "$current_branch_name" --force

    echo "- Cleaning Complete!"
    echo "==================================================="
    echo "Please check again and git push force to remove origin"
    exit
}

all_args=$@;
main "$all_args"
