# Linux - Environment variables - multichoice questions

## Question 1

When a user runs the command `who` from the command line, which of the following best describes what happens?

- [ ] The shell asks the kernel to execute the contents of the file `/usr/bin/who` as a separate process, displaying the process's output on the terminal.
- [ ] The shell makes the `who` system call, prompting the Linux kernel for the output directly.
- [ ] The shell exits, and is replaced by the `who` process. When the `who` process terminates, it replaces itself with a new shell process.
- [ ] None of the above.

## Question 2

Which of the following could not be used as the name of an environment variable?

- [ ] `NAME`
- [ ] `PHONE_1`
- [ ] `Addr2`
- [ ] `ZipCode`
- [ ] All of the above could be used as the name of an environment variable.

## Question 3

Which of the following would correctly set the environment variable `ADDR` to “123 Elm St.”?

- [ ] `ADDR= 123_Elm_St.`
- [ ] `export ADDR=123 Elm St.`
- [ ] `export ADDR="123 Elm St."`
- [ ] `export ADDR=123_Elm_St.`
- [ ] None of the above.

## Question 4

Which of the following is not a feature of environment variables?

- [ ] All processes use environment variables, not just those running the bash shell.
- [ ] Environment variables are inherited by child processes by default.
- [ ] Upon startup, the bash shell clears all previously defined environment variables.
- [ ] Environment variables can be examined using files found in the `/proc` filesystem.

## Question 5

Which of the following commands would append the directory `/opt/bin` to the current value
of the `PATH` environment variable?

- [ ] `PATH=$PATH:/opt/bin`
- [ ] `PATH+=/opt/bin`
- [ ] `PATH=${PATH}+"/opt/bin"`
- [ ] A and B
- [ ] All of the above

## Question 6

The user elvis performs the following command.

```contole
[elvis@station elvis]$ export STYLE=terse
```

Which of the following commands would delete the environment variable STYLE?

- [ ] `set`
- [ ] `env STYLE`
- [ ] `rm /proc/$$/environ`
- [ ] `import STYLE`
- [ ] `unset STYLE`
- [ ] None of the above

