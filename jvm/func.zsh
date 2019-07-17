# if [ -f $HOME/.defaultjdk ]; then
#     export JAVA_HOME=`cat $HOME/.defaultjdk`
#     echo "* JAVA_HOME: $JAVA_HOME"
# fi

## switch java version
switchJava() {
    if [ $# -ne 0 ]; then
        if [ -z "$1" ]; then
            echo $JAVA_HOME
        else
            removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
            if [ -n "${JAVA_HOME+x}" ]; then
                removeFromPath $JAVA_HOME
            fi

            export JAVA_HOME=`/usr/libexec/java_home -v $1`
            export PATH=$JAVA_HOME/bin:$PATH
        fi
    fi

    info "Now JAVA_HOME is: $JAVA_HOME";
}

defaultJava() {
    if [ -z "$1" ]; then
        cat $HOME/.defaultjdk
    else
        switchjava $1
        echo $JAVA_HOME > $HOME/.defaultjdk
    fi
    info "Now JAVA_HOME is: $JAVA_HOME";
}

removeFromPath() {
    export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

