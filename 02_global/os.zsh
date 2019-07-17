#!/usr/bin/env bash

# Pipe my public key to my clipboard. Fuck you, pay me.
alias pubkey="more ~/.ssh/id_dsa.public | pbcopy | echo '=> Public key copied to pasteboard.'"
alias ssh_list="cat ~/.ssh/config"
alias air_drop_disable=" defaults write com.apple.NetworkBrowser DisableAirDrop -bool YES"
alias air_drop_enable=" defaults write com.apple.NetworkBrowser DisableAirDrop -bool NO"


# to know when stuff's over
alias ding='osascript -e "display notification \"Ding\" sound name \"Glass\""'

