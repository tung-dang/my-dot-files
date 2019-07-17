# Setting for the new UTF-8 terminal support in Lion / Mountain Lion
# https://coderwall.com/p/ehvc8w/set-lang-variable-in-osx-terminal-app
export LANG="en_GB.UTF-8"
export LC_COLLATE="en_GB.UTF-8"
export LC_CTYPE="en_GB.UTF-8"
export LC_MESSAGES="en_GB.UTF-8"
export LC_MONETARY="en_GB.UTF-8"
export LC_NUMERIC="en_GB.UTF-8"
export LC_TIME="en_GB.UTF-8"
export LC_ALL="en_US.UTF-8"


# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";

# export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

# Grep ###########################################################

export GREP_COLOR='1;32'

# Tell grep to highlight matches
if is-supported "grep --color a <<< a"; then
    GREP_OPTIONS+=" --color=auto"
fi

# End Grep ###########################################################
