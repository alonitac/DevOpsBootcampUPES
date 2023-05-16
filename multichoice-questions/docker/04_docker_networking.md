# Docker - networking - multichoice questions

Given the below executed commands: 

```bash
docker network create mynet5
docker run --name mynginx --network mynet5 nginx
```

Answer the below 3 questions. 

### Question

What is the networking driver used by the network `mynginx` is connected to?

1. Overlay
2. None 
3. Host
4. Bridge

### Question 

You are told that the container's IP address is: `172.18.0.2`.
Choose the correct sentence(s).

The `mynginx` container:

1. Is accessible form the host machine using `http://localhost:80`.
2. Is accessible form the host machine using `http://172.18.0.2:80`.
3. Is accessible form other containers attached to network `mynet5` using `http://172.18.0.2:80`.
4. Is accessible form other containers attached to network `mynet5` using `http://mynginx:80`.
5. The container is not accessible.

### Question 

The `mynginx` container was detached from `mynet5` network and attached to the default bridge network.
Choose the correct sentence(s).

The `mynginx` container:

1. Is accessible form the host machine using `http://localhost:80`.
2. Is accessible form the host machine using `http://172.18.0.2:80`.
3. Is accessible form other containers attached to network `mynet5` using `http://172.18.0.2:80`.
4. Is accessible form other containers attached to network `mynet5` using `http://mynginx:80`.
5. The container is not accessible.

### Question 

What is the name of the network interface of the default bridge network which Docker is shipped with?  

**Hint**: `ip address`

1. `lo`
2. `docker0`
3. `veth`
4. `virbr0`

### Question 

Given the following running container:

```bash
docker run -it busybox /bin/sh
```

DNS queries requested from within this container: 

1. Uses Docker's embedded DNS server.
2. Uses the DNS servers configured on the host machine.
3. Uses the bridge custom DNS server.
4. None of the above. 

### Question 

Containers can have multiple IP addresses:

1. When connected to multiple networks
2. Container can have only one IP address. 
3. When connected to an overlay networks .
4. When running under the `host` network. 

### Question 

In order to execute the following command successfully:

```
docker run -p 8080:80 my-app
``` 

1. The docker daemon service should be up and running.
2. Port `8080` must not be bound to another process in the host machine.
3. Port `80` must not be bound to another process in the host machine.
4. Port `8080` must not be bound to another process other running containers launched from the `my-app` image.
5. Port `80` must not be bound to another process other running containers launched from the `my-app` image.

Given the following running container: 

```bash 
docker run --network host redis
```

Answer the below 4 questions

### Question 

Running the `ip address` command from within the container (you can install the command by `apt update && apt install iproute2`): 

1. Lists the network interfaces of the host machine.
2. Lists the network interfaces used by docker daemon.
3. Lists the virtual bridge network interface of the container.
4. None of the above

### Question

Choose the correct sentence(s):

1. The container can be connected to user-defined bridge network.
2. The container cannot be connected to user-defined bridge network.
3. The container can be connected to the default bridge network.
4. The container cannot be connected to the default bridge network.

### Question

The user tries to run another `redis` container as follows:

```bash 
docker run --network host redis
```

Why is the command failed? 

1. The container must have a name other than `redis`.
2. Only one container can be run on the `host` network for each docker image.
3. The network `host` doesn't exist in the host machine.
4. Port `6379` is already in use by the first running `redis`.


### Question 

Assume port `6378` is bound to another process in the host machine, 
while port `6379` is free.
What would happen if instead of running the original command, the user would have run:

```bash 
docker run -p 6378:6379 --network host redis
```

1. The container will fail since port `6378`, which is published on the host machine, is already in use.
1. The container will run since port `6379` is not bound to any process.
1. The container will fail since port `6379`, which is published on the host machine, is already in use.
1. The container will run since port `6378` is not bound to any process.

