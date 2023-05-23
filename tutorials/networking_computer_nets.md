# Computer Networks

So far, we've seen simple communication between 2 standalone hosts.
In real life, computers are often arranged into "groups" to improve network performance, simplify network management, and increase network security.

In this tutorial we'll describe and investigate the components of computer networks and subnetworks. 

## Subnets

Computer networks organize machines into sub networks, or **subnets**.
All machines on a given subnet may exchange information directly.
Subnets are in turn linked to other subnets by machines acting as **routers**.


![](../.img/subnets.png)

The above network consists of 3 subnets. Taking a closer look, we notice that computers under the same subnet have the same ip prefix. For example, all computers under the leftmost subnet (and all computers that will join this subnet) have an IP address starting by `10.1.1.xxx`. Thus, they share the same IP prefix, more precisely, the same first **24 bits** in their IP address.

We will denote the IP boundaries of the leftmost subnet by:

```text
10.1.1.0/24
```

This method is known as **Classless Interdomain Routing (CIDR)**.

The CIDR `10.1.1.0/24` represents a network address in IPv4 format with the network prefix length of 24 bits. This means that the first 24 bits of the IP address, i.e., the first three octets, specify the **network portion**, and the remaining 8 bits, i.e., the fourth octet, represent the **host portion**. 
In this case, the network address is `10.1.1.0`, and there are 256 possible host addresses (2^8 = 256) within this network, ranging from `10.1.1.1` to `10.1.1.254` (the first and last IP addresses are reserved).

Another method to denote network subnet in **subnet mask**.
This format specifies the number of fixed octates of the IP as 255, and the free octates as 0. The equivalent subnet mask for `10.1.1.0/24` is `255.255.255.0`,  which means the first 3 octets are the network portion (fixed) and 4th octet is the hosts portion (change per machine in the subnet).

