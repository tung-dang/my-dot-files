#!/bin/sh

alias mba='mvn clean install -Pit,full,source,skipIntegrationTests -Dmaven.test.skip.exec=true  -Dmaven.test.skip=true'

# build the package and install artifacts in local maven repo
alias mci_not_test='mvn clean install -Dmaven.test.skip -DskipTests'

# just build the package but do not install artifacts in local maven repo
alias mpk_not_test='mvn package -Dmaven.test.skip -DskipTests'

alias qr='mvn clean install -Dmaven.test.skip -DskipTests && cp -f ./target/*.jar ~/confluence_quickreload/'

# start vertigo confluence via volt to match bin/vertigo conventions (from plugin directory)
# DISABLE_DEV_MODE 1 -> prevents atlassian.dev.mode=true
# NODES 1 -> enables rsync ports
# project-name -> docker compose project name
# project-dir -> directory to mount from host that quickreload will monitor -- MUST be full path
alias conf_volt='volt up -e DISABLE_DEV_MODE 1 -e NODES 1 --port 80 --project-name dev --project-dir $(pwd)/vertigo-qr confluence-dev:latest'

# Wait for confluence to start
alias conf_volt_wait='volt wait --timeout 360 --url http://localhost/wiki/internal/healthcheck'
alias micros cli -- "$@"
alias a="atlas"
