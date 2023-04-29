# Linux - The very beginning - multichoice questions

The `ls` command is used to list directory contents. Use the `ls --help` command and the below sample invocations to answer the next 4 questions.

```console
myuser@localhost:~$ touch --help
Usage: touch [OPTION]... FILE...
...
myuser@localhost:~$ ls /etc
debian_version   	host.conf       	lsb-release
…
myuser@localhost:~$ lss /etc
-bash: lss: command not found
myuser@localhost:~$ ls -z /etc
ls: invalid option -- 'z'
Try 'ls --help' for more information.
```

## Question 1

Which best describes why `myuser` got the "command not found" error message when running
`lss /etc`?

1. The directory `/etc` does not exist.
2. myuser misspelled the command name, and no command named `lss` could be found.
3. The `ls` command requires a mandatory `-a` flag.
4. `myuser` does not have the right permissions to execute the command.

## Question 2

Which best describes why `myuser` got the "invalid option" error message when running touch
`ls -z /etc`?

1. The directory `/etc` does not exist.
2. `myuser` misspelled the command name, and no command named `lss` could be found.
3. The `ls` command requires a mandatory `-a` flag.
4. The `ls` command doesn't support the `-z` flag.

## Question 3

When `myuser` ran the command `ls /etc`, what best describes the role of
the word `/etc`?

1. The word serves as an argument to the `ls` command.
2. The word serves as a parameter to the `-r` flag.
3. The word serves as the name of the command to run.
4. The word is misplaced, and caused the command to exit in failure.

## Question 4

Which of the following would be a legitimate invocation of the `ls` command?

1. `ls /etc -a`
2. `ls --nolist /etc`
3. `ls -l/etc`
4. `ls -l /etc`

## Question 5

Which control sequence causes bash to clear the screen?

1. CTRL+C
2. CTRL+D
3. CTRL+L
4. CTRL+S
5. CTRL+U

## Question 6

Which command will list the contents of the directory `report` recursively?

1. `lsdir report`
2. `ls --recur report`
3. `ls -r report`
4. `ls -R report`
5. `ls report \r`


## Question 7

Which of the following is an absolute directory reference?

1. `/home/student`
2. `../etc`
3. `..`
4. `home/myuser`

## Question 8

Which of the following is a relative directory reference?

1. `/home/student`
2. `/etc`
3. `..`
4. `~`

## Question 9

Which of the following could have been displayed by `pwd`?

1. `home/student`
2. `/etc`
3. `..`
4. `~`

## Question 10

Following the command `cd ~`, which is the most likely result from `pwd`?

1. `/home/myuser`
2. `/etc`
3. `..`
4. `~`

## Question 11

The file `named.conf` is a system configuration file. This file belongs in

1. `/tmp`
2. `/etc`
3. `/bin`
4. `/home/myuser`

## Question 12

The file `e2fsck` is a privileged command that must always be available to the system and being used by the system admin. This file would be found in

1. `/tmp`
2. `/etc`
3. `/var/lib`
4. `/sbin`

## Question 13

Which of the following commands could not be used to create a file in `/tmp`?

1. `touch /newfile`
2. `touch /tmp/newfile`
3. `touch ../newfile`
4. `touch ../tmp/newfile`

## Question 14

Use the `file` command to help answer the question.

What type of file is `/dev/log`?

1. A character special file
2. A block special file
3. A socket
4. A symbolic link
5. A compiled ELF object

## Question 15

Which of the following commands would display the first 5 lines of the file `/etc/passwd`?

1. `head -5 /etc/passwd`
2. `head -n /etc/passwd`
3. `head --five /etc/passwd`
4. `head /etc/passwd > 5`
5. `head /5 /etc/passwd`


## Question 16

What type of file is `/usr/bin/md5sum`?

1. A compiled ELF object
2. An Awk script
3. A Bash (Bourne-Again) shell script
4. A Symbolic Link
5. A `/usr/bin/perl` script


## Question 17

Given the path `/home/username/secret.txt`, choose the correct sentence:

1. `secret.txt` is a file
2. `secret.txt` is a directory
3. `secret.txt` can be either file or a directory
