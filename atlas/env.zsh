#!/bin/sh
#============================================================
# Helper methods

## prependPath new items to path (if directory exists)
prependPath() {
    [ -d $1 ] && PATH="$1:${PATH}"
}
#============================================================
export ATLAS_HOME="/usr/local/Cellar/atlassian-plugin-sdk/6.2.2/libexec";
export MAVEN_HOME="$HOME/.mvnvm/apache-maven-3.2.5"
export MAVEN_COLOR=true;
export ATLAS_MVN="${MAVEN_HOME}/bin/mvn"
export MAVEN_OPTS="-Xms512m -Xmx1536g -XX:MaxPermSize=256m -XX:+TieredCompilation -XX:TieredStopAtLevel=1"
export DOCKER_HOST=unix:///var/run/docker.sock
export SHOW_DEVMETRICS=true
#eval "$(docker-machine env 'default')"
#============================================================
# Set up Atlassian Scripts
# pathAtlasScript="$HOME/src/_dev/atlassian-scripts"

# if [ -d "$pathAtlasScript" ]; then
#     prependPath "$pathAtlasScript/bin"
#     export ATLASSIAN_SCRIPTS="$pathAtlasScript"
# else
#     echo " - Can not find $pathAtlasScript"
# fi
