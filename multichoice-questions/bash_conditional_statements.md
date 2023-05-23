# Bash - conditional variables - multichoice questions

## Question 1

What happens if you use the `set -e` in a Bash script?

- [ ] It will cause Bash to exit if a function or subshell returns a nonzero status code.
- [ ] It will cause Bash to exit if a conditional returns a non-zero status code.
- [ ] It will cause Bash to exit if local, declare, or typeset assignments return a nonzero status code.
- [ ] It will cause Bash to exit if a command, list of commands, compound command, or potentially a pipeline returns a nonzero status code.

## Question 2

What is the result of this script?
```bash
txt=Penguins
[ "${txt:2:4}" = "ngui" ]; echo $?
```

- [ ] 0, representing 'true', because the substring of txt in the above indices is  "ngui"
- [ ] 0, representing 'true', because everybody loves penguins!
- [ ] 1, representing 'false', because the variable "txt" is not between 2 to 4 character length
- [ ] 1, representing 'false', because the variable "txt" does not contain "ngui"

## Question 3

What is the result of this script?

```bash
txt=Penguins
[[ $txt =~ [a-z]{8} ]]; echo $?
```

- [ ] 0, representing 'true', because the variable "txt" contains eight letters
- [ ] 0, representing 'true', because everybody loves penguins!
- [ ] 1, representing 'false', because the variable "txt" is longer than eight characters
- [ ] 1, representing 'false', because the variable "txt" does not contain eight lowercase letters between a and z

## Question 4

What is wrong with this script?

```bash
#!/bin/bash
if [ $PET = dog ] ;then
  echo "You have a dog"
fi
```

- [ ] If the value of `PET` doesn't match dog, the script will return a nonzero status code.
- [ ] There is nothing wrong with it. The condition checks the value of `PET` perfectly.
- [ ] It will fail if the `PET` variable is empty or undefined.
- [ ] The then statement needs to be on a separate line.

## Question 5

Which command is being run in this script to check if file.txt exists?

```bash
if [ -f file.txt ]; then
    echo "file.txt exists"
fi
```
 
- [ ] `/usr/bin/test`
- [ ] `/usr/bin/[`
- [ ] the built-in `[]` command
- [ ] `/usr/bin/[[`

## Question 6

The code below seems to work and outputs "8 is greater than 5". However, what unexpected result will tell you it is not functioning properly?

```bash
#!/bin/bash
var="8"
if [ $var > 5 ]; then
echo "$var is greater than 5"
fi
```

- [ ] There will be no unexpected results. This script works as is and the output will be "8 is greater than 5".
- [ ] The comparison will not be able to handle floating-point numbers, as Bash only handles integers. So this example will output an error message if the value of $var is changed to "8.8".
- [ ] There will be a file in the current directory named 5.
- [ ] The variable `$var` is not quoted, which will lead to word splitting. This script will fail with a "unary operator expected" message.
