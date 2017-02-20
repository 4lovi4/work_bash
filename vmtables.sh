#!/bin/sh

INT0=eth0
INT1=vmnet1
INT2=vmnet8
ADR1="172.16.1.0/24"
ADR2="192.168.9.0/24"

iptables -t filter -F FORWARD
iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING -o $INT0 -s $ADR1 -j MASQUERADE
iptables -t nat -A POSTROUTING -o $INT1 -s $ADR2 -j MASQUERADE
iptables -t nat -A POSTROUTING -o $INT0 -s $ADR2 -j MASQUERADE
iptables -t nat -A POSTROUTING -o $INT2 -s $ADR1 -j MASQUERADE

exit 0
