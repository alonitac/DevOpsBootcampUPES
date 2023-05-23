# Bash Scripting

## Motivation

Bash, or the Bourne-Again SHell, is a widely-used Unix shell and command language that provides a powerful command-line interface for interacting with the operating system.

Learning Bash can help you:
-  Make life easier on UNIX or UNIX-like system
-  Ease execution of daily tasks
-  Automate important operation task

Overall, learning Bash can help you to become a more efficient and effective system administrator, developer, or data analyst.

The UNIX shell program interprets user commands to the kernel, which are either directly entered by the user, or which can be read from a file called the **shell script**.
Apart from passing commands to the kernel, the main task of a shell is providing a **user environment**, which can be configured individually using shell resource configuration files.

The below example shows the evolution bash program. It starts simply by grouping a few commands into a file, without any error handling and flow control... until the form of a well written professional script.

### From Bash commands to Bash program

Consider the below script to clean up log files (messages, wtmp) in /var/log. Copy and execute the following snippet to a .sh file in your local Linux machine.

```bash
# Run as root, of course.
cd /var/log
cat /dev/null > messages
cat /dev/null > wtmp
echo "Log files cleaned up."
```

There is nothing unusual here, only a set of commands that could just as easily have been invoked one by one. Is this a script? maybe...Is this a program? not yet...

Let's try again...

```bash
# Proper header for a Bash script.
#!/bin/bash

# Run as root, of course.
LOG_DIR=/var/log   # Variables are better than hard-coded values.

cd $LOG_DIR
cat /dev/null > messages
cat /dev/null > wtmp
echo "Logs cleaned up."

exit # The right and proper method of "exiting" from a script.
# A bare "exit" (no parameter) returns the exit status of the preceding command.
```

Now that's beginning to look like a real script. But we can go even farther...

The following script uses quite a number of features that will be explained later on.

```bash
#!/bin/bash
LOG_DIR=/var/log
ROOT_UID=0 	# Only users with $UID 0 have root privileges.
LINES=50   	# Default number of lines saved.

E_XCD=86   	# Can't change directory?
E_NOTROOT=87   # Non-root exit error.


# Run as root, of course.
if [ "$UID" -ne "$ROOT_UID" ]
then
echo "Must be root to run this script."
exit $E_NOTROOT
fi

if [ -n "$1" ]  # Test whether command-line argument is present (non-empty).
then
lines=$1
else
lines=$LINES  # Default, if not specified on command-line.
fi

cd $LOG_DIR
if [ `pwd` != "$LOG_DIR" ] # or if [ "$PWD" != "$LOG_DIR" ]
# Not in /var/log?
then
echo "Can't change to $LOG_DIR."
exit $E_XCD
fi # Doublecheck if in right directory before messing with log file.


tail -n $lines messages > mesg.temp  # Save last section of message log file.
mv mesg.temp messages            	# Rename it as system log file.
cat /dev/null > wtmp

echo "Log files cleaned up."
exit 0
```

## Bash Scripting - Shell Types

Let's recall the 2 main shells we usually work with in Linux system:

- `sh` or Bourne Shell: the original shell still used on UNIX systems.
- `bash` or Bourne Again shell: the standard GNU shell, intuitive and flexible. Probably most advisable for beginning users while being at the same time a powerful tool for the advanced and professional user. On Linux, bash is the standard shell for common users.
  The file /etc/shells gives an overview of known shells on a Linux system:
  cat /etc/shells


## Which shell should run the script?

When running a script in a subshell, you should define which shell should run the script. The shell type in which you wrote the script might not be the default on your system, so commands you entered might result in errors when executed by the wrong shell.
The **sha-bang (#!)** at the head of a script tells your system that this file is a set of commands to be fed to the command interpreter indicated.
Note that the path given at the "sha-bang" must be correct, otherwise an error message -- usually "Command not found." -- will be the only result of running the script.
Copy and execute the following snippet to a myscript.sh file in your local Linux machine.

```bash
#!/bin/bash
ls
cd /var
```

Test the above script with /bin/sh as the sha-bang shell. Add an echo command to print some environment variable that will indicate the shell that is currently running the program.

## Running bash programs

Having written a bash script, you can invoke it in two ways:

- `./myscript.sh` - This is the method we’ve seen so far. It runs the script as an executable file, using the interpreter specified in the shebang line. If the script is not marked as executable, you will get a "Permission denied" error.
- `bash myscript.sh` - explicitly runs the script using the bash shell, regardless of the shebang line (#!/bin/bash) at the beginning of the script. This means that even if the script is not marked as executable (chmod +x myscript.sh), you can still run it.

## Exit status and `$?`

In Unix-like operating systems, every command that is executed returns an exit status to the shell that invoked it. The exit status is a numeric value that indicates the success or failure of the command. A value of 0 indicates success, while a non-zero value indicates failure.

The exit status of the most recently executed command can be accessed via the `$?` variable in Bash.

```console
[myuser@hostname]~$ ls /non-existing-dir
ls: cannot access '/non-existing-dir': No such file or directory
[myuser@hostname]~$ echo $?
2
```

In the above example, if you run a command like `ls /non-existing-dir`, you will receive an error message saying that the directory does not exist, and the exit status will be non-zero. You can access the exit status of this command by typing echo $?. The output will be the exit status of the previous command (in this case, the value is 2).

Some common non-zero exit status values include:

- 1: General catch-all error code
- 2: Misuse of shell built-ins (e.g. incorrect number of arguments)
- 126: Command found but not executable
- 127: Command not found
- 128+: Exit status of a program that was terminated due to a signal

## Command Substitution

Command substitution allows users to run arbitrary commands in a subshell and incorporate the results into the command line. The modern syntax supported by the bash shell is :

```bash
$(subcommand)
```

As an example of command substitution, `myuser` would like to create a directory that contains the date in its name. After examining the `date(1)` man page, he devises a format string to generate the date in a compact format.

```console
[prince@station prince]$ date +%d%b%Y
04May2023
```

He now runs the mkdir command, using command substitution.

```console
[prince@station prince]$ mkdir reports.$(date +%d%b%Y)
[prince@station prince]$ ls
reports.04May2003
```

The bash shell implements command substitution by spawning a new subshell, running the command, recording the output, and exiting the subshell. The text used to invoke the command substitution is then replaced with the recorded output from the command.

## Sourcing files

The `source` command allows you to "import" the content of a shell script to another file.
It is commonly used to load shell configuration files or execute scripts that define functions, variables, or aliases that should be available in the current shell session. 
For example, if you have a script named `myscript.sh` that defines some variables and aliases, you could use the `source` command to load it in the `~/.bashrc` file like this:

```bash
source ~/path/to/myscript.sh
```

Here is another simple example. Consider the below two files, `a.sh` and `b.sh`:

```bash
# file a.sh

NAME=John
```

Now we want to use the variable defined in `a.sh` within the `b.sh` file. We can achieve that using the `source` command:

```bash
# file b.sh

source a.sh

echo Hello $NAME
```

Under the hood, The `source` command runs the commands in the specified file in the **same process** that is currently running, rather than spawning a new process to execute the commands. This means that any changes made to the shell environment by the commands in the file will persist in the current shell session after the source command completes. You will often see the `.` (dot) command for file sourcing instead of `source`, both commands achieve the same.