Use [this nice tool](https://cidr.xyz/) to familiarize yourself with CIDR notation.

The `ping` command can be used to confirm IP connectivity between two hosts:

```console
myuser@10.1.1.1:~$ ping 10.1.2.2
PING 10.1.2.2 56(84) bytes of data.
64 bytes from 10.1.2.2: icmp_seq=1 ttl=51 time=3.29 ms
64 bytes from 10.1.2.2: icmp_seq=2 ttl=51 time=3.27 ms
64 bytes from 10.1.2.2: icmp_seq=3 ttl=51 time=3.28 ms
...
```

In the above example, the computer identified by the IP `10.1.1.1` sends ping frames to `10.1.2.2`.

In order to communicate with a host on another subnet, the data must be passed to a router, which routes the information to the appropriate subnet, and from there to the appropriate host. Before examining that mechanism, let's introduce 3 important concepts: **Route table**, **Default gateway**, **Network interfaces**.


## Route Table and Default gateway

In order to communicate with machines outside of your local subnet, your machine must know the identity of a nearby router. The router used to route packets outside of your local subnet is commonly called as a **default gateway**.

In the above network figure, `10.1.1.4` is the default gateway IP of the leftmost subnet, while `10.1.2.31` is the default gateway IP of the rightmost subnet.

The Linux kernel maintains an internal table which defines which machines should be considered local, and what gateway should be used to help communicate with those machines which are not. This table is called the **routing table**.

The `route` command can be used to display the system's routing table (`ip route` is a more modern command).

```console
myuser@10.1.1.1:~$ route -n
Kernel IP routing table
Destination    Gateway        Genmask         Flags Metric Ref    Use Iface
0.0.0.0        10.1.1.4       0.0.0.0         UG    100    0        0 eth0
10.1.1.0       0.0.0.0        255.255.255.0   U     100    0        0 eth0
```

We will start with the second route. The second route specifies that traffic destined for the `10.1.1.0/24` network should remain in the subnet, there is no need to route the traffic to any nearby router, since sent traffic is destined for a machine in the same subnet. The `0.0. 0.0` appears in the Gateway column indicates that the gateway to reach the corresponding destination subnet is unspecified.

The first route specifies that traffic destined for the `0.0.0.0/0` be routed to `10.1.1.4`, which is the IP address of the default gateway in this subnet (take a look at the above diagram). Note that a destination of `0.0.0.0/0` means “all the internet”, since any IP address will match this CIDR.  

Is there any issue here? Isn’t the IP range defined by the two destinations overlap?  For example, the ip `10.1.1.5` matches both the first and the second routes.

In order to overcome the problem of routing ambiguity, where a single destination can be reached through multiple gateways, the route table uses the longest prefix match method to match IP traffic to the correct destination. This method compares the **longest matching prefix** of an IP address in the routing table with the destination IP address of the incoming packet, allowing the router to determine the most specific route to the destination.

Given the above route table of host `10.1.1.1`, where will the traffic `10.1.2.2` be routed?

Let’s recall our original motivation, `10.1.1.1` is trying to talk with `10.1.2.2`. And now after we’ve seen the IP table of `10.1.1.1`, we know that the traffic will be routed to the default gateway (`10.1.1.4`).


## Network interfaces

In the OSI model, we've seen that every bit of data being sent over the network must pass through the lower layer - the Network Interface layer, which provides the physical and electrical interface between the networking hardware and the data being transmitted. Linux represents every networking device attached to a machine (such as an Ethernet card, wireless card, etc...) as a **network interface**.

In linux, the `ip` command can show/manipulate network interfaces, and more...

```console
myuser@hostname:~$ ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc mq state UP group default qlen 1000
    link/ether 0a:5c:36:18:fe:82 brd ff:ff:ff:ff:ff:ff
    inet 223.1.1.1/24 metric 100 brd 223.1.1.255 scope global dynamic eth0
       valid_lft 3559sec preferred_lft 3559sec
    inet6 fe80::85c:36ff:fe18:fe82/64 scope link 
       valid_lft forever preferred_lft forever
```


The above output shows 2 available network interfaces in the machine.

- `lo` (loopback) is being used to facilitate communication between processes running on the same host (internal communication).
- `eth0` is being used for connecting a computer to a wired Ethernet network.

Before an interface can be used to send or receive traffic, it must be configured with an IP address which serves as the interface's identity. In the above output, the interface `eth0` is assigned an IP address `10.1.1.1`, which is the IP address of the "machine" (in reality, a "machine" does not have an IP address, a machine's network interfaces do).

Linux names interfaces according to the type of device it represents. The following table lists some of the more commonly encountered interface names used in Linux.


## Network interfaces

| Interface      | Device |
| ----------- | ----------- |
| `eth`n (sometimes `ens`n)      | Ethernet Card      |
| `lo`      | Loopback Device      |
| `wlp`n      | Wireless Device      |
| `virbr`n      | Virtual bridge      |
| `enp0s`n | VirtualBox VM running Ubuntu | 

How does the kernel know the correct network interface for which to route packets? Take a closer look at the above route table…

## The `traceroute` command

When connecting to a machine outside of your subnet, your packet is passed from router to router as it
traverses various subnets, until finally the packet is delivered to the subnet which contains the destination
machine.

![](../.img/route.png)

The path of the packet, as it is passed from router to router, can be traced with the `traceroute` command.
The traceroute command is generally called with a single argument, the hostname or IP address of the destination machine.

