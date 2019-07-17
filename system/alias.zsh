# Reload the shell (i.e. invoke as a login shell)
alias reload="clear && exec $SHELL -l"

# Shortcuts
alias h="history"
alias j="jobs"
alias j='jump'
alias w='which'
alias rr="rm -rfv"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# URL-encode strings
# alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
# alias plistbuddy="/usr/libexec/PlistBuddy"

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
# alias badge="tput bel"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
# alias map="xargs -n1"

# Recursively delete `.DS_Store` files
# alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"


# List declared aliases, functions
# alias listaliases="alias | sed 's/=.*//'"
# alias listfunctions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'" # show non _prefixed functions


# alias bd=". bd -s"

# Webserver
# alias srv="sudo http-server $HOME/Projects/ -p 80 -c-1"

# Network
# alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# cdl() { cd $1; ls;}

# http://lifehacker.com/5778769/make-the-man-command-more-useful-in-linux-and-os-x
man () {
    /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

# mkdir, cd into it
mkcd() {
    # `$*` segment of the function, which expands all arguments and puts them between the quotes.
    mkdir -p "$*"
    cd "$*" # or cd !$
}


# copy current path to clipboard
alias copy_current_path='pwd|pbcopy'
