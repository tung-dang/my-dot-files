## create a dir and then go into the new dir
take ()
{
    mkdir $1
    cd $1
}

# Makes a directory and changes to it.
mkdcd() {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
cdls() {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Finds files and executes a command on them.
find-exec() {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
psu() {
  ps -U "${1:-$USER}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}


diff() {
  git --no-pager diff --color=auto --no-ext-diff --no-index "$@"
}


open_chrome_canary_with_access_local_files() {
  "~/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary" \
   --disable-web-security \
   --disable-gpu \
   --allow-file-access-from-files \
   --user-data-dir=~/chromeTemp
}
