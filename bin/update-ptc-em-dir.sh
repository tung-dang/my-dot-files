#!/bin/bash

set -e
set -u

PTC_EM_DIR="@atlassian/ptc-embeddable-directory"
LATEST_VERSION=$(yarn info $PTC_EM_DIR version --silent)
FULL_PACKAGE_NAME_WITH_LATEST_VERSION=($PTC_EM_DIR"@"$LATEST_VERSION)

function before_upgrade() {
  nvm use
  bolt clean
  bolt
}

function after_upgrade() {
  ## Now let's dedupe...
  # echo " - Fixing yarn.lock duplicates"
  # bolt fix-lock-duplicates

  ## Now one last bolt to fix up the integrity field in yarn.lock
  echo " - One last bolt to fix up any integrity field issues"
  bolt

  echo " - Done!"
}

function upgrade_ptc_em_dir_package() {
  echo " - Upgrading $PTC_EM_DIR to $LATEST_VERSION"
  bolt upgrade "$FULL_PACKAGE_NAME_WITH_LATEST_VERSION"
}

function create_pr_from_branch() {
  local -r branchName="${1}"

  local -r stashUrl="https://stash.atlassian.com"
  local -r userName="${bamboo_build_doctor_username}"
  local -r password="${bamboo_build_doctor_password}"
  local -r stashProjectKey="CONFCLOUD"
  local -r stashRepoSlug="confluence-frontend"

  # This opens a PR and adds the bartenders to it. See here for reference
  # https://developer.atlassian.com/static/rest/bitbucket-server/5.3.1/bitbucket-rest.html#idm45682777077712
  curl -u "${userName}:${password}" -H "Content-Type: application/json" -X POST "${stashUrl}/rest/api/1.0/projects/${stashProjectKey}/repos/${stashRepoSlug}/pull-requests" \
    -d "{
        \"title\": \"Embeddable Directory in Confluence: ${branchName}\",
        \"description\": \"Upgrade `@atlassian/ptc-embeddable-directory` (https://bitbucket.org/atlassian/ptc-directory-ui/src/master/packages/embeddable-directory/) by this Bamboo build: ${bamboo_buildResultsUrl}. \",
        \"state\": \"OPEN\",
        \"open\": true,
        \"closed\": false,
        \"fromRef\": {
            \"id\": \"refs/heads/${branchName}\",
            \"repository\": {
                \"slug\": \"${stashRepoSlug}\",
                \"name\": null,
                \"project\": {
                    \"key\": \"${stashProjectKey}\"
                }
            }
        },
        \"toRef\": {
            \"id\": \"refs/heads/master\",
            \"repository\": {
                \"slug\": \"${stashRepoSlug}\",
                \"name\": null,
                \"project\": {
                    \"key\": \"${stashProjectKey}\"
                }
            }
        },
        \"locked\": false,
        \"reviewers\": [
            {
                \"user\": {
                    \"name\": \"tthanhdang\"
                }
            }
        ],
        \"links\": {
            \"self\": [
                null
            ]
        }
    }"
}

function create_commit_and_publish() {
  local -r branchName="$(git symbolic-ref --short -q HEAD)"

  if [[ "${branchName}" = "master" ]]; then
    echo " - Should not commit in master branch."
    exit 1;
  fi

  echo " - Current branch is ${branchName}"
  git status

  git commit -m "${branchName} - Automatically upgrade @atlassian/ptc-embeddable-directory ${bamboo_buildResultsUrl}"

  local -r remoteUrl="${bamboo_planRepository_repositoryUrl}"
  echo " - Setting git remote to ${remoteUrl}"
  git remote set-url origin $remoteUrl
  git push -u origin "${branchName}"

  # create_pr_from_branch "${branchName}"
}

function create_new_branch() {
  # Create a new branch
  DATE=`date +%Y-%m-%d-%H-%M-%S`
  TEMP_BRANCH_NAME="upgrade-ptc-em-dir-package-$DATE"
  echo " - Create branch ${TEMP_BRANCH_NAME}"
  git checkout -b "${TEMP_BRANCH_NAME}"
}

function main() {
  LINE=$(cat package.json | grep "$PTC_EM_DIR")
  echo " - Current: $LINE"
  echo " - The latest version of $PTC_EM_DIR: $LATEST_VERSION"

  # check if package.json already contains the latest version or not
  if [[ "$LINE" = *"$LATEST_VERSION"* ]]; then
    echo " - Skipped."
    exit 0;
  fi

  before_upgrade
  # there is already a previous step in Bamboo build to do bolt install in `bin/install.sh` file
  upgrade_ptc_em_dir_package
  after_upgrade

  echo " - Add files to git"
  git add "*.json" "yarn.lock"

  echo " - Create pull request"
  if [[ -n $(git status -uno --porcelain) ]]; then
    create_new_branch
    create_commit_and_publish
  else
    echo " - Nothing to update"
  fi
}

all_args=$@;
main "$all_args"
