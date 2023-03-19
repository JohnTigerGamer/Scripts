#!/bin/bash

# Author: Nisrin Ahmed aka Wh1teDrvg0n

  # El comando hay que rellenarlo de la siguiente maner
  # sudo ./safevpn-thm.sh [ip de TryHackMe]

  # IPv4 flush
  sudo iptables -P INPUT ACCEPT
  sudo iptables -P FORWARD ACCEPT
  sudo iptables -P OUTPUT ACCEPT
  sudo iptables -t nat -F
  sudo iptables -t mangle -F
  sudo iptables -F
  sudo iptables -X
  sudo iptables -Z

  # IPv6 flush
  sudo ip6tables -P INPUT DROP
  sudo ip6tables -P FORWARD DROP
  sudo ip6tables -P OUTPUT DROP
  sudo ip6tables -t nat -F
  sudo ip6tables -t mangle -F
  sudo ip6tables -F
  sudo ip6tables -X
  sudo ip6tables -Z

  # Ping machine
  sudo iptables -A INPUT -p icmp -i tun0 -s $1 --icmp-type echo-request -j ACCEPT
  sudo iptables -A INPUT -p icmp -i tun0 -s $1 --icmp-type echo-reply -j ACCEPT
  sudo iptables -A INPUT -p icmp -i tun0 --icmp-type echo-request -j DROP  
  sudo iptables -A INPUT -p icmp -i tun0 --icmp-type echo-reply -j DROP
  sudo iptables -A OUTPUT -p icmp -o tun0 -d $1 --icmp-type echo-reply -j ACCEPT
  sudo iptables -A OUTPUT -p icmp -o tun0 -d $1 --icmp-type echo-request -j ACCEPT
  sudo iptables -A OUTPUT -p icmp -o tun0 --icmp-type echo-request -j DROP
  sudo iptables -A OUTPUT -p icmp -o tun0 --icmp-type echo-reply -j DROP

  # Allow VPN connection only from machine
  sudo iptables -A INPUT -i tun0 -p tcp -s $1 -j ACCEPT
  sudo iptables -A OUTPUT -o tun0 -p tcp -d $1 -j ACCEPT
  sudo iptables -A INPUT -i tun0 -p udp -s $1 -j ACCEPT
  sudo iptables -A OUTPUT -o tun0 -p udp -d $1 -j ACCEPT
  sudo iptables -A INPUT -i tun0 -j DROP
  sudo iptables -A OUTPUT -o tun0 -j DROP
  
