#!/usr/bin/env bash

#defaults
declare date_command="date"
declare master_branch="refs/remotes/origin/master"
declare remote_refs_filter="refs/remotes/"
declare issue_filter="origin/.*issue"
declare date_filter=90 # 90 days default filter
declare todays_date=""
declare stats_only=0
declare verbose=0

function display_settings
{
    remote_url=$(get_remote_url)

    read -r -d '' SETTINGS <<-SETTINGS
Repository Cleaner Settings
=======================================
Repository URL:     $remote_url
Master Branch:      $master_branch
Remote Branches:    $remote_refs_filter
Issue Filter:       $issue_filter
Date Filter:        $date_filter
Stats Only:         $stats_only
Verbose:            $verbose
=======================================
SETTINGS

    echo "$SETTINGS"
}

function display_help
{
    read -r -d '' HELP <<-HELP

Repository Cleaner
==================
Repository Cleaner is a script that will iterate through all branches in the current remote git repository, identify
and delete old branches no longer required.

It uses the following criteria applied to the branches before it will safely delete a branch.

Criteria:
    1. It will only iterate through remote branches, specified by -r, currently: "$remote_refs_filter"
    2. It will apply a grep filter to all listed remote branches, so that it will only apply to specific branch
       types, specified by -f, currently: "$issue_filter".
    3. It will only apply to branches whos last commit was older than -d days, currently: "$date_filter".
    4. It will only apply to branches that have no commits ahead of the master branch, specified by -m, currently:
       "$master_branch".

Usage:
    repo-cleaner.sh [option] [option value] ...

Options:
    -m  --master        Specifies the master branch to be used for commit comparisons.
    -r  --remotes       Specifies the filter to be applied when listing remote branches, to filter out tags or other
                        branch types.
    -f  --filter        Specifies a grep filter to be applied to the list of available remote branches.
                        NOTE: When using wildcards, this is a grep filter, and wildcards should be prefixed
                        correctly, e.g., .*issue will search for "*issue", ".issue" for single character + issue.
    -d  --days          The amount of days to be used when determining branches for deletion.
    -s  --stats-only    When specified, it will not delete branches and instead process them and display stats only.
    -v  --verbose       Verbose output, will output information for each branch iterated over.
    -h  --help          Displays this page.

The above options can be tested by passing them to the script, and including the --help option.  When done like this,
the "Criteria" above will be updated with the arguments passed in.

HELP

    echo "$HELP";
    exit;
}

function get_date_command()
{
    local default_command="date"
    local os_type=$(uname -s)

    if [[ "$os_type" == "Darwin" ]] ; then
        default_command="gdate"
    fi

    echo $default_command
}

function date_diff() # (from, to)
{
    local from="$1"
    local to="$2"
    local from_command="$date_command -ud '$from' +'%s'"
    local to_command="$date_command -ud '$to' +'%s'"

    echo $(( ( $(eval $from_command) - $(eval $to_command) )/60/60/24 ))
}

function initialise()
{
    date_command=$(get_date_command)
    todays_date=$($date_command -I)
}

function get_remote_url()
{
    git config --get remote.origin.url
}

function get_remote_branches()
{
    git for-each-ref --format='%(committerdate:short),%(refname)' --sort -committerdate $remote_refs_filter | grep $issue_filter
}

function get_commit_count() # (remote_branch)
{
    local remote_branch=$1
    local commits=$(git rev-list --right-only $master_branch...$remote_branch ^$master_branch --)
    local commit_count=${#commits[@]}

    if [[ -z "$commits" ]]; then
        commit_count=0
    fi;

    echo $commit_count
}

function delete_branch() # (remote_branch)
{
    echo "deleting $1"
}

function process_remote_branches()
{

    get_remote_branches |
    {
        local branch_count=0
        local old_branches=0
        local eligible_branches=0
        local ineligible_branches=0
        local deleted_branches=0

        while read remote_branch
        do
            ((branch_count++))

            local remote_branch_data=$(echo $remote_branch | tr "," "\n")
            local branch_data=(${remote_branch_data//$'\n'/ })

            local branch_date=$(echo "${branch_data[0]}")
            local branch_name=$(echo "${branch_data[1]}")

            local branch_age=$(date_diff $todays_date $branch_date)

            local branch_message=""

            if [[ "$branch_age" -gt "$date_filter" ]]; then
                ((old_branches++))

                local commit_count=$(get_commit_count $branch_name)

                if [[ "$commit_count" -eq "0" ]]; then
                    ((eligible_branches++))

                    branch_message="branch: \"$branch_name\" is $branch_age days old with no commit(s) ahead of master, eligible for deletion."

                    if [[ "$stats_only" -eq "0" ]]; then
                        ((deleted_branches++))

                        delete_branch $branch_name
                    fi
                else
                    ((ineligible_branches++))

                    branch_message="branch: \"$branch_name\" is $branch_age days old with $commit_count commit(s) ahead of master, not eligible for deletion."
                fi
            else
                branch_message="branch: \"$branch_name\" is $branch_age days old, not eligible for deletion."
            fi

            if [[ "$verbose" -eq "1" ]]; then
                echo "$branch_message"
            fi
        done

        echo ""
        echo "Branch Information"
        echo "  Total Branches:         $branch_count"
        echo "  Old Branches:           $old_branches"
        echo "  Eligible Branches:      $eligible_branches"
        echo "  Ineligible Branches:    $ineligible_branches"
        echo "  Deleted Branches:       $deleted_branches"
        echo ""
        echo "Processing Complete!"
    }

}

# Program Arguments
if [[ $# > 0 ]]; then
    while [[ $# -gt 0 ]] #|| "$1" -eq "-h" || "$1" -eq "--help" ]]
    do
        key="$1"

        case $key in
            -m|--master)
            master_branch="$2"
            shift
            ;;
            -r|--remotes)
            remote_refs_filter="$2"
            shift
            ;;
            -f|--filter)
            issue_filter="$2"
            shift
            ;;
            -d|--days)
            date_filter="$2"
            shift
            ;;
            -s|--stats-only)
            stats_only=1
            ;;
            -h|--help)
            display_help
            ;;
            -v|--verbose)
            verbose=1
            ;;
            *)
            break
            ;;
        esac

        shift
    done
fi

display_settings
initialise

echo "Starting at: " $($date_command -Iseconds)

process_remote_branches

echo "Finished at: " $($date_command -Iseconds)
