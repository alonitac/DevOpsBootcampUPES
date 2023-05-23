# Docker - containers - multichoice questions


### Question 

You are trying to run a docker container based on the [Ubuntu image](https://hub.docker.com/_/ubuntu), with the `-it` flags, and get the below error:

```bash
docker run ubuntu -it
```

```text 
docker: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: "-it": executable file not found in $PATH: unknown.
ERRO[0005] error waiting for container: context canceled
```

What is the root cause? 

1. Docker daemon is not up and running. Execute `sudo systemctl start docker`.
2. The machine cannot run containers.
3. Docker recognizes the `-it` flags as the container command. Execute `docker run -it ubuntu` instead.
4. The `ubuntu` docker image doesn't exist on the machine. Execute `docker pull ubuntu` before. 

### Question 

From the perspective of the host machine, a running Docker container is essentially considered as just another process within the system. 
However, inside the container itself, the running process operates within its own isolated environment, perceiving itself as the sole process within that system.

Choose the correct sentence(s) regarding the process id:

1. The PID of the container as it is seen from the host machine is the same as it seen within the container.
2. The PID of the container as it is seen from the host machine is different from the PID as it is seen within the container.
3. The PID of the container as it is seen within the container is 1.
4. The PID of the container is the same as the docker daemon's PID (`dockerd`).

### Question 

After a while, what is the status of the container started by:

```bash 
docker run ubuntu ps
```

1. Running
2. Stopped
3. Existed
4. Created
5. None of the above.

### Question 

When running `docker run -e MYSQL_ROOT_PASSWORD=1234 mysql`, what is the main process name of the container as it's seen **from the host machine**?

1. `mysqld`
2. `dockerd`
3. `containerd`
4. `runc`
5. None of the above


Based on the below output of `docker inspect 303ce6e8af55` on some running container:

```json
[
    {
        "Id": "303ce6e8af55f0bd6a431a01dcc3dbca140bdcc5b55d4f1e21c6a3fcba3e5810",
        "Created": "2023-05-08T08:11:49.412947069Z",
        "Path": "docker-entrypoint.sh",
        "Args": [
            "mysqld"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 294355,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2023-05-08T08:11:51.873706592Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:8189e588b0e8fcc95b0d764d6f7bdb55b5b41e9249157177d73781058f603ca9",
        "ResolvConfPath": "/var/lib/docker/containers/303ce6e8af55f0bd6a431a01dcc3dbca140bdcc5b55d4f1e21c6a3fcba3e5810/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/303ce6e8af55f0bd6a431a01dcc3dbca140bdcc5b55d4f1e21c6a3fcba3e5810/hostname",
        "HostsPath": "/var/lib/docker/containers/303ce6e8af55f0bd6a431a01dcc3dbca140bdcc5b55d4f1e21c6a3fcba3e5810/hosts",
        "LogPath": "/var/lib/docker/containers/303ce6e8af55f0bd6a431a01dcc3dbca140bdcc5b55d4f1e21c6a3fcba3e5810/303ce6e8af55f0bd6a431a01dcc3dbca140bdcc5b55d4f1e21c6a3fcba3e5810-json.log",
        "Name": "/tender_keldysh",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "docker-default",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {},
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "CapAdd": null,
            "CapDrop": null,
            "CgroupnsMode": "host",
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "private",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "ConsoleSize": [
                0,
                0
            ],
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": null,
            "BlkioDeviceWriteBps": null,
            "BlkioDeviceReadIOps": null,
            "BlkioDeviceWriteIOps": null,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DeviceRequests": null,
            "KernelMemory": 0,
            "KernelMemoryTCP": 0,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": false,
            "PidsLimit": null,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/0527b66c2da10505245168d1f084e150f9e56e4d42624569e1215536ec68231e-init/diff:/var/lib/docker/overlay2/d583e5274db743d86305fcfd36400a8a7a284f85709be7867bc0aa0b4cfaf32c/diff:/var/lib/docker/overlay2/0894921d7fe333aecd2516569141b5b70bfc2176128bf702eb7a974b8b7d183f/diff:/var/lib/docker/overlay2/c85383b79b37477fcbc236d42a5c5d228aea3f6933545e766a18029bc15b325d/diff:/var/lib/docker/overlay2/e7b712edcfed325a29bd24988e0d333fe8319398d3b38f71693af0a42e0a44a1/diff:/var/lib/docker/overlay2/ec9e92d41afa2d9fce8319582088669a16a48410d4e6ada53808d3089edc1765/diff:/var/lib/docker/overlay2/dc8021555938324415ceb966ce65bf42d6073797506032e69ed20448a7782e12/diff:/var/lib/docker/overlay2/040dae4ad608f96f9d68bee713db988728c6eadb6b516fabbf7d6b894be3b38d/diff:/var/lib/docker/overlay2/977da7c8267e343cad6a45505a2b590751988723e82b010a3e244f7132c0eeac/diff:/var/lib/docker/overlay2/da5008015b904ebf4b70df8d72c7a52567153d1586a0f7725d30036cd872f5ac/diff:/var/lib/docker/overlay2/253485cdcce0d7e45d6da86be4bee0dace9eef58fbf02bc1f009b3c7a95ab54d/diff:/var/lib/docker/overlay2/b89da9e305923e3c37291ad5f0cd90696d6f2e5e76f0fca87d1e1bcf9178714d/diff",
                "MergedDir": "/var/lib/docker/overlay2/0527b66c2da10505245168d1f084e150f9e56e4d42624569e1215536ec68231e/merged",
                "UpperDir": "/var/lib/docker/overlay2/0527b66c2da10505245168d1f084e150f9e56e4d42624569e1215536ec68231e/diff",
                "WorkDir": "/var/lib/docker/overlay2/0527b66c2da10505245168d1f084e150f9e56e4d42624569e1215536ec68231e/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [
            {
                "Type": "volume",
                "Name": "d6865699c2f97b1abd429d41e9902e29f1a909355242ef1f6f4bb7abf0dd296e",
                "Source": "/var/lib/docker/volumes/d6865699c2f97b1abd429d41e9902e29f1a909355242ef1f6f4bb7abf0dd296e/_data",
                "Destination": "/var/lib/mysql",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            }
        ],
        "Config": {
            "Hostname": "303ce6e8af55",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": true,
            "AttachStderr": true,
            "ExposedPorts": {
                "3306/tcp": {},
                "33060/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "MYSQL_ROOT_PASSWORD=1234",
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "GOSU_VERSION=1.16",
                "MYSQL_MAJOR=8.0",
                "MYSQL_VERSION=8.0.33-1.el8",
                "MYSQL_SHELL_VERSION=8.0.33-1.el8"
            ],
            "Cmd": [
                "mysqld"
            ],
            "Image": "mysql",
            "Volumes": {
                "/var/lib/mysql": {}
            },
            "WorkingDir": "",
            "Entrypoint": [
                "docker-entrypoint.sh"
            ],
            "OnBuild": null,
            "Labels": {}
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "ee1dd90916d4b1078246e248676863a4d3c0ab454bef7a1bc5476da95aa0f176",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
                "3306/tcp": null,
                "33060/tcp": null
            },
            "SandboxKey": "/var/run/docker/netns/ee1dd90916d4",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "6cf6a9c5505da1d30922219bccbd91c6fea71aaa3c67ab53163b99144e40bd11",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.3",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:03",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "c870c05c5ce1e9d7a8711ada1826eead7e54ecf4847f61e43be30e672008bdbd",
                    "EndpointID": "6cf6a9c5505da1d30922219bccbd91c6fea71aaa3c67ab53163b99144e40bd11",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.3",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:03",
                    "DriverOpts": null
                }
            }
        }
    }
]
```

Answer the bellow 6 questions.

### Question

What is the IP address of the container? 

1. `172.17.0.1`.
2. `172.17.0.3`.
3. `127.0.0.1`.
4. IP v6: `02:42:ac:11:00:03`.

### Question 

How many ports are exposed by the container? 

1. 0
2. 1
3. 2
4. 3
5. None of the above


### Question 

How many environment variables are given to the container process?

1. 0
2. 2
3. 4
4. 6
5. 8

### Question 

Was the container run with the `-it` flags? 

1. Yes
2. No
3. We couldn't know from the output.

### Question

The container status is:

1. Exited
2. Created
3. Running 
4. Restarting
5. We couldn't know from the output.

### Question 

What is the PID of the container as it is seen from the host machine? 

1. 1
2. 294355
3. 67108864
4. We couldn't know from the output. 


### Question 

The [official `mysql` image](https://hub.docker.com/_/mysql) is running by the following command: `docker run -e MYSQL_ROOT_PASSWORD=1234 mysql`. 

Choose the correct answer: 

1. The MySQL database is accessible from the host machine on port `3306`.
2. The MySQL database is accessible from the host machine on port `8080`.
3. The MySQL database is accessible from the host machine on port `80`.
4. The database is not accessible from the host machine. 

### Question 

The [official `mysql` image](https://hub.docker.com/_/mysql) is running by the following command: `docker run -e MYSQL_ROOT_PASSWORD=1234 mysql`.

Which of the below docker commands can help with debugging the `/var/run/mysqld/mysqld.sock` file, which is located within the container? 

1. `docker exec`
2. `docker logs`
3. `docker run`
4. `docker top`


### Question 

When the docker service is restarted by (under default docker daemon configurations):

```bash
sudo systemctl restart docker
```

What happens to the running containers? 

1. Running containers are killed.
2. Running containers are stopped.
3. Nothing happens since Docker doesn't run the containers itself, but `runc` does.
4. None of the above. 

### Question 

Which command(s) can help you to resolve the following error: 

```text
Error response from daemon: You cannot remove a running container 76004df79402d330992abe9f423715904fb590663f797fee3bca4e9e877f0ac0. Stop the container before attempting removal or force remove
```

1. `docker run 76004df794`
2. `docker kill --signal STOP 76004df794`
3. `docker top 76004df794`
4. `docker stop 76004df794`
5. `docker pause 76004df794`

### Question 

What is the docker image name with which the below container is running?

```bash
docker run --name mybusy busybox wget localhost
```

1. `mybusy`
2. `busybox`
3. `wget`
4. `localhost`
5. None of the above


### Question 

Consider the bellow two `docker run` commands:

```bash
docker run -p 8080:80 nginx
docker run -p 8080:80 nginx
```

Assume there are no other containers running on the host machine. 
Choose the correct sentence:

1. The commands create and run two different containers successfully.
2. The second command does nothing since the first command runs the nginx container image successfully.
3. The seconds command will fail since you are not able to run two different containers from the `nginx` image.
4. None of the above.


### Question 

The following command has run successfully:

```bash
docker run -it ubuntu /bin/bash
```

What can be id for sure regarding the container:

1. The `ubuntu` image existed on the machine before the command was executed.
2. The binary `/bin/bash` exists in the container's file system. 
3. The `-it` flags allow you to run within the container every command that is available on the host machine.
4. None of the above.

### Question 

You are trying to run an `nginx` container using the following command: 

```bash
docker run --name some-nginx -e DEBUG=true nginx
```

But encounter the following error:

```text
docker: Error response from daemon: Conflict. The container name "/some-nginx" is already in use by container "761aacef37cfe438f77fe92d6e4a2eeecc6d72c9cea9eb5f73d5af5a1ae377d2". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'
```

Which command can help you resolve the problem? 

1. `docker run --force --name some-nginx -e DEBUG=true nginx`
2. `docker rm some-nginx`
3. `docker kill some-nginx`
4. `docker rename some-nginx some-ng`