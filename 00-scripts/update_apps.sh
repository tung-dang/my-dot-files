#!/bin/sh

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
sudo softwareupdate -i -a;


pip install --upgrade pip
pip install --upgrade wheel
pip install --upgrade setuptools

brew update;
brew upgrade;
brew cleanup;

sudo gem update --system;
sudo gem update

sudo port -v selfupdate
