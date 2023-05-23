# Linux - File Management - multichoice questions

## Question 1

If `/home/student` is a directory, then the command `rm /home/student` will

- [ ] remove all files in the directory
- [ ] delete the directory from the filesystem
- [ ] delete the student user account
- [ ] produce an error message

## Question 2

T/F: Only the root user can read files in `/etc`.

- [ ] True
- [ ] False

## Question 3

T/F: `/bin` and `/usr/bin` contain the same files.

- [ ] True
- [ ] False

## Question 4

The command `cp item.1 item.2` will copy an entire subdirectory tree

- [ ] only if `item.2` is existing directory
- [ ] only if special command options are used
- [ ] only if `item.2` is empty
- [ ] only if `item.1` is empty

Answer the following 3 questions based on the below output:

```console
myuser@localhost:~$ ls
ebbs   eras   lakes  lit	loop   olden  rank   renew  robe   run	whirr
echo   erect  lamed  lives  lorry  one	rapid  reply  robed  wagon  whorl
elope  ergo   lash   loads  lost   ounce  rasp   retry  rock   wares  wile
enact  erupt  lead   loath  loves  oust   rays   rho	rocky  ways   windy
end	evens  leaks  lobby  lows   ovary  razor  rigid  rooms  weak   witty
enjoy  evoke  leaps  locus  loyal  overt  read   rigs   roses  weep   wools
entry  ewes   learn  logic  lucks  racks  reaps  rime   rouge  wench  wound
envoy  lace   leech  login  oaks   radon  recta  riots  rove   west   wrens
epic   laced  lick   loin   obese  raged  recur  risks  row	wet	writ
```

## Question 5

Which of the following files would be included in the output of the command `ls r*s` ?

- [ ] eras
- [ ] raged
- [ ] rigs
- [ ] retry
- [ ] racks
- [ ] wrens

## Question 6

Which of the following files would be included in the output of the command `ls r??` ?

- [ ] eras
- [ ] row
- [ ] riots
- [ ] rho
- [ ] wet
- [ ] run

## Question 7

Which of the following files would be included in the output of the command `ls [aeiou]???` ?

- [ ] ebbs
- [ ] lead
- [ ] oft
- [ ] whip
- [ ] oaks
- [ ] oust

## Question 8

Which of the following pairs of commands always produce the same effect?

- [ ] `cd ..` and `cd -`
- [ ] `cd /` and `cd root`
- [ ] `cwd` and `pwd`
- [ ] `cd ~` and `cd`

## Question 9

Your screen shows the following:

```console
[student@station html]$ cd ../bin
[student@station bin]$ pwd
/home/student/bin
[student@station bin]$ cd -
```


What would be the output of the command `pwd`?

- [ ] `/home/student`
- [ ] `/home/student/html`
- [ ] `/home/html`
- [ ] `-`

## Question 10

Why would you expect trouble from the following command?

```console
[bob@station bob]$ head /bin/ls
```


- [ ] The user bob does not have permissions to read the file `/bin/ls`.
- [ ] The head command must be called with the `-n` command line switch, to specify how many lines to show.
- [ ] The file `/bin/ls` is too small for the head command
- [ ] The file `/bin/ls` is a binary file, and the head command works primarily on text files.
- [ ] None of the above.

## Question 11

The `/root` directory is noteworthy because

- [ ] It is the root of the Linux filesystem
- [ ] It is the superuser's home directory
- [ ] It can always be abbreviated as `~`
- [ ] Its contents cannot be read by any user.


## Question 12

Which of these is most likely not someone's home directory?

- [ ] `/home/student`
- [ ] `/root`
- [ ] `/`
- [ ] None of these - all are likely to be home directories


## Question 13

What does the `who` command report?

- [ ] The users who have logged onto the machine since midnight.
- [ ] The users who are currently logged onto the machine.
- [ ] Prints the lyrics of the well known song [who let the dogs out](https://www.youtube.com/watch?v=ojULkWEUsPs).
- [ ] The command is used to lookup users from an Internet database of all users.

