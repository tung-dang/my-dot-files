

- repalce text
```bash

# not change content file, just print in console
sed 's/text_to_be_replaced/replacement_text/' file_name

# and change content file 
sed -i 's/text_to_be_replaced/replacement_text/' file_name

# with replace all occurance
sed 's/text_to_be_replaced/replacement_text/g' file_name

# or with different delimiter
sed 's:text_to_be_replaced:replacement_text:g' file_name
sed 's|text_to_be_replaced|replacement_text|g' file_name

# to replace the word following: with below - , we can do this:
sed 's:following\::below - :' file_name
```

- delete line

```
# delete 10 lines
sed '10d' file_name

# This will delete all the blank lines in the file. The regular expression ^$ marks an empty line and the d option specifies that the line should be deleted.
sed '/^$/d' file_name

# This command will delete all the lines starting from `mth` upto `nth`.
sed 'm,nd' file_name
```

- use ""

```
# This will replace evaluate the value of $greet and and replace hello with hi.
greet=hello

echo hello shamil | sed "s/$greet/hi" file_name
```

- This will delete all lines from 12 to 30, but most importantly it will create a file_name.bak in the same directory before modifying the actual file.

```
sed -i.bak '12,30d' file_name
```
