# Networking - TCP sockets - multichoice questions

## Question 1

For a communication session between a pair of programs, which program is the client and which is the server?

- [ ] The program that initializes the TCP connection is the client
- [ ] The program that initializes the TCP connection is the server

## Question 2

In TCP/IP networking, what parameter is used to specify a particular process on a machine?

- [ ] IP address
- [ ] window size
- [ ] port number
- [ ] protocol
- [ ] None of the above

## Question 3

What file contains a catalog of well known services?

- [ ] `/etc/services`
- [ ] `/etc/protocols`
- [ ] `/usr/share/net/services`
- [ ] `/usr/share/net/protocols`
- [ ] None of the above

## Question 4

Which port number serves as a boundary between privileged and non-privileged ports?

- [ ] `25`
- [ ] `991`
- [ ] `1024`
- [ ] `6000`
- [ ] `65535`


## Question 5

If on one machine, elvis was using both the Firefox and Chrome web browsers to access the same
website, what parameter would differ for the two involved sockets?

- [ ] The client IP Address
- [ ] The server port number
- [ ] The client port number
- [ ] The server IP Address
- [ ] None of the above

## Question 6

When a socket is opened by a server and awaiting client connections, what state is the socket said
to be in?

- [ ] Waiting
- [ ] Listening
- [ ] Established
- [ ] Initialized
- [ ] None of the above

Use the following transcript to answer the next 4 questions.

```console
[elvis@station elvis]$ netstat -tuna
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address   	Foreign Address     	State
tcp   0  	0  	127.0.0.1:32768 	0.0.0.0:*           	LISTEN
tcp   0  	0  	0.0.0.0:111     	0.0.0.0:*           	LISTEN
tcp   0  	0  	0.0.0.0:6000    	0.0.0.0:*           	LISTEN
tcp   0  	0  	0.0.0.0:22      	0.0.0.0:*           	LISTEN
tcp   0  	0  	69.57.79.162:53 	0.0.0.0:*           	LISTEN
tcp   0  	0  	192.168.0.254:53	0.0.0.0:*           	LISTEN
tcp   0  	0  	127.0.0.1:53    	0.0.0.0:*           	LISTEN
tcp   0  	0  	0.0.0.0:631     	0.0.0.0:*           	LISTEN
tcp   0  	0  	127.0.0.1:25    	0.0.0.0:*           	LISTEN
tcp   0  	0  	127.0.0.1:953   	0.0.0.0:*           	LISTEN
tcp   0  	0  	127.0.0.1:6010  	0.0.0.0:*           	LISTEN
tcp   0  	0  	127.0.0.1:631   	127.0.0.1:32773     	ESTABLISHED
tcp   0  	48 	69.57.79.162:22 	66.187.233.200:35954	ESTABLISHED

[elvis@station elvis]$ grep 53 /etc/services
domain  	53/tcp       	# name-domain server
domain  	53/udp      	 
gdomap  	538/tcp      	# GNUstep distributed objects
gdomap  	538/udp      	# GNUstep distributed objects
cfengine	5308/tcp     	# CFengine
cfengine	5308/udp     	# CFengine
knetd   	2053/tcp     	# Kerberos de-multiplexor
rndc    	953/tcp      	# rndc control sockets (BIND 9)
rndc    	953/udp      	# rndc control sockets (BIND 9)
```

## Question 6

Choose the correct sentence.

- [ ] `69.57.79.162` is connected to elvis station over SSH protocol
- [ ] `66.187.233.200` is connected to elvis station over SSH protocol
- [ ] `69.57.79.162` is connected to elvis station using port 35954
- [ ] `66.187.233.200` is connected to elvis station using port 35954
- [ ] None of the above

## Question 7

How many TCP/IP clients are currently connected to services on elvis machine?

- [ ] 1
- [ ] 0
- [ ] 2
- [ ] 11
- [ ] None of the above

## Question 8

Of these, how many are on remote machines?

- [ ] 1
- [ ] 0
- [ ] 11
- [ ] 2
- [ ] None of the above


## Question 9

The three sockets bound to port 53 most likely belong to what service?

- [ ] SSH (Secure Shell)
- [ ] HTTP (Hypertext Transfer Protocol)
- [ ] FTP (File Transfer Protocol)
- [ ] DNS (Domain Name Service)
- [ ] TELNET (Telnet Service)


## Question 10

Which of the below characteristics are typically associated with a TCP socket?

- [ ] The syscall `socket(AF_INET, SOCK_DGRAM, 0)` creates the socket of type TCP.
- [ ] TCP sockets provide reliable, in-order byte-stream transfer between client and server.
- [ ] The function call `socket(AF_INET, SOCK_STREAM, 0)` creates a socket of type TCP.
- [ ] The server uses `accept()` function for incoming client connections.
- [ ] Data from multiple clients can be received on the same socket.
- [ ] When a server is contacted by a client, it creates a new server-side socket to communicate with that client.

## Question 11

In TCP, how does the server know the client IP address and the port number to reply to in response to a received message?

- [ ] Using the DNS protocol
- [ ] Every message sent by the client contains the IP number and port.
- [ ] The `accept()` syscall creates a new socket that is bound to the specific client, which is established using the IP and port number of the client.
- [ ] The server looks for the correct port number in the `/etc/services` file.

## Question 12

In UDP, how does the server know the client IP address and the port number to reply to in response to a received message?

- [ ] Using the DNS protocol
- [ ] Every message sent by the client contains the IP number and port.
- [ ] The `accept()` syscall creates a new socket that is bound to the specific client, which is established using the IP and port number of the client.
- [ ] The server looks for the correct port number in the `/etc/services` file.

## Question 13

A given server has 5 established connections bound to port 80, how many socket files the server holds?

- [ ] 5
- [ ] 6
- [ ] 1
- [ ] None of the above
