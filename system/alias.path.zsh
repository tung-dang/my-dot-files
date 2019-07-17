# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"
alias cd.='cd $(readlink -f .)'

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi


# ls
LS_COLORS=`is-supported "ls --color" --color -G`
LS_TIMESTYLEISO=`is-supported "ls --time-style=long-iso" --time-style=long-iso`
LS_GROUPDIRSFIRST=`is-supported "ls --group-directories-first" --group-directories-first`

#alias l="ls -lahA ${LS_COLORS} ${LS_TIMESTYLEISO} ${LS_GROUPDIRSFIRST}"
#alias ll=l
#alias la="ls -1Fcart ${LS_COLORS} ${LS_TIMESTYLEISO} ${LS_GROUPDIRSFIRST}"
#unset LS_COLORS LS_TIMESTYLEISO LS_GROUPDIRSFIRST

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi


