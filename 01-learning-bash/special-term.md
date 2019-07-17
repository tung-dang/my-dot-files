- `> /dev/null`: redirects the command standard output to the null device, which is a special device which discards the information written to it

- `2 >&1` redirects the standard error stream to the standard output stream (stderr = 2, stdout = 1).
  + this is used to render both out and error to the same place, e.g. `ls > out.txt 2 >&1`

- `1 >&2` redirects the standard output stream to error stream (stderr = 2, stdout = 1). Example:

- `#!/usr/bin/env node` node shebang

```
# print the message to standard error
echo "standard error" 1 >&2
```


In practice it prevents any output from the command (both stdout and stderr) from being displayed. It's used when you don't care about the command output.
