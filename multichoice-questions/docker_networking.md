# Docker - Networking - multichoice questions

Given the below executed commands: 

```bash
docker network create mynet5
docker run --name mynginx --network mynet5 nginx
```

Answer the below 3 questions. 

## Question 1

What is the networking driver used by the network `mynginx` is connected to?

- [ ] Overlay
- [ ] None 
- [ ] Host
- [ ] Bridge

## Question 2

You are told that the container's IP address is: `172.18.0.2`.
Choose the correct sentence(s).

The `mynginx` container:

- [ ] Is accessible form the host machine using `http://localhost:80`.
- [ ] Is accessible form the host machine using `http://172.18.0.2:80`.
- [ ] Is accessible form other containers attached to network `mynet5` using `http://172.18.0.2:80`.
- [ ] Is accessible form other containers attached to network `mynet5` using `http://mynginx:80`.
- [ ] The container is not accessible.

## Question 3

The `mynginx` container was detached from `mynet5` network and attached to the default bridge network.
Choose the correct sentence(s).

The `mynginx` container:

- [ ] Is accessible form the host machine using `http://localhost:80`.
- [ ] Is accessible form the host machine using `http://172.18.0.2:80`.
- [ ] Is accessible form other containers attached to network `mynet5` using `http://172.18.0.2:80`.
- [ ] Is accessible form other containers attached to network `mynet5` using `http://mynginx:80`.
- [ ] The container is not accessible.

## Question 4

What is the name of the network interface of the default bridge network which Docker is shipped with?  

**Hint**: `ip address`

- [ ] `lo`
- [ ] `docker0`
- [ ] `veth`
- [ ] `virbr0`

## Question 5

Given the following running container:

```bash
docker run -it busybox /bin/sh
```

DNS queries requested from within this container: 

- [ ] Uses Docker's embedded DNS server.
- [ ] Uses the DNS servers configured on the host machine.
- [ ] Uses the bridge custom DNS server.
- [ ] None of the above. 

## Question 6

Containers can have multiple IP addresses:

- [ ] When connected to multiple networks
- [ ] Container can have only one IP address. 
- [ ] When connected to an overlay networks .
- [ ] When running under the `host` network. 

## Question 7

In order to execute the following command successfully:

```
docker run -p 8080:80 my-app
``` 

- [ ] The docker daemon service should be up and running.
- [ ] Port `8080` must not be bound to another process in the host machine.
- [ ] Port `80` must not be bound to another process in the host machine.
- [ ] Port `8080` must not be bound to another process other running containers launched from the `my-app` image.
- [ ] Port `80` must not be bound to another process other running containers launched from the `my-app` image.

Given the following running container: 

```bash 
docker run --network host redis
```

Answer the below 4 questions

## Question 8

Running the `ip address` command from within the container (you can install the command by `apt update && apt install iproute2`): 

- [ ] Lists the network interfaces of the host machine.
- [ ] Lists the network interfaces used by docker daemon.
- [ ] Lists the virtual bridge network interface of the container.
- [ ] None of the above

## Question 9

Choose the correct sentence(s):

- [ ] The container can be connected to user-defined bridge network.
- [ ] The container cannot be connected to user-defined bridge network.
- [ ] The container can be connected to the default bridge network.
- [ ] The container cannot be connected to the default bridge network.

## Question 10

The user tries to run another `redis` container as follows:

```bash 
docker run --network host redis
```

Why is the command failed? 

- [ ] The container must have a name other than `redis`.
- [ ] Only one container can be run on the `host` network for each docker image.
- [ ] The network `host` doesn't exist in the host machine.
- [ ] Port `6379` is already in use by the first running `redis`.


## Question 11

Assume port `6378` is bound to another process in the host machine, 
while port `6379` is free.
What would happen if instead of running the original command, the user would have run:

```bash 
docker run -p 6378:6379 --network host redis
```

- [ ] The container will fail since port `6378`, which is published on the host machine, is already in use.
- [ ] The container will run since port `6379` is not bound to any process.
- [ ] The container will fail since port `6379`, which is published on the host machine, is already in use.
- [ ] The container will run since port `6378` is not bound to any process.

