# Linux - Intro- multichoice questions

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

- [ ] The directory `/etc` does not exist.
- [ ] myuser misspelled the command name, and no command named `lss` could be found.
- [ ] The `ls` command requires a mandatory `-a` flag.
- [ ] `myuser` does not have the right permissions to execute the command.

## Question 2

Which best describes why `myuser` got the "invalid option" error message when running touch
`ls -z /etc`?

- [ ] The directory `/etc` does not exist.
- [ ] `myuser` misspelled the command name, and no command named `lss` could be found.
- [ ] The `ls` command requires a mandatory `-a` flag.
- [ ] The `ls` command doesn't support the `-z` flag.

## Question 3

When `myuser` ran the command `ls /etc`, what best describes the role of
the word `/etc`?

- [ ] The word serves as an argument to the `ls` command.
- [ ] The word serves as a parameter to the `-r` flag.
- [ ] The word serves as the name of the command to run.
- [ ] The word is misplaced, and caused the command to exit in failure.

## Question 4

Which of the following would be a legitimate invocation of the `ls` command?

- [ ] `ls /etc -a`
- [ ] `ls --nolist /etc`
- [ ] `ls -l/etc`
- [ ] `ls -l /etc`

## Question 5

Which control sequence causes bash to clear the screen?

- [ ] CTRL+C
- [ ] CTRL+D
- [ ] CTRL+L
- [ ] CTRL+S
- [ ] CTRL+U

## Question 6

Which command will list the contents of the directory `report` recursively?

- [ ] `lsdir report`
- [ ] `ls --recur report`
- [ ] `ls -r report`
- [ ] `ls -R report`
- [ ] `ls report \r`


## Question 7

Which of the following is an absolute directory reference?

- [ ] `/home/student`
- [ ] `../etc`
- [ ] `..`
- [ ] `home/myuser`

## Question 8

Which of the following is a relative directory reference?

- [ ] `/home/student`
- [ ] `/etc`
- [ ] `..`
- [ ] `~`

## Question 9

Which of the following could have been displayed by `pwd`?

- [ ] `home/student`
- [ ] `/etc`
- [ ] `..`
- [ ] `~`

## Question 10

Following the command `cd ~`, which is the most likely result from `pwd`?

- [ ] `/home/myuser`
- [ ] `/etc`
- [ ] `..`
- [ ] `~`

## Question 11

The file `named.conf` is a system configuration file. This file belongs in

- [ ] `/tmp`
- [ ] `/etc`
- [ ] `/bin`
- [ ] `/home/myuser`

## Question 12

The file `e2fsck` is a privileged command that must always be available to the system and being used by the system admin. This file would be found in

- [ ] `/tmp`
- [ ] `/etc`
- [ ] `/var/lib`
- [ ] `/sbin`

## Question 13

Which of the following commands could not be used to create a file in `/tmp`?

- [ ] `touch /newfile`
- [ ] `touch /tmp/newfile`
- [ ] `touch ../newfile`
- [ ] `touch ../tmp/newfile`

## Question 14

Use the `file` command to help answer the question.

What type of file is `/dev/log`?

- [ ] A character special file
- [ ] A block special file
- [ ] A socket
- [ ] A symbolic link
- [ ] A compiled ELF object

## Question 15

Which of the following commands would display the first 5 lines of the file `/etc/passwd`?

- [ ] `head -5 /etc/passwd`
- [ ] `head -n /etc/passwd`
- [ ] `head --five /etc/passwd`
- [ ] `head /etc/passwd > 5`
- [ ] `head /5 /etc/passwd`


## Question 16

What type of file is `/usr/bin/md5sum`?

- [ ] A compiled ELF object
- [ ] An Awk script
- [ ] A Bash (Bourne-Again) shell script
- [ ] A Symbolic Link
- [ ] A `/usr/bin/perl` script


## Question 17

Given the path `/home/username/secret.txt`, choose the correct sentence:

- [ ] `secret.txt` is a file
- [ ] `secret.txt` is a directory
- [ ] `secret.txt` can be either file or a directory

