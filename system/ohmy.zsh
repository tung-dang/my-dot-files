#!/usr/bin/env zsh

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# we use https://github.com/sindresorhus/pure instead
ZSH_THEME=""

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  z
  jump
  history
  colorize
  cp
  ssh-agent
  zsh-syntax-highlighting
  zsh_reload
)

source $ZSH/oh-my-zsh.sh
