# Networking - DNS - multichoice questions

## Question 1

Which file is used when resolving the hostname localhost?

- [ ] /etc/inittab
- [ ] /etc/hosts
- [ ] /etc/resolv.conf
- [ ] /etc/sysconfig/localhost
- [ ] None of the above

## Question 2

Assume the following DNS records are stored in a TLD DNS server:

```text
(www.google.com, ns1.google.com, ???, 3600)
(ns1.google.com, ???, A, 60)
```

Assume the following records are stored in the google.com authoritative DNS server:

```text
(www.google.com, us-east-1.google.com, ???, 3600)
(us-east-1.google.com, 146.54.29.12, ???, 60)
```

Choose the possible input for the missing content (top-down)

- [ ] NS, 192.168.229.2, CNAME, A
- [ ] NS, 193.168.229.2, CNAME, A
- [ ] NS, 146.44.119.13, CNAME, AAAA
- [ ] A, 127.0.0.1, CNAME, A

## Question 3

Given a user who is trying to resolve `gov.org.il`. Assuming the local DNS server doesn't have the IP or the hostname of the DNS server responsible for the `.il` TLD.

Where does the local DNS server go?

- [ ] DNS Local
- [ ] DNS Root
- [ ] DNS TLD
- [ ] DNS Authoritative

## Question 4

Given the following description of each DNS server in the hierarchy, match the DNS server type according to the following order:

1. Highest level of the DNS hierarchy, knows how to reach servers responsible for a given domain (e.g., *.com, *.edu).
2. Replies to DNS query requested by a local user. Requesting all other DNS servers to answer the query on behalf of the user.
3. Responsible for a domain (e.g., *.com, *.edu); knows how to contact authoritative name servers.
4. Provides hostname to IP mappings for organization's domain.

<br>

- [ ] Root-level, local DNS, TLD DNS, authoritative DNS
- [ ] TLD DNS, Root-level, local DNS, authoritative DNS
- [ ] Root-level, local DNS, authoritative DNS, TLD DNS
- [ ] local DNS, Root-level TLD DNS, authoritative DNS

## Question 5

What are the benefits of caching in the local DNS server?

- [ ] Less load on root-level, TLD and authoritative servers
- [ ] Provides prioritized access to the root servers
- [ ] Faster replies (if there is a cache hit)
- [ ] Helps organizations to shut down their authoritative servers as the data is cached locally


Suppose that the local DNS server caches all information coming in from all root, TLD, and authoritative DNS servers for 20 seconds.  Assume also that the local cache is initially empty, that DNS query latency is 2 seconds (1 second for each side - request and response).

Consider the following DNS requests, made by some clients at the following order:

1. `google.com`
2. `icann.org`
3. `amazon.com`
4. `google.com`
5. `cnn.com`
6. `google.com`

Answer the below 3 questions

## Question 6

Which of the requests require 8 seconds to be resolved?

- [ ] 1
- [ ] 2
- [ ] 3
- [ ] 4
- [ ] 5
- [ ] 6

## Question 7

Which of the requests require 6 time units to be resolved?

- [ ] 1
- [ ] 2
- [ ] 3
- [ ] 4
- [ ] 5
- [ ] 6

## Question 8

Which of the requests require 2 time units to be resolved?

- [ ] 1
- [ ] 2
- [ ] 3
- [ ] 4
- [ ] 5
- [ ] 6

## Question 9

Choose the correct sentences regarding local DNS server:

- [ ] Records for a remote host are sometimes different from that of the authoritative server for that host.
- [ ] Can decrease the resolution time
- [ ] Holds only A records, but not NS records.
- [ ] Is only contacted by a client if that client is unable to resolve a name via recursive queries into the DNS hierarchy.

## Question 10

What is the role of an authoritative name server in the DNS?

- [ ] Is the source of truth in respect to the correct IP address of a hostname.
- [ ] Provides a list of TLD servers that can be queried to find the IP address of the hostname.
- [ ] It is a local server that caches data.
- [ ] It provides the IP address of the DNS server that can provide the hostname A record.


