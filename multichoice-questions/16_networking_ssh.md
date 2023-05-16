# Networking - SSH - multichoice questions

### Question 1

In which file does SSH store a user's private RSA key, by default?

1. [ ] `~/.key.private`
2. [ ] `~/.ssh/rsa`
3. [ ] `~/.ssh/id_rsa`
4. [ ] `~/.sshrc`
5. [ ] None of the above

### Question 2

When using SSH public key authentication, which file must exist on the remote machine?

1. [ ] `~/.ssh/id_dsa.pub`
2. [ ] `~/.ssh/known_hosts`
3. [ ] `~/.ssh/authorized_keys`
4. [ ] A and C
5. [ ] All of the above

### Question 3

```console
[elvis@station]$ ssh ec2-user@69.57.97.126 "echo ‘hi’ | grep h > /tmp/greet"
```


On the remote machine, which of the following processes was not executed as a result of this
Command?

1. [ ] `echo`
2. [ ] `ssh`
3. [ ] `grep`
4. [ ] All of the above processes are executed on the remote machine.

### Question 4

```console
[elvis@station]$ ssh ec2-user@69.57.97.126 "echo ‘hi’ | grep h > /tmp/greet"
```

On which machine was the file /tmp/greet created?

1. [ ] The local machine
2. [ ] The remote machine
3. [ ] Not enough information is provided.

### Question 5

```console
[elvis@statio]$ ssh ec2-user@69.57.97.126 mkdir tmp
[elvis@statio]$ scp .bashrc jules@69.57.97.126:tmp .bashrc
100% |*****************************| 	124  00:00
```

Which file on the remote machine contains a copy of the local file ~/.bashrc?

1. [ ] `~/.bashrc`
2. [ ] `~/tmp/.bashrc`
3. [ ] `/tmp/.bashrc`
4. [ ] `~/tmp`
5. [ ] Not enough information is provided.

### Question 6

Which file is automatically updated whenever the first connection to a new host is accepted?

1. [ ] `~/.ssh/id_dsa.pub`
2. [ ] `~/.ssh/known_hosts`
3. [ ] `~/.ssh/authorized_keys`
4. [ ] `~/.ssh/authorized_hosts`
5. [ ] None of the above

### Question 7

Which of the following command lines could be used to recursively copy the `~/backups`
directory to a remote machine's `/tmp` directory?

1. [ ] `scp backups ec2-user@69.57.97.126:tmp`
2. [ ] `scp -r backups ec2-user@69.57.97.126:/tmp`
3. [ ] `scp -R /tmp/backups ec2-user@69.57.97.126:`
4. [ ] `scp backups ec2-user@69.57.97.126:`
5. [ ] None of the above

### Question 8

In order to connect to a remote machine, which of the following information must exist in the remote machine?

1. [ ] The client OS version
2. [ ] The client public key
3. [ ] The client private key
4. [ ] The client home directory path
