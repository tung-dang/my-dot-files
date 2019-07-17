See more in: http://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php

- Because [ ] is just a reference to the command test we may experiment and trouble shoot with test on the command line to make sure our understanding of its behaviour is correct.
- - The variable $? holds the exit status of the previously run command (in this case test). 0 means TRUE (or success). 1 = FALSE (or failure).
-  If we would like to check an expression then we may use the double brackets just like we did for variables.

--------------------------------------------------------------------------
# String-based Condition

- `! EXPRESSION` -	The EXPRESSION is false.
- `-n STRING`: The length of STRING is greater than zero.
- `-z STRING`	The lengh of STRING is zero (ie it is empty).
- `STRING1 = STRING2`	STRING1 is equal to STRING2
- `STRING1 != STRING2`	STRING1 is not equal to STRING2
- `INTEGER1 -eq INTEGER2`	INTEGER1 is numerically equal to INTEGER2
- `INTEGER1 -gt INTEGER2`	INTEGER1 is numerically greater than INTEGER2
- `INTEGER1 -lt INTEGER2`	INTEGER1 is numerically less than INTEGER2

```bash
read -p "Enter an integer: " int1
if (( $int1 == 0 ))
then
    echo "Zero"
elif (( $int1 < 0 ))
then
    echo "Negative"
else
    if (( $((int1%2)) == 0 ))
    then
        echo "Even"
    else
        echo "Odd"
    fi
fi

[[ $USER = 'test' ]] && echo 'yes' || echo 'no';

```
--------------------------------------------------------------------------
# File based condition

-a file	Returns true if file exists
-b file	Returns true if file exists and is a block special file
-c file	Returns true if file exists and is a character special file
-d FILE	FILE exists and is a directory.
-e FILE	FILE exists.
-r FILE	FILE exists and the read permission is granted.
-s FILE	FILE exists and it's size is greater than zero (ie. it is not empty).
-w FILE	FILE exists and the write permission is granted.
-x FILE	FILE exists and the execute permission is granted.
-N file	Returns true if the file exists and has been modified since it was last read


```
if [ -r $1 ] && [ -s $1 ]
then
    echo This file is useful.
fi
```

```
if [ $1 -ge 18 ]
then
    echo You may go to the party.
elif [ $2 == 'yes' ]
then
    echo You may go to the party but be back before midnight.
else
    echo You may not go to the party.
fi
```

- Testing String

```sh
# Do this:
if [[ "${my_var}" = "some_string" ]]; then
  do_something
fi

# -z (string length is zero) and -n (string length is not zero) are
# preferred over testing for an empty string
if [[ -z "${my_var}" ]]; then
  do_something
fi

# This is OK (ensure quotes on the empty side), but not preferred:
if [[ "${my_var}" = "" ]]; then
  do_something
fi

# Not this:
if [[ "${my_var}X" = "some_stringX" ]]; then
  do_something
fi
```
