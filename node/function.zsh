##############################################################
## Some times, we do not know how to deal with a problem
## This function is a last resort.
##############################################################
clean_everything_in_node() {
    echo "Current npm version is: ";
    npm -v;

    echo "Removing npm-shrinkwrap.json file...";
    rm -rf ./npm-shrinkwrap.json;

    echo "Removing node_modules folder...";
    rm -rf ./node_modules;

    echo "Clearing npm cache (ex: in ~/.npm/)...";
    npm cache clean;

    echo "Empty cache directory for nvm";
    nvm cache clean;

    #echo "Clean up all node libs"
    #sudo rm -rf /usr/local/lib/node_modules
}

##############################################################
# Kill all nodes processes
##############################################################
kill_node_apps() {
    echo "1 - List of node processes will be killed: ";
    lsof -i | grep node
    echo "2 - Killing:"
    lsof -i | grep node | awk '{print $2}' | xargs kill -9
}

##############################################################
# Kill a process by port number
##############################################################
kill_port() {
    echo "1 - List of processes are listening on port: $1";
    lsof -i TCP:$1 | grep LISTEN;

    echo "2 - Staring to kill all process listening on port $1";
    lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9
    ding;
}


##############################################################
# Update system node path to nvm default node path
##############################################################
update_system_node_path() {
    SYSTEM_NODE_PATH="/usr/local/bin/node"
    USER_NODE_PATH="/usr/bin/node"
    NVM_DEFAULT_NODE_PATH="$(nvm which default)"

    sudo ln -Ffsv "$NVM_DEFAULT_NODE_PATH" "$SYSTEM_NODE_PATH"
    sudo ln -Ffsv "$NVM_DEFAULT_NODE_PATH" "$USER_NODE_PATH"
}



##############################################################
# List all command in scripts of package.json file
##############################################################
pkg_ls_cmds() {
  jq ".scripts" package.json
}
