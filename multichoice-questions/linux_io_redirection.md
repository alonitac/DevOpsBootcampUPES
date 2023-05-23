# Linux - IO redirection - multichoice questions


## Question 1

To allow the search pattern `HELLO` to match both `hello` and `HELLO`, you would use the `grep`
command with which command line switch?

- [ ] `-i`
- [ ] `-r`
- [ ] `-w`
- [ ] `-k`
- [ ] None of the above

## Question 2

Which of the following command lines would list all lines from `/usr/share/dict/words`
which contain the text sun, preceded by their line number?

- [ ] `grep -n sun /usr/share/dict/words`
- [ ] `grep -N /usr/share/dict/words sun`
- [ ] `grep -r /usr/share/dict/words sun`
- [ ] `grep -r sun /usr/share/dict/words`
- [ ] None of the above

## Question 3

Which of the following command lines would list every line which contains the text `cdrom` from
the file `README`, along with two lines of context before and after the matching line?

- [ ] `grep cdrom README | head -2 | tail -2`
- [ ] `grep -n2 cdrom README`
- [ ] `grep -n2 README cdrom`
- [ ] `grep -k2 cdrom README`
- [ ] None of the above

## Question 4

Which of the following command lines would list the names of files (and only the names of files)
found underneath the `/etc` directory which contain the word `network` (i.e., the word networking
would not count).

- [ ] `grep -rwl network /etc`
- [ ] `grep -wl network /etc`
- [ ] `grep -rl network /etc`
- [ ] `grep -ilw network /etc`
- [ ] None of the above

## Question 5

The command `echo file.1 file.2` will

- [ ] copy `file.1` to `file.2`
- [ ] display the contents of `file.1` and `file.2` on STDOUT
- [ ] produce an error message because there is no redirection symbol
- [ ] display "file.1 file.2" on STDOUT

## Question 6

For the user `elvis`, with `/home/elvis` for a home directory, which of the following commands
would succeed on a default Ubuntu Linux installation?

- [ ] `ls /etc > /etc/lsetc.txt`
- [ ] `/etc/lsetc.txt < ls /etc`
- [ ] `ls /etc > /home/elvis/lsetc.txt`
- [ ] `/home/elvis/lsetc.txt < ls /etc`

## Question 7

Which of the following commands would successfully redirect the output of the `cal` command to the file lsout.txt?

- [ ] `lsout.txt > cal`
- [ ] `cal ==> lsout.txt`
- [ ] `cal > lsout.txt`
- [ ] `cal } lsout.txt`

## Question 8

Given the file `logs.txt`. Which of the following commands may increase the size of the file (its total bytes)

- [ ] `cat logs.txt`
- [ ] `echo "hiiiiiiiiiiiiiiiiiiii" > logs.txt`
- [ ] `rm logs.txt`
- [ ] None of the above

## Question 9

Given the file `logs.txt`. Which of the following commands will necessarily increase the size of the file (its total bytes)

- [ ] `cat logs.txt`
- [ ] `echo "hiiiiiiiiiiiiiiiiiiii" > logs.txt`
- [ ] `rm logs.txt`
- [ ] None of the above

## Question 10

Which of the following command lines would list lines from the file `/etc/group` which contain the text `elvis`?

- [ ] `grep /etc/group elvis`
- [ ] `echo elvis | grep /etc/group`
- [ ] `echo /etc/group | grep elvis`
- [ ] A and C
- [ ] None of the above

## Question 11

Which of the following command lines would return the number of lines which contain the text
`freedom` found in the file `/usr/share/doc/redhat-release-5Server/GPL`?

- [ ] `grep freedom /usr/share/doc/redhat-release-5Server/GPL | wc -w`
- [ ] `grep freedom /usr/share/doc/redhat-release-5Server/GPL | wc -l`
- [ ] `grep freedom /usr/share/doc/redhat-release-5Server/GPL | wc -c`
- [ ] `grep freedom /usr/share/doc/redhat-release-5Server/GPL | wc -n`
- [ ] None of the above

## Question 12

To copy `file1.txt` to `file2.txt`, you could use

- [ ] `cp file1.txt > file2.txt`
- [ ] `cat file1.txt > file2.txt`
- [ ] `dupe file1.txt file2.txt`
- [ ] `mv file1.txt file2.txt`

## Question 13

What will be in out.txt?

```bash
ls nonexistentfile | grep "No such file" > out.txt
```

- [ ] No such file
- [ ] ls: cannot access nonexistentfile: No such file or directory
- [ ] Nothing, out.txt will be empty.
- [ ] It will be the contents of nonexistentfile.