```console 
myuser@hostname:~$ traceroute google.com
traceroute to google.com (142.250.74.46), 30 hops max, 60 byte packets
 1  ec2-13-53-0-203.eu-north-1.compute.amazonaws.com (13.53.0.203)  1.665 ms * *
 2  * * 240.0.16.13 (240.0.16.13)  0.170 ms
 3  241.0.2.197 (241.0.2.197)  0.176 ms 241.0.2.200 (241.0.2.200)  0.208 ms 241.0.2.198 (241.0.2.198)  0.165 ms
 4  240.0.16.19 (240.0.16.19)  0.180 ms 242.0.124.121 (242.0.124.121)  1.926 ms 242.0.125.105 (242.0.125.105)  0.375 ms
 5  242.0.124.97 (242.0.124.97)  0.614 ms 52.93.142.149 (52.93.142.149)  3.929 ms 52.93.142.181 (52.93.142.181)  3.913 ms
 6  52.93.142.149 (52.93.142.149)  3.916 ms  3.868 ms 52.93.145.226 (52.93.145.226)  2.764 ms
 7  52.93.145.54 (52.93.145.54)  3.274 ms 52.93.143.27 (52.93.143.27)  3.920 ms 52.93.145.184 (52.93.145.184)  18.886 ms
 8  99.83.118.165 (99.83.118.165)  3.272 ms 52.93.143.69 (52.93.143.69)  11.419 ms 99.83.118.165 (99.83.118.165)  3.148 ms
 9  99.83.118.165 (99.83.118.165)  3.196 ms * *
10  * * *
11  108.170.254.33 (108.170.254.33)  4.244 ms 142.251.48.40 (142.251.48.40)  3.323 ms 108.170.254.54 (108.170.254.54)  7.028 ms
12  108.170.253.177 (108.170.253.177)  3.350 ms 142.250.239.183 (142.250.239.183)  3.142 ms 108.170.254.54 (108.170.254.54)  3.790 ms
13  142.250.239.185 (142.250.239.185)  3.611 ms  3.616 ms 108.170.253.161 (108.170.253.161)  3.833 ms
14  arn09s22-in-f14.1e100.net (142.250.74.46)  3.533 ms  3.093 ms 142.250.239.183 (142.250.239.183)  3.936 ms
```

The number of routers that your packet passes through is generally referred to as the number of **hops** the packet has made.

## New IP address allocation and the DHCP 

