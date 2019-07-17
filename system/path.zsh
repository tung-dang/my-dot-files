#
# Set up PATH
#

# prependPath new items to path (if directory exists)
prependPath() {
  [ -d $1 ] && PATH="$1:${PATH}"
}

# Start with system path
# Retrieve it from getconf, otherwise it's just current $PATH
is-executable getconf && PATH=$(command -v getconf PATH)

prependPath "/bin"
prependPath "/usr/bin"
prependPath "/usr/sbin"
prependPath "/usr/local/bin"
is-executable brew && prependPath "$(brew --prefix coreutils)/libexec/gnubin"
prependPath "$ZSH_DF/bin"
prependPath "$HOME/bin" # Add `~/bin` to the `$PATH`
prependPath "~/bin" # Add `~/bin` to the `$PATH`
prependPath "/sbin"

# to make macport work well
prependPath "/opt/local/bin"
prependPath "/opt/local/sbin"

prependPath "/usr/local/lib/python2.7/site-packages"
prependPath "$HOME/.rvm/bin" # Add RVM to PATH for scripting
prependPath "/usr/local/share/npm/bin"

prependPath "$HOME/.npm-packages/bin"
export GRADLE_HOME='$HOME/dev/gradle-2.13/'
prependPath "$HOME/dev/gradle-2.13/bin"
prependPath "$HOME/dev/bin"

export PGDATA="/Users/tthanhdang/Library/Application Support/Postgres/var-9.5"
prependPath "/Applications/Postgres.app/Contents/Versions/9.5/bin"

export PYTHONPATH='/Users/tthanhdang/src/atlassian-directory/atlassian_directory/'
prependPath "$CATALINA_HOME/bin"
prependPath "/usr/local/opt/node@8/bin"

# Remove duplicates (preserving prependPathed items)
# Source: http://unix.stackexchange.com/a/40755
# PATH=`echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`

# Wrap up
export PATH
