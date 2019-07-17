#!/usr/bin/env bash

# bootstrap installs things.
DOTFILES_ROOT="`cd .. && pwd`"

set -e
echo "==========================Begin==============================";
echo "DOTFILES_ROOT=$DOTFILES_ROOT";

link_files() {
    echo " - Linking from $1 to $2 ..."
    ln -s "$1" "$2"
}

# setup_st3() {
#     ST3_HOME="$HOME/Library/Application Support/Sublime Text 3";
#     echo "ST3_HOME=$ST3_HOME";
#     cd "$ST3_HOME";

#     # check if ST3_HOME exist or not
#     #echo [ ! -d "$ST3_HOME" ] && echo "YES";
#     if [ ! -d "$ST3_HOME" ]; then
#         echo "Bootstrapping ST3 Package Control";

#         mkdir -p "$ST3_HOME/Installed Packages";
#         mkdir -p "$ST3_HOME/Packages";

#         curl -s https://sublime.wbond.net/Package%20Control.sublime-package > "$ST3_HOME/Installed Packages/Package Control.sublime-package"
#         echo "Package Control installed.";
#     fi

#     #echo [ ! -L "$ST3_HOME/Packages/User" ] && echo "YES";
#     if [ ! -L "$ST3_HOME/Packages/User" ]; then

#         # echo [ -d "$ST3_HOME/Packages/User" ] && echo "YES";
#         if [ -d "$ST3_HOME/Packages/User" ]; then
#             echo "Backing up old ST3 Packages/User directory."
#             mv "$ST3_HOME/Packages/User" "$ST3_HOME/Packages/User.backup"
#         fi

#         link_files "$DOTFILES_ROOT/sublime3" "$ST3_HOME/Packages/User";
#         echo "Set up ST3 Packages/User symlink."
#     fi
# }

# setup_iterm2() {
#     if [ $TERM_PROGRAM == "iTerm.app" ]; then
#         echo "Can't reconfigure iTerm when bootstrap is run from it. Run me from Terminal.app."
#         echo
#     else
#         echo "Setting up iTerm2"
#         killall iTerm 2>/dev/null || true
#         cp $DOTFILES_ROOT/iterm2/monokai.iterm2.plist $HOME/Library/Preferences
#         killall cfprefsd
#         mkdir -p $HOME/Library/Fonts
#         cp $DOTFILES_ROOT/fonts/* $HOME/Library/Fonts
#         echo "iTerm2 preferences updated."
#     fi
# }


# setup_gitmodules() {
#   echo "Updating git submodules"
#   cd $DOTFILES_ROOT
#   git submodule init > /dev/null 2>&1
#   git submodule update > /dev/null 2>&1
#   echo "Git submodules updated"
# }

install_dotfiles () {
    echo ' - Start installing dotfiles'

    # check $HOME/dev/dotfiles exist or not
    dotfiles="$HOME/dev/dotfiles"

    if [[ -d "$dotfiles" ]]; then
        echo "Begin symlinking dotfiles from $dotfiles"
    else
        link_files "$DOTFILES_ROOT" "$dotfiles";
    fi

    # local vars
    overwrite_all=false
    backup_all=false
    skip_all=false

    for source in `find $DOTFILES_ROOT -maxdepth 2 -name \*.symlink`; do
        dest="$HOME/.`basename \"${source%.*}\"`"

        if [ -f $dest ] || [ -d $dest ]; then
            overwrite=false
            backup=false
            skip=false

            # begin if
            if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then
                echo "File already exists: `basename $source`, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
                read -n 1 action

                case "$action" in
                    o )
                        overwrite=true;;
                    O )
                        overwrite_all=true;;
                    b )
                        backup=true;;
                    B )
                        backup_all=true;;
                    s )
                        skip=true;;
                    S )
                        skip_all=true;;
                    * )
                        ;;
                esac
            fi
            # end if

            if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]; then
                rm -rf $dest
                echo "removed $dest"
            fi

            if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]; then
                mv $dest $dest\.backup
                echo "moved $dest to $dest.backup"
            fi

            if [ "$skip" == "false" ] && [ "$skip_all" == "false" ];then
                link_files $source $dest
            else
                echo "skipped $source"
            fi

        else
            link_files $source $dest
        fi

    done
}


#Begin execution =====================================

install_dotfiles
#install_bin
#setup_iterm2

echo "==========================End==============================";
echo ' -  All installed!';
