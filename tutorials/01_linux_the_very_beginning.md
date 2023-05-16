# Linux

## Intro

Linux is a free and open-source operating system based on the Unix operating system. 
It was created in 1991 by Linus Torvalds and has since become one of the most widely used operating systems in the world. 

Linux is known for its stability, security, and flexibility, which makes it a popular choice for servers, embedded systems, and supercomputers. 
In recent years, Linux has gained popularity among desktop users as well, due to its ease of use and the availability of a wide range of free and open-source software applications.

Learning Linux is a very valuable skill for DevOps engineers, as it provides a deep understanding of the operation system upon which many modern applications and services are operating.
In this course we will cover two main core components of every Linux system: files and processes, as well as a lot of small topics such as io redirect, package management, environment variables and useful commands.

## Course resources

The below list is the resources upon which this course was built. From time to time we will attach references for further reading.

- Good Linux tutorial for beginners https://ryanstutorials.net/linuxtutorial/
- Linux comprehensive book for beginners https://tldp.org/LDP/Bash-Beginners-Guide/Bash-Beginners-Guide.pdf
- Advanced Linux and Bash scripting https://tldp.org/LDP/abs/abs-guide.pdf

## First Steps

### The command line

We'll be learning Linux using the command line (a.k.a. **Terminal**) running shell called **Bash**.
The command line interface (**cli**) may seem confusing and unfriendly for new users. Don't worry, with a bit of practice you'll soon see how useful this tool is.
A command line, or terminal, is a text based interface to the system. Type any command text in the cli, and an output will be given to you, as text.
The command line typically presents you with a **prompt**. Most of the time you will be issuing commands.

Here is an example:

```console
myuser@hostname:~$ echo Hello world
Hello world
myuser@hostname:~$ ls
file1 file2 file3 somedirectory
```

**Important!** Whenever you see a code snippet, as in the above block, you are expected to execute the command in your terminal and experiment with the results.

Usually, in order to work on a Linux system directly, you will need to login to the system by providing a username and password (don’t forget them!). Upon successful login, a standard prompt displays the user's login name, the hostname, and the current working directory.
In the above example, `myuser` will be your login name, `hostname` is the name of the machine you are working on, and `~` (tilde) is an indication of your current location in the file system.

### Shortcuts

Bash is full of helpful shortcuts. You'll be introduced to several of them throughout the course. Here is a table summarizing the most important shortcuts, try them out in your terminal!

| Key or key combination      | Function |
| ----------- | ----------- |
| Ctrl+A or Home key      | Move cursor to the beginning of the command line.       |
| Ctrl+D     | Log out of the current shell session, equal to typing the `exit` or `logout` commands       |
| Ctrl+E or End key  | Move cursor to the end of the command line.        |
| Ctrl+L   | Clear this terminal, equivalent to the `clear` command        |
| Ctrl+R      | Search command history       |
| ArrowUp and ArrowDown   | Browse history. Go to the line that you want to repeat, edit details if necessary, and press Enter to save time.        |
| Shift+PageUp and Shift+PageDown      | Browse terminal buffer       |
| Tab   | Command or filename completion        |
| Tab Tab   | Shows file or command completion possibilities.        |


### Basic commands

A lot of commands rely on the directory you are currently working on (a.k.a. **Current working directory**).
To make sure that you are in the right location, use the `pwd` (**p**rint **w**orking **d**irectory) command:

```console
myuser@hostname:~$ pwd
/home/myuser
```

`ls` will list the files and directories in the current location:

```console
myuser@hostname:~$ ls
file1 file2 file3 somedirectory
```

But `ls` has many more functionalities... use `--help` to get the usage guidelines:

```console
myuser@hostname:~$ ls --help
The general form usage is:
ls [OPTION]... [FILE]...
```

We can learn some important features of linux commands:

- A command behaves differently when you specify an option, usually preceded with a dash (`-`) for short flag or (`--`) for full flag name, as in `ls -a` or `ls --all`.
- Whenever you see `<something>`, it means you need to replace this with something useful. Replace the whole thing (including the `<` and `>`).
- Whenever you see `[something]` this usually means that this something is optional. When you run the command you may put in something or leave it out.
- The argument(s) to a command are specifications for the object(s) on which you want the command to take effect. An example is `ls /etc`, where the directory `/etc` is the argument to the ls command.


## Getting help

Here are a few ways you can seek help and get answers to your questions:

- `<command> --help` - how to run the command, what are the accepted options and arguments.
- `man <command>` - the manual is a set of pages that explain everything on the command, including what it does. In the man page, type `/` to search specific words.
- [StackOverflow](https://stackoverflow.com/)
- [ChatGPT](https://chat.openai.com/)

# Self check questions

TBD