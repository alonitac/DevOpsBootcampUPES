# Networking - SSH - multichoice questions

## Question 1

In which file does SSH store a user's private RSA key, by default?

- [ ] `~/.key.private`
- [ ] `~/.ssh/rsa`
- [ ] `~/.ssh/id_rsa`
- [ ] `~/.sshrc`
- [ ] None of the above

## Question 2

When using SSH public key authentication, which file must exist on the remote machine?

- [ ] `~/.ssh/id_dsa.pub`
- [ ] `~/.ssh/known_hosts`
- [ ] `~/.ssh/authorized_keys`
- [ ] A and C
- [ ] All of the above

## Question 3

```console
[elvis@station]$ ssh ec2-user@69.57.97.126 "echo 'hi' | grep h > /tmp/greet"
```


On the remote machine, which of the following processes was not executed as a result of this
Command?

- [ ] `echo`
- [ ] `ssh`
- [ ] `grep`
- [ ] All of the above processes are executed on the remote machine.

## Question 4

```console
[elvis@station]$ ssh ec2-user@69.57.97.126 "echo 'hi' | grep h > /tmp/greet"
```

On which machine was the file /tmp/greet created?

- [ ] The local machine
- [ ] The remote machine
- [ ] Not enough information is provided.

## Question 5

```console
[elvis@statio]$ ssh ec2-user@69.57.97.126 mkdir tmp
[elvis@statio]$ scp .bashrc jules@69.57.97.126:tmp .bashrc
100% |*****************************| 	124  00:00
```

Which file on the remote machine contains a copy of the local file ~/.bashrc?

- [ ] `~/.bashrc`
- [ ] `~/tmp/.bashrc`
- [ ] `/tmp/.bashrc`
- [ ] `~/tmp`
- [ ] Not enough information is provided.

## Question 6

Which file is automatically updated whenever the first connection to a new host is accepted?

- [ ] `~/.ssh/id_dsa.pub`
- [ ] `~/.ssh/known_hosts`
- [ ] `~/.ssh/authorized_keys`
- [ ] `~/.ssh/authorized_hosts`
- [ ] None of the above

## Question 7

Which of the following command lines could be used to recursively copy the `~/backups`
directory to a remote machine's `/tmp` directory?

- [ ] `scp backups ec2-user@69.57.97.126:tmp`
- [ ] `scp -r backups ec2-user@69.57.97.126:/tmp`
- [ ] `scp -R /tmp/backups ec2-user@69.57.97.126:`
- [ ] `scp backups ec2-user@69.57.97.126:`
- [ ] None of the above

## Question 8

In order to connect to a remote machine, which of the following information must exist in the remote machine?

- [ ] The client OS version
- [ ] The client public key
- [ ] The client private key
- [ ] The client home directory path

