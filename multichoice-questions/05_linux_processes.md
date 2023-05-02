# Linux - Processes - multichoice questions


## Question 1

A user started a process and logged out from the terminal. Which command he used if the process still running in the background:

- [ ] `nokill`
- [ ] `nohup`
- [ ] `nofg`
- [ ] `bg`

## Question 2

Which of the following is a true statement?

- [ ] Only the root user may run processes from a shell.
- [ ] The shell is a process that is commonly used to execute other processes.
- [ ] The shell is the kernel component that interacts directly with hardware.
- [ ] Only one instance of a shell may be running as a process.


## Question 3

Which of the following is not true for the Linux operating system?

- [ ] Multiple processes appear to be running at the same time.
- [ ] Only one instance of any given program may be running as a process.
- [ ] Programs are stored as files in the filesystem.
- [ ] Only one instance of the kernel may be running at any given time.


## Question 4

Open a new terminal session and type the command `python`. Then send a SIGINT signal using your keyboard. What best describes how the python process responds to the SIGINT signal? (you can exit this process by typing `exit()` in the python console)

- [ ] The program ignores the SIGINT signal.
- [ ] The program has implemented a custom signal handler for the SIGINT signal.
- [ ] The program behaves as the kernel's default signal handler for the SIGINT signal, which is to terminate the process.
- [ ] The program behaves as the kernel's default signal handler for the SIGINT signal, which is to stop (suspend) the process.
- [ ] None of the above

## Question 5

Given the bellow terminal output:

```console
myuser@localhost:~$ sleep 600 &
myuser@localhost:~$ sleep 600 &
myuser@localhost:~$ sleep 600 &
```

Which command could be used to know how many processes are running in the background terminal session?

- [ ] `process`
- [ ] `jobs`
- [ ] `work`
- [ ] `list`

## Question 6

Given a terminal session with a long process running in it, how will you **ask** this process to terminate?

- [ ] CTRL+z
- [ ] CTRL+c
- [ ] CTRL+l
- [ ] CTRL+c twice

## Question 7

Given a terminal session with a long process running in it, how will you **ask** this process to stop?

- [ ] CTRL+z
- [ ] CTRL+c
- [ ] CTRL+l
- [ ] CTRL+c twice

## Question 8

How would you run the `sleep 10` command as a foreground process?

- [ ] `fg sleep 10`
- [ ] `sleep 10 &`
- [ ] `foreground sleep 10`
- [ ] `sleep 10`

Given the following output:

```console
[maxwell@station maxwell]$ ps -U maxwell
PID  TTY	TIME 	CMD
4785 ?  	00:00:00 gnome-session
4828 ?  	00:00:00 ssh-agent
...
4846 ?  	00:00:00 xscreensaver
5410 pts/8  00:00:00 bash
5451 ?  	00:00:00 same-gnome
5452 ?  	00:00:00 same-gnome
5454 ?  	00:00:01 gimp
5455 ?  	00:00:00 script-fu
5463 pts/8  00:00:00 ps
5907 pts/7  00:00:00 bash
5942 pts/7  00:00:00 find
```

Answer the next 3 questions below.

## Question 9

Which of the following commands would deliver a SIGTERM to the `xscreensaver` process?

- [ ] `kill TERM xscreensaver`
- [ ] `kill 4846`
- [ ] `kill xscreensaver`
- [ ] `kill -9 4846`
- [ ] None of the above

## Question 10

Which of the following would deliver a SIGKILL to the `xscreensaver` command?

- [ ] `kill -9 4846`
- [ ] `kill xscreensaver`
- [ ] `kill -KILL xscreensaver`
- [ ] `kill -15 4846`
- [ ] None of the above

## Question 11

Which of the following would send a SIGCHLD (signal number 17) to the `ssh-agent` process?

- [ ] `kill -CHLD ssh-agent`
- [ ] `kill -17 ssh-agent`
- [ ] `kill -CHLD 4828`
- [ ] All of the above
- [ ] A and C only

## Question 12

Which key pressed within the `top` command allows the user to send a signal to a process?

- [ ] `s`
- [ ] `z`
- [ ] `t`
- [ ] `k`
- [ ] None of the above

## Question 13

The `kill` command always terminates a process.

- [ ] True
- [ ] False

