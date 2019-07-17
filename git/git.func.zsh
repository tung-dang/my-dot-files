#!/bin/sh

################################################################################################

grb_i() {
    git rebase -i "HEAD~${1}"
}

# delete and remove tag
g_tag_remove_local_and_remote() {
    git tag -d "${1}"
    git push origin ":refs/tags/${1}"
}


# push everything
gpsa() {
    git add --all
    git commit -m "update :)"
    git push
}


# find large binary file in repo
# g_find_large_file() {
#     git verify-pack -v .git/objects/pack/pack-*.idx |
#     grep blob | sort -k3nr | head |
#     while read s x b x; do
#       git rev-list --all --objects | grep "$s" |
#       awk '{print "'"$b"'",$0;}';
#     done
# }

# Create an issue branch (which has `issue/` prefix ) from latest master code.
# 1. Pull origin/master
# 2. Create a new issue branch
g_create_new_branch_from_master() {
    JIRA_TICKET=$1

    if [ -z "$JIRA_TICKET" ]
    then
        echo " + Missing JIRA ticket number!"
        return
    fi

    # 01 - saving stash
    # unique timestamp
    t=timestamp-$(date +%s)
    # stash with message
    echo " + Saving..."
    stash=$(git stash save $t)
    # check if the value exists
    isHasStash=$(echo $stash | grep $t)

    # 02 - get latest changes from master
    echo " + Checkout master branch and pull origin"
    git checkout master
    git pull

    # 03 - create a new issue branch
    echo " + Creating a new issue branch: 'issue/$JIRA_TICKET'"
    git checkout -b "issue/$JIRA_TICKET"

    # 04 - restore stash if necessary.
    if [ -z "$isHasStash" ]
    then
        # remove last stash
        git stash drop stash@{0}
    else
        echo " + Nothing to restore from stash list."
    fi
}

revert_pull_request() {
    HASH=$1
    git checkout -b "fixing-master/revert_$HASH"
    git revert -m 1 "$HASH"
    # git push  # open a PR, ask anyone nearby to approve it, and merge immediately
}

open_jira_ticket() {
    current_branch_name=$(g_get_current_branch_name);
    ISSUE=${current_branch_name#"issue/"};
    open "$JIRA_URL$ISSUE"
}

clear_git_history() {
    # create a new branch
    git checkout --orphan latest_branch

    # Add all the files
    git add -A

    # Commit the changes
    git commit -am "initial commit"

    # Delete the master branch
    git branch -D master

    # Rename the current branch to master
    git branch -m master

    # Finally, force update your repository
    git push -f origin master
}

g_commit_and_push_to_override_last_commit() {
    git add .
    git commit --amend --quiet --no-edit;
    git push --force
}
