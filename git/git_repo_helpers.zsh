#!/bin/sh

# best practice: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
# set -Eeuxo pipefail

BITBUCKET_CLOUD_URL='https://bitbucket.org'
BITBUCKET_SERVER_URL='https://stash.atlassian.com'
GITHUB_URL='https://github.com'

_is_valid_git() {
   git rev-parse 2>/dev/null

    if [[ $? != 0 ]] then
      echo "Not a valid git repository."
      return 1
    fi
}

_clean_up_git_url()  {
  giturl=$1

  giturl=${giturl/git\@github\.com\:/https://github.com/}

  #remove subfix
  giturl=${giturl%\.git}
  # replace ":" --> "/"
  giturl=${giturl/\:/\/}
  # replace "git@" --> "https://"
  giturl=${giturl/git\@/https\://}

  echo "$giturl"
}

_get_bb_project() {
  project=$(basename `git rev-parse --show-toplevel`)
  teamName=$(git config --get remote.origin.url | awk -F'[:|/]'  '{ print $2 }')
  echo "$BITBUCKET_CLOUD_URL/$teamName/$project"
}


_get_stash_project() {
  project=$(git config --get remote.origin.url | awk -F[:/]  '{ print $6 }')
  repo=$(basename `git rev-parse --show-toplevel`)
  echo "$BITBUCKET_SERVER_URL/projects/$project/repos/$repo"
}

_get_github_project() {
  project=$(git config --get remote.origin.url | awk -F[:/]  '{ print $2 }')
  repo=$(basename `git rev-parse --show-toplevel`)
  echo "$GITHUB_URL/$project/$repo"
}

# Create PR in Bitbucket Cloud or Bitbucket Server
git_create_pr() {
  _is_valid_git
  if [[ $? != 0 ]] then
    return 1
  fi

  origin=$(git config --get remote.origin.url)
  currentBranchName=$(git rev-parse --abbrev-ref HEAD)
  url=''

  if [[ "$origin" = *bitbucket* ]]; then
    url="$(_get_bb_project)/pull-requests/new?source=$currentBranchName&dest=master"
  elif [[ "$origin" = *github* ]]; then
    url="$(_get_github_project)/compare/master...$currentBranchName"
  else
    url="$(_get_stash_project)/pull-requests?create&targetBranch=refs%2Fheads%2Fmaster&sourceBranch=refs%2Fheads%2F$currentBranchName"
  fi

  open "$url"
}

# Open Project UL in Bitbucket Cloud or Bitbucket Server
git_open_repo() {
  _is_valid_git
  if [[ $? != 0 ]] then
    return 1
  fi

  origin=$(git config --get remote.origin.url)
  url=""

  if [[ "$origin" = *bitbucket* ]]; then
    url="$(_get_bb_project)/src/master/"
  elif [[ "$origin" = *github* ]]; then
    url="$(_get_github_project)/"
  else
    url="$(_get_stash_project)/browse"
  fi

  open "$url"
}

# View current commit in local and open it in Web UI
git_view_current_commit_in_web() {
  _is_valid_git
  if [[ $? != 0 ]] then
    return 1
  fi

  origin=$(git config --get remote.origin.url)
  commit=$(git rev-parse HEAD);
  url=""

  if [[ "$origin" = *bitbucket* ]]; then
    url="$(_get_bb_project)/commits/$commit"
  elif [[ "$origin" = *github* ]]; then
    url="$(_get_github_project)/commit/$commit"
  else
    url="$(_get_stash_project)/commits/$commit"
  fi

  open "$url"
}
