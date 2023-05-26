# Docker - Volumes - multichoice questions

## Question 1 

What is wrong in the following command: 

```bash
docker run -it -v ../../etc/resolv.conf:/etc/resolv.conf busybox /bin/sh
```

- [ ] There is no such image `busybox`.
- [ ] The file `/etc/resolv.conf` doesn't exist in the container.
- [ ] Relative path is not allowed in the first part of `-v` value. 
- [ ] The flag `--name` is missing. 

## Question 2

If you use `-v` to bind-mount a file or directory that does not yet exist on the host machine. 

- [ ] `-v` creates the endpoint for you. It is always creates as a directory.
- [ ] `-v` doesn't create the endpoint for you.
- [ ] `-v` creates either the file or directory endpoint for you.
- [ ] The docker daemon exits with an Error: `Path not found`.

## Question 3

Given the below container running command:

```bash
docker run -v /home/elvis/data:/data mysql
```

- [ ] `/home/elvis/data` is a path in the host machine.
- [ ] `/home/elvis/data` is a path in the container.
- [ ] `/data` is a path in the container.
- [ ] `/data` is a path in the host machine.

## Question 4

Given the below running container command executed by `elvis`:

```bash
[elvis@hostname]$ docker run -it -v /test_data:/test_data busybox /bin/sh
```

Assume the command `touch /test_data/hi` was successfully executed from within the container. 
When running `ls -l /test_data` **from the host machine**, who are the user and group owners of the created `hi` file?

- [ ] `elvis`
- [ ] `dockerd`
- [ ] `root`
- [ ] Since this file was created from within a container in the host machine fs, there is no user and group owning the file. 
- [ ] None of the above.


## Question 5

You want to mount the path `/etc/resolv.conf` from your host machine into the container file system. 
So the container will share the content of `/etc/resolv.conf` as it's defined in the host machine. 

Which method will work?

- [ ] Using bind-mount.
- [ ] Using volumes.
- [ ] Both volumes and bind-mount will work.
- [ ] `tmpfs` mounts

