# install iperf
apt install iperf tc

# create a namespace for each network interface
ip netns add ns1
ip netns add ns2

# create a network interface named eth0 in both ns1 and ns2
ip link add name eth0 netns ns1 type veth  peer name eth0 netns ns2

# assign an IP for each network interface
ip netns exec ns1 ip addr add 10.0.0.0/24 dev eth0
ip netns exec ns2 ip addr add 10.0.1.0/24 dev eth0

# enable the network interfaces, as well as the loopback interface for in each namespace
ip netns exec ns1 ip link set eth0 up
ip netns exec ns1 ip link set lo up
ip netns exec ns2 ip link set lo up
ip netns exec ns2 ip link set eth0 up

# Add a route from ns1 to ns2 and vice versa, so the interfaces could talk to each other
ip netns exec ns1 ip route add 10.0.0.0/24 dev eth0
ip netns exec ns2 ip route add 10.0.1.0/24 dev eth0

# Run a simple server bounded to the interface of ns2
ip netns exec ns2 iperf -s



ip netns exec ns1 tc qdisc add dev eth0 root tbf rate 1mbit burst 32kbit latency 400ms
