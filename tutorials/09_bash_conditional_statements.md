# Conditional Statements

## The if-else statement

Sometimes you need to specify different courses of action to be taken in a shell script, depending on the success or failure of a command. The if construction allows you to specify such conditions.
The most common syntax of the if command is:

```text
if TEST-COMMAND
then
POSITIVE-CONSEQUENT-COMMANDS
else
NEGATIVE-CONSEQUENT-COMMANDS
fi
```

If the TEST-COMMAND is successful (**returns an exit status of 0**), then the positive consequent commands are executed, otherwise, the negative consequent commands (if provided) are executed.
The `if` statement is terminated with the `fi` command.

### Testing files

Before you start, review the man page of the `test` command

The first example checks for the existence of a file:

```bash
echo "This script checks the existence of the messages file."
echo "Checking..."
if [ -f /var/log/messages ]
then
echo "/var/log/messages exists."
fi
echo
echo "...done."
```

### Testing exit status

Recall that the `$?` variable holds the exit status of the previously executed command. The following example utilize this variable to take a decision according to the success or failure of the previous command:
curl google.com &> /dev/null

```bash
if [ $? -eq 0 ]
then
echo "Request succeeded"
else
echo "Request failed, trying again..."
fi
```

### Numeric comparisons

The below example demonstrates numeric comparison between a variable and 20. Don’t worry is it doesn’t work, you’ll fix it soon 🙂

```bash
num=$(wc -l /etc/passwd)
echo $num

if [ "$num" -gt "20" ]; then
echo "Too many users in the system."
fi
```

### String comparisons

```bash
if [[ "$(whoami)" != 'root' ]]; then
echo "You have no permission to run $0 as non-root user."
exit 1;
fi
```

### if-grep construct

```bash
echo "Bash is ok" > file

if grep -q Bash file
then
echo "File contains at least one occurrence of Bash."
fi
```

Another example:

```bash
word=Linux
letter_sequence=inu

if echo "$word" | grep -q "$letter_sequence"
# The "-q" option to grep suppresses output.
then
echo "$letter_sequence found in $word"
else
echo "$letter_sequence not found in $word"
fi
```

### `[...]` vs `[[...]]`

With version 2.02, Bash introduced the `[[ ... ]]` extended test command, which performs comparisons in a manner more familiar to programmers from other languages. The `[[...]]` construct is the more versatile Bash version of `[...]`. Using the `[[...]]` test construct, rather than `[...]` can prevent many logic errors in scripts.

