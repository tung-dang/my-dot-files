#!/bin/sh

# install homebrew
sh "$ZSH_DF/00-scripts/_install-homebrew.sh";

echo "Installing Apple Developer Tools";
xcode-select --install


############################
echo "Install homebrew packages"
brew update
brew tap homebrew/cask
brew install cask
brew tap homebrew/cask-fonts 
brew tap homebrew/cask-versions

############################
echo "Install command line tools"
brew install python3
brew install bash-completion
brew install git git-extras git-lfs git-smart

##################################################
echo "Install dev environments"
brew cask install java caskroom/homebrew-versions/java8

echo "Install Ruby stuff"
brew install rbenv ruby-build

echo "Install packpage managers"
brew install nvm mvnvm

##################################################
echo "Version control"
brew install hub
brew cask install sourcetree

##################################################
echo "Installing terminal apps"
brew install the_silver_searcher
# Install GNU packages (and override OSX version)
brew install z grc coreutils dockutil
brew install gnu-sed --default-names
brew install grep --default-names
brew install ccat watchman

brew install terminal-notifier
brew install util-linux
brew install jq tree wget shellcheck peco ssh-copy-id

echo "Installing db apps"
brew install postgresql


echo "Installing browser apps"
brew cask install firefox google-chrome google-chrome-canary

ehco "Install editors"
brew install visual-studio-code
brew cask install sublime-text intellij-idea webstorm vscode

echo "Installing must-have apps"
brew cask install iterm2 dash postman docker
brew cask install dropbox skype
brew cask install vlc path-finder virtualbox
brew cask install caffeine spectacle appcleaner
brew cask install gimp xmind screenflow burn xnconvert
brew cask install aerial imagemagick imageoptim
brew cask install diffmerge typora
brew install zoxide
brew install starship
brew install fzf

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webp-quicklook suspicious-package && qlmanage -r

# Alfred integration for Homebrew (https://github.com/caskroom/homebrew-cask/blob/master/USAGE.md#alfred-integration)

# echo utils
brew install htop wget bat

echo " - Installing fira-code fonts..."
brew cask install font-source-code-pro font-fira-code

# react
# https://github.com/CVarisco/create-component-app
yarn global add create-component-a
# https://github.com/diegohaz/generact
npm install -g generact

############################
echo "You can run /bin/set-defaulst.sh to set default settings for your OS"

exit 0


