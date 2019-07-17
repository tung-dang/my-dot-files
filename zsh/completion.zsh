# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
# for option in autocd globstar; do
# 	shopt -s "$option" 2> /dev/null;
# done;

# Add tab completion for many Bash commands
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#     . $(brew --prefix)/etc/bash_completion
# fi


# source "$ZSH_DF/git/git-completion.zsh";

# enable custom autocompletion
# fpath=(~/.shellrc/zshrc.d/completion $fpath)

# enable the famous zsh tab-completion system
# autoload -U compinit && compinit
# zmodload -i zsh/complist

# use parameter expansion, command substitution and arithmetic expansion
# setopt prompt_subst

# do not print an error when using '*'. '~' and '=' without anything to complete
# e.g. sudo ls /etc/sudoers.d/*
# setopt nonomatch

# use a menu for auto-completion
# zstyle ':completion:*:*:*:*:*' menu select

# use cache for auto-completion
# zstyle ':completion::complete:*' use-cache 1
# zstyle ':completion::complete:*' cache-path $ZSH/cache/

# use colors for auto-completion
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
# zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm"

# enable "cd -" autocomletion
# setopt auto_pushd
# zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# use /etc/hosts and known_hosts for hostname completion
# [ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _global_ssh_hosts=()
# [ -r $HOME/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
# [ -r $HOME/.ssh/config ] && _ssh_config=($(cat $HOME/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()
# [ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)$HOME$HOME"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

# hosts=(
#   "$_ssh_config[@]"
#   "$_global_ssh_hosts[@]"
#   "$_ssh_hosts[@]"
#   "$HOST"
#   localhost
# )

# zstyle ':completion:*:hosts' hosts $hosts

# do not auto-complete users
# zstyle ':completion:*' users off

# do not use adb autocompletion
# compdef -d adb
