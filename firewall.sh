#!/bin/sh

docker_network=$(ip -o addr show dev eth0 |
		awk '$3 == "inet" {print $4}')

iptables -F OUTPUT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -o tap0 -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT
iptables -A OUTPUT -d ${docker_network} -j ACCEPT
iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 1198 -j ACCEPT                    
iptables -A OUTPUT -p udp -m udp --dport 1198 -j ACCEPT          

iptables -A OUTPUT -j DROP

exec "$@"