In order to obtain a block of IP addresses for use within a subnet, a network administrator might first contact its ISP,
which would provide addresses from a larger block of addresses that had already been allocated to the ISP. 
In general, IP addresses are managed under the authority of the Internet Corporation for Assigned Names and Numbers ([ICANN](https://www.icann.org/)).

The Dynamic Host Configuration Protocol (DHCP) allows a host to obtain an IP address automatically within a subnet.

![](../.img/dhcp1.png)

The below diagram examines the process by which a new client receiving an IP address from a DHCP server:

![](../.img/dhcp2.png)

### The Discover, Offer, Request, Acknowledge (DORA) process

DORA process refers to the four steps that are involved in DHCP client-server interaction. These four steps are:

- **Discover**: The client broadcasts a DHCP discover message on the local network, requesting an IP address lease from any available DHCP server.
- **Offer**: DHCP servers on the local network respond to the broadcast with a DHCP offer message, which includes an available IP address, lease duration, and other configuration parameters.
- **Request**: The client selects one of the offered IP addresses and sends a DHCP request message to the DHCP server, requesting the lease.
- **Acknowledge**: If the DHCP server approves the client's request, it sends a DHCP acknowledge message to the client, confirming the IP address lease and providing any other configuration parameters.

The DORA process allows a DHCP client to obtain an IP address and other configuration information from a DHCP server. It is an important part of network configuration, as it enables automatic IP address assignment and ensures consistency in network settings across multiple devices.


## IP Address for private subnets

There are three ranges of private IP addresses defined in [RFC 1918](https://www.rfc-editor.org/rfc/rfc1918):

- 10.0.0.0/8
- 172.16.0.0/12
- 192.168.0.0/16

These addresses can be used for internal networks within an organization, but they are not routable on the public Internet.

Public IP addresses, on the other hand, are assigned by Internet authorities and are used to identify devices that are directly accessible from the Internet.

# Self-check questions

[Enter the interactive self-check page](https://alonitac.github.io/DevOpsBootcampUPES/multichoice-questions/networking_computer_nets.html)


# Exercises

### :pencil2: Network design

Design a network of four different subnets with 250 machines, 12 machines, 112 machines and 53 machines respectively.
Your network administrator gave you `10.88.132.0/22` CIDR for these subnets.
What are the four subnets address you would like to assign to those three subnets? You must provide CIDR in the form of `/24`.

### :pencil2: virtual internet gateways

In this exercise, we will create a pair of virtual network interfaces on your local machine.
A virtual network interface is a software-based interface that emulates a physical network interface, allowing us to create multiple logical networks on a single physical machine.
We will then perform a network performance test using `iperf` to see the impact of the bandwidth and latency restrictions on network performance. The goal of this exercise is to demonstrate the use of virtual network interfaces and traffic control in a practical network scenario.

1. In our shared Git repo, under the `virtual_nic` directory in our shared repo, execute the `init.sh` script to start the exercise. Note that the script should be run as `root`. At the end of the execution, you’ve effectively created a network consists of 2 “subnets” (under the hood, these are not real subnets, but only two isolated [network namespaces](https://man7.org/linux/man-pages/man7/network_namespaces.7.html)) with two different network interfaces that can send traffic to each other:

```bash
$ sudo bash -e init.sh
```

![](../.img/subnet_ex.png)

2. Now, start a bash session “within” subnet `ns1` (again, we use the term “subnet” just to get you to understand the simulated scenario.  From now on, instead of subnet, we will use the correct term - network namespace)

```bash
$ sudo ip netns exec ns1 bash
```

3. In another terminal windows, start a bash session within network namespace ns2:

```bash
$ sudo ip netns exec ns2 bash
```

**Tasks:**

1. First, explore your system, perform `ip address` to see the network interfaces in each network namespace, and explore the route table.
2. ping `ns2` from `ns2`, make sure the ping succeeds.
3. From `ns2`, use `iperf` to run a testing server by:

```bash
$ iperf -s
```

`iperf` is a network performance testing tool that can measure the bandwidth, packet loss, and latency of network connections. The server is using TCP and port 5001 by default.

4. From `ns1`, perform a networking performance test using `iperf` as a client:

```bash
$ iperf -c <ip-of-ns1-interface>
```

The test results should be similar to:

```text
------------------------------------------------------------
Client connecting to 10.0.0.1, TCP port 5001
TCP window size:  340 KByte (default)
------------------------------------------------------------
[  1] local 10.0.0.0 port 40024 connected with 10.0.0.1 port 5001
[ ID] Interval   	Transfer 	Bandwidth
[  1] 0.0000-10.0339 sec  1.22 GBytes  1.05 Gbits/sec
```

5. Stop the server in `ns1`.
6. We will now use the `tc` command to restrict the performance of `ns1` virtual interfaces. From the bash terminal of `ns1`, execute the below commands:

```bash
tc qdisc add dev eth0 root handle 1: tbf rate 1mbit burst 32kbit latency 400ms
tc qdisc add dev eth0 parent 1:1 handle 10: netem loss 5%
```

7. Perform the above test again, what are the results? How was the network bandwidth damaged?
8. Stop the server in `ns1` and now run it as a UDP server:

```bash
$ iperf -s -u
```

9. Execute the client test from `ns2`:

```bash
$ iperf -c <ns10-interface-ip>-u -b 1M -l 100
```

What is the packet loss percentage?

## Optional practice

### :pencil2: Non-standard CIDR

Observe the `172.16.0.0/12` CIDR. This is an unconventional CIDR since it doesn't fix the whole octet, but only the first 4 bits of the second octet. Use https://cidr.xyz/ to answer the below questions:

1. How many bits can vary?
2. How many available addresses in this CIDR (host addresses)?
3. What does the 2nd octet bit representation look like?
4. What is the next decimal number in the 2nd octet (after 16?)
5. Is 10.32.0.0 part of the CIDR?


### :pencil2: Your default gateway MAC address

Use the `ip neighbor` command to find the MAC address of your default gateway interface.


