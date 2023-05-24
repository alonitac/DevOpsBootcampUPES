# Networking - subnets - multichoice questions


## Question 1

How many different hosts can be connected to the subnet denoted by `10.0.1.0/24`?

- [ ] 254
- [ ] 24
- [ ] 1024
- [ ] 255

## Question 2

Which of the following subnets is most specifically describes the following list of hosts IP:

- 172.31.8.17
- 172.31.37.152
- 172.31.33.152
- 172.31.42.73
- 172.31.8.46

<br>

- [ ] `172.31.0.0/16`
- [ ] `172.31.0.0/24`
- [ ] `172.31.8.0/24`
- [ ] `172.0.0.0/16`

Use the following transcript to answer the next 4 questions.

```console
[madonna@station madonna]$ ip address
eth0    	Link encap:Ethernet HWaddr 00:00:86:4D:F0:0C
inet addr:118.45.92.51 Bcast:118.45.92.255 Mask:255.255.255.0
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:242939 errors:0 dropped:0 overruns:0 frame:0
TX packets:302515 errors:0 dropped:0 overruns:1 carrier:1
collisions:0 txqueuelen:100
RX bytes:24308852 (23.1 Mb) TX bytes:166603272 (158.8 Mb)
Interrupt:11 Base address:0xd400

lo      	Link encap:Local Loopback
inet addr:127.0.0.1 Mask:255.0.0.0
UP LOOPBACK RUNNING MTU:16436 Metric:1
RX packets:29291 errors:0 dropped:0 overruns:0 frame:0
TX packets:29291 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:0
RX bytes:2661822 (2.5 Mb) TX bytes:2661822 (2.5 Mb)

[madonna@station madonna]$ route -n
Kernel IP routing table
Destination 	Gateway 	Genmask     	Flags Metric Ref Use Iface
118.45.92.0 	0.0.0.0 	255.255.255.0   U   0   0 0 eth0
```

## Question 3

What is the IP address of madonna's machine?

- [ ] `118.45.92.0`
- [ ] `127.0.0.1`
- [ ] `118.45.92.51`
- [ ] `66.23.35.53`
- [ ] Not enough information is provided.


## Question 4

Which file is used when resolving the hostname localhost?

- [ ] `/etc/inittab`
- [ ] `/etc/hosts`
- [ ] `/etc/resolv.conf`
- [ ] `/etc/sysconfig/localhost`
- [ ] None of the above

## Question 5

Which of the following error messages most likely appear when madonna sends traffic to 16.74.114.3

- [ ] Host is not resolvable
- [ ] 404 page not found
- [ ] Internal server error
- [ ] No route to host
- [ ] None of the above

## Question 6

To which network interface will the traffic be routed for the IP address `127.1.1.1`?

- [ ] `eth0`
- [ ] `lo`
- [ ] None of the above


## Question 7

Suppose you have the following IP address: `192.168.1.128`
Using the [longest prefix match](https://en.wikipedia.org/wiki/Longest_prefix_match) algorithm to determine the route, which of the following networks will this IP address be routed to?

- [ ] `192.168.1.0/32`
- [ ] `192.168.1.0/24`
- [ ] `192.168.1.0/16`
- [ ] `192.168.1.0/0`

## Question 8

Given an IP address of `10101010 11110000 00111111 00001111`, which of the below routes would be taken when using the longest prefix match algorithm?

- [ ] `10000000 00000000 00000000 00000000/3`
- [ ] `11000000 00000000 00000000 00000000/3`
- [ ] `10100000 00000000 00000000 00000000/3`
- [ ] `10000000 00000000 00000000 00000000/3`

## Question 9

Given the below output of the `ip address` command:

```text
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
inet 127.0.0.1/8 scope host lo
valid_lft forever preferred_lft forever

2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
inet 192.168.0.2/24 brd 192.168.0.255 scope global eth0
valid_lft forever preferred_lft forever

3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
inet 192.168.1.2/24 brd 192.168.1.255 scope global wlan0
valid_lft forever preferred_lft forever
```

Assuming that a request is made to the IP address `192.168.2.0`, which network interface will be used to route this request?

- [ ] 1
- [ ] 2
- [ ] 3
- [ ] None of the above

Consider the below network, described by `156.1.0.0/16`.

```text
                    +--------------+
                    |  Subnet A    |
                    | 127 hosts    |
                    | 156.1.1.0/24 |
                    +--------------+
                           |
                           |
                           |
          +-----------------------------+
          |                             |
+-----------------+                   +----------------+
|    Subnet B     |                   |    Subnet C    |
|    58 hosts     |                   |    29 hosts    |
|   156.1.45.0/24 |                   | 156.1.5.0/24   |
+-----------------+                   +----------------+
```

Answer the below 4 question:

## Question 10

Is the address space public or private?

- [ ] Public
- [ ] Private
- [ ] None of the above

## Question 11

Excluding the network address, and broadcast address of each subnet, how many hosts can potentially be in the whole network?

- [ ] 256 - 6 (network and broadcast addresses)
- [ ] 512 - 6 (network and broadcast addresses)
- [ ] 65536 - 6 (network and broadcast addresses)
- [ ] 214 - 6 (network and broadcast addresses)

## Question 12

What is the first address of subnet A (excluding the network and broadcast addresses)?

- [ ] `156.1.1.0`
- [ ] `156.1.1.1`
- [ ] `156.1.1.255`
- [ ] `156.1.0.0`


## Question 13

What is the broadcast address of subnet A?

- [ ] `156.1.1.0`
- [ ] `156.1.1.1`
- [ ] `156.1.1.255`
- [ ] `156.1.0.0`


Suppose the following route table of host Y:

```text
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 eth0
10.0.0.0        10.0.0.1        255.255.255.0   UG    0      0        0 eth1
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 eth0
```
Answer the below 4 questions.

## Question 14

What is the default gateway address of Y?

- [ ] `192.168.1.0`
- [ ] `192.168.1.1`
- [ ] `10.0.0.1`
- [ ] None of the above

## Question 15

What is most likely the CIDR of the subnet host Y belongs to?

- [ ] `192.168.1.0/16`
- [ ] `192.168.1.0/24`
- [ ] `10.0.0.1/24`
- [ ] `192.168.1.0/32`


## Question 16

To which network interface will the traffic to `10.0.0.234` be routed?

- [ ] `lo`
- [ ] `eth0`
- [ ] `eth1`
- [ ] None of the above

## Question 17

To which network interface will the traffic to `10.0.1.234` be routed?

- [ ] `lo`
- [ ] `eth0`
- [ ] `eth1`
- [ ] None of the above

