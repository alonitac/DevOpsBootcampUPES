# Docker - volumes - multichoice questions


### Question 

What is wrong in the following command: 

```bash
docker run -it -v ../../etc/resolv.conf:/etc/resolv.conf busybox /bin/sh
```

1. There is no such image `busybox`.
2. The file `/etc/resolv.conf` doesn't exist in the container.
3. Relative path is not allowed in the first part of `-v` value. 
4. The flag `--name` is missing. 

### Question 

If you use `-v` to bind-mount a file or directory that does not yet exist on the host machine. 

1. `-v` creates the endpoint for you. It is always creates as a directory.
2. `-v` doesn't create the endpoint for you.
3. `-v` creates either the file or directory endpoint for you.
4. The docker daemon exits with an Error: `Path not found`.

### Question 

Given the below container running command:

```bash
docker run -v /home/elvis/data:/data mysql
```

1. `/home/elvis/data` is a path in the host machine.
1. `/home/elvis/data` is a path in the container.
1. `/data` is a path in the container.
1. `/data` is a path in the host machine.

### Question 

Given the below running container command executed by `elvis`:

```bash
[elvis@hostname]$ docker run -it -v /test_data:/test_data busybox /bin/sh
```

Assume the command `touch /test_data/hi` was successfully executed from within the container. 
When running `ls -l /test_data` **from the host machine**, who are the user and group owners of the created `hi` file?

1. `elvis`
2. `dockerd`
3. `root`
4. Since this file was created from within a container in the host machine fs, there is no user and group owning the file. 
5. None of the above.


### Question 

You want to mount the path `/etc/resolv.conf` from your host machine into the container file system. 
So the container will share the content of `/etc/resolv.conf` as it's defined in the host machine. 

Which method will work?

1. Using bind-mount.
2. Using volumes.
3. Both volumes and bind-mount will work.
4. `tmpfs` mounts


