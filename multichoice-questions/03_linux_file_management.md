# Linux - File Management - multichoice questions

## Question 1

If `/home/student` is a directory, then the command `rm /home/student` will

1. remove all files in the directory
2. delete the directory from the filesystem
3. delete the student user account
4. produce an error message

## Question 2

T/F: Only the root user can read files in `/etc`.

1. True
2. False

## Question 3

T/F: `/bin` and `/usr/bin` contain the same files.

1. True
2. False

## Question 4

The command `cp item.1 item.2` will copy an entire subdirectory tree

1. only if `item.2` is existing directory
2. only if special command options are used
3. only if `item.2` is empty
4. only if `item.1` is empty

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

1. eras
2. raged
3. rigs
4. retry
5. racks
6. wrens

## Question 6

Which of the following files would be included in the output of the command `ls r??` ?

1. eras
2. row
3. riots
4. rho
5. wet
6. run

## Question 7

Which of the following files would be included in the output of the command `ls [aeiou]???` ?

1. ebbs
2. lead
3. oft
4. whip
5. oaks
6. oust

## Question 8

Which of the following pairs of commands always produce the same effect?

1. `cd ..` and `cd -`
2. `cd /` and `cd root`
3. `cwd` and `pwd`
4. `cd ~` and `cd`

## Question 9

Your screen shows the following:

```console
[student@station html]$ cd ../bin
[student@station bin]$ pwd
/home/student/bin
[student@station bin]$ cd -
```


What would be the output of the command `pwd`?

1. `/home/student`
2. `/home/student/html`
3. `/home/html`
4. `-`

## Question 10

Why would you expect trouble from the following command?

```console
[bob@station bob]$ head /bin/ls
```


1. The user bob does not have permissions to read the file `/bin/ls`.
2. The head command must be called with the `-n` command line switch, to specify how many lines to show.
3. The file `/bin/ls` is too small for the head command
4. The file `/bin/ls` is a binary file, and the head command works primarily on text files.
5. None of the above.

## Question 11

The `/root` directory is noteworthy because

1. It is the root of the Linux filesystem
2. It is the superuser's home directory
3. It can always be abbreviated as `~`
4. Its contents cannot be read by any user.


## Question 12

Which of these is most likely not someone's home directory?

1. `/home/student`
2. `/root`
3. `/`
4. None of these - all are likely to be home directories


## Question 13

What does the `who` command report?

1. The users who have logged onto the machine since midnight.
2. The users who are currently logged onto the machine.
3. Prints the lyrics of the well known song [who let the dogs out](https://www.youtube.com/watch?v=ojULkWEUsPs).
4. The command is used to lookup users from an Internet database of all users.

