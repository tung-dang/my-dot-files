#!/bin/sh

# Run Confluecn as standalone
# $1: CONF version, ex: 5.5.1
atlas_run_conf() {
    VERSION=$1;

    echo ------------Atlassian Product Standalone Startup Script-------------
    echo "___________Confluence $VERSION standalone ____________"
    echo .
    echo .
    echo .

    CONF_VERSION="-v $VERSION"
    CONF_PORT="-p 8100"

    #BUNDLE_PLUGIN = "--bundled-plugins com.atlassian.plugins:atlassian-connect-plugin:1.0.2,com.atlassian.jwt:jwt-plugin:1.0.0,com.atlassian.bundles:json-schema-validator-atlassian-bundle:1.0-m0"
    RESOURCE_PATH="-Dplugin.resource.directories="
    DEBUG_MODE="-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=n";
    DEV_MODE="-Datlassian.dev.mode=true -Datlassian.disable.caches=true -Datlassian.webresource.disable.minification=true -Dconfluence.context.batching.disable=true -Dplugin.webresource.batching.off=true -DallowGoogleTracking=false -Djava.compiler=NONE"
    MEMORY="-Xmx2048m -Xms1024m -XX:MaxPermSize=512m"

    atlas-run-standalone --product 'confluence' -v $VERSION -p '8100' --jvmargs "MEMORY" $DEV_MODE

    echo "done!"
}


atlas_run_jira() {
    atlas-run-standalone --product jira --version 7.2.1 --jvmargs "-Xmx4096m -Xms1000m" -Datlassian.dev.mode=false
}

## install plugin to local CONF instance
function cpi() {
    cdTo plugin;

    # default port is 8080
    default_port=${1:-8080}
    # skip_test="-Dmaven.test.skip -DskipTests";
    # port="-Dhttp.port=$default_port";
    # sysAdmin="-Dusername=sysadmin -Dpassword=sysadmin";
    # context_path="-Dcontext.path=wiki"
    # command="clean package"
    mvn clean package \
        -Dmaven.test.skip -DskipTests \
        -Dhttp.port=$default_port \
        -Dcontext.path=wiki \
        -Dusername=sysadmin -Dpassword=sysadmin \
        confluence:install
    # atlas-install-plugin -p $PORT --username $USER_NAME --password $PASS --server http://localhost --context-path $CONTEXT_PATH
}

atlas_run_webdriver_test() {
    conf_version="5.7";
    file_log="file.log";

    if [[ -n "$1" ]]; then
        conf_version="$1";
    fi

    rm -rf "$file_log"
    mvn -e clean package javadoc:aggregate verify -Plibrary-test -Datlassian.dev.mode=false -Datlassian.product.version="$conf_version" -Datlassian.product.data.version="$conf_version" -Dconfluence.version="$conf_version" -Dconfluence.data.version="$conf_version" -Datlassian.product.test-lib.version=2.6 -Dusername=bamboo-svn -Dxvfb.enable=true -Datlassian.dev.mode=false -B > "$file_log"
}

atlas_run_a_test() {
    # Configuration
    MODULE="tests/integration-tests-parent/integration-tests"
    TEST="ServiceDeskConnectSLAT"
    HOST="freezer-instance-12.jira-dev.com"
    LOGS_FILE="slat-logs.txt"

    ARGS="-Dtest.ondemand -Djira.host=$HOST -Dbaseurl.jira=https://$HOST -Dhttp.jira.port=443 -Dcontext.jira.path=''"
    MVN_TEST_CMD="mvn -pl $MODULE -Dtest=$TEST test $ARGS"

    for i in `seq 100`; do
        echo "Running test $i time" | tee -a $LOGS_FILE
        $MVN_TEST_CMD 2>&1 | tee -a $LOGS_FILE
    done
}

## Clear all Confluence data and re-setup db
clear_conf_data() {
    export PGUSER=postgres
    export PGPASSWORD=postgres


    CONFLUENCE_HOME="/Users/tthanhdang/dev/data/conf-cloud-master"
    echo " - Step #1: Removing Confluence home folder: $CONFLUENCE_HOME"
    rm -rf $CONFLUENCE_HOME
    echo " - Finish step #1"

    echo " - Step 2: Clearing Confluence data"
    psql --command "drop database confluence"
    psql --command "CREATE database confluence ENCODING 'UTF-8' OWNER postgres;"
    echo " - Finish step #2"
}

start_conf_in_connect() {
    address_inner_conntainer=$(docker port connect-postgres 5432)
    port_innert_container=$(echo $address_inner_conntainer | cut -d: -f2)

    echo "- port_inner_container: $port_innert_container"

    mvn -pl plugin amps:debug -Dproduct=confluence -Dvertigo.startup.enabled=true -Ddatabase.port=$port_innert_container
}

start_jira_in_connect() {
    port_innert_container=$(docker port connect-postgres 5432 | cut -d: -f2)
    echo "- port_inner_container: $port_innert_container"
    mvn -pl jira/jira-integration-tests amps:debug -Dvertigo.startup.enabled=true -Ddatabase.port=$port_innert_container
}


start_conf() {
    # Open Docker: It may take up to a minute for Docker to fully start
    # open /Applications/Docker.app;
    open --background -a Docker

    # Start Posgree
    pg_ctl start

    # start CONF
    ~/src/cloud/confluence-cloud/scripts/build.rb --run-custom;
}

stop_conf() {
    # stop Docker
    killall Docker
    # docker ps -q | xargs -L1 docker stop

    # stop Postgres
    pg_ctl stop

    # stop Conf
    PID=`ps aux | grep java | grep confluence | awk '{print $2}' | xargs kill -9`
}


toggle_func() {
    FF=$1
    isEnable=$2

    curl -XPUT -u sysadmin:sysadmin -H 'X-Atlassian-Token: no-check' "http://tango.localhost.atl-test.space:80/wiki/rest/featureflag/latest/site/set/$FF/$isEnable"
}

start_legion() {
  mvn clean install -DskipTests && mvn nanos:start
}

stop_legion() {
  mvn nanos:stop
}

start_jira_clean() {
  rm -rf ./node_modules && yarn && killall watchman && yarn start jira-spa --ngrok-subdomain tung-test
}
