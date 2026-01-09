#!/bin/bash

# ARCH
arch=$(uname -a)

# CPU PHYS
cpureal=$(grep "physical id" /proc/cpuinfo | wc -l)

# CPU VIRTUAL
cpuvirt=$(grep "processor" /proc/cpuinfo | wc -l)

# Disk
hdd_total=$(df -m | grep "/dev" | grep -v "/boot" | awk '{disk_t += $2} END {printf ("%.1fGb\n"), disk_t/1024}')
hdd_used=$(df -m | grep "/dev" | grep -v "/boot" | awk '{disk_u += $3} END {print disk_u/1000}')
hdd_percent=$(df -m | grep "/dev" | grep -v "/boot" | awk '{disk_u += $3} {disk_t += $2} END {printf("%d"), disk_u/di>

# CPU Load
cpu_load=$(vmstat 1 2 | tail -1 | awk '{printf $15}')
cpu_op=$(expr 100 - $cpu_load)
cpu_result=$(printf "%.1f" $cpu_op)

# Last Boot
last_boot=$(who -b | awk '$1 == "system" {print $3 " " $4}')

# LVM use
lvm=$(lsblk | grep -q "lvm" && echo "LVM used" || echo "LVM is not used")

# TCP connections
tcp=$(ss -ta | grep ESTAB | wc -l )

# users
users=$(users | wc -w)

# Network
ip=$(hostname -I)
macad=$(ip link | grep "link/ether" | awk '{print $2}')

# SUDO
sudos=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "Architecture: $arch
CPUs (Physical): $cpureal
CPUs (Virtual): $cpuvirt
Memory Usage: $used_ram/${total_ram} ($percent_ram%)
HDD Usage: $hdd_used/${hdd_total} ($hdd_percent%)
CPU Load: $cpu_result%
Last boot: $last_boot
LVM use: $lvm
TCP connections: $tcp
Users logged in: $users
Network information: IP $ip ($macad)"
Sudo commands logged: $sudos
"

