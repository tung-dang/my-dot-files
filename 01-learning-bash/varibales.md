# Environment variables.

- BASH	Holds the full path of the command interpreter for Bash scripts
- BASH_VERSION	Holds the bash release version of the machine currently used
- HOME	Holds the relative path of the home directory.
- LOGNAME	Holds the account name of the current user logged-in
- OSTYPE	Holds a string that describes the current OS of the machine used
- PATH	Holds a colon-separated absolute path of the executable files in Linux
- PWD	Holds the current working directory of the shell
- SHELL	Holds the preferred command line shell
- USER	Works similar to LOGNAME. It holds the account name of the user currently logged-in
- _	Holds the name of the recently used command in the shell


- `$0` - The name of the Bash script.
- `$1 - $9` - The first 9 arguments to the Bash script. (As mentioned above.)
- `$#` - How many arguments were passed to the Bash script.
- `$@` - All the arguments supplied to the Bash script.
- `$*` - ??
- `$?` - The exit status of the most recently run process.
- `$$` - The process ID of the current script.
- `$USER` - The username of the user running the script.
- `$HOSTNAME` - The hostname of the machine the script is running on.
- `$SECONDS` - The number of seconds since the script was started.
- `$RANDOM` - Returns a different random number each time is it referred to.
- `$LINENO` - Returns the current line number in the Bash script.

=================================================================

Bash accomodates piping and redirection by way of special files. Each process gets it's own set of files (one for STDIN, STDOUT and STDERR respectively) and they are linked when piping or redirection is invoked. Each process gets the following files:

- STDIN - /proc/<processID>/fd/0
- STDOUT - /proc/<processID>/fd/1
- STDERR - /proc/<processID>/fd/2

To make life more convenient the system creates some shortcuts for us:

- STDIN - /dev/stdin or /proc/self/fd/0
- STDOUT - /dev/stdout or /proc/self/fd/1
- STDERR - /dev/stderr or /proc/self/fd/2
fd in the paths above stands for file descriptor.
