#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Ubuntu/Debian
if [ -f /etc/ufw/ufw.conf ]; then
    systemctl disable ufw
    systemctl stop ufw
fi

# Fedora/CentOS
if [ -f /usr/lib/firewalld ]; then
    systemctl disable firewalld
    systemctl stop firewalld
fi

# Arch Linux
if [ -f /usr/lib/iptables ]; then
    systemctl disable iptables
    systemctl stop iptables
fi

# OpenSUSE
if [ -f /usr/sbin/SuSEfirewall2 ]; then
    systemctl disable SuSEfirewall2
    systemctl stop SuSEfirewall2
fi

# OpenBSD
if [ -f /etc/rc.conf ]; then
    sysctl net.inet.ip.fw.enable=0
fi

# MacOS
if [ -f /Library/Preferences/com.apple.alf.plist ]; then
    /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off
fi

# Check if firewalls are disabled
if [[ $? -eq 0 ]]; then
   echo "Firewall is now disabled"
else
   echo "An error occurred while trying to disable the firewall"
fi
