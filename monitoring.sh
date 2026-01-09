#!/bin/bash

# ARCH
arch=$(uname -a)

# CPU PHYS
cpureal=$(grep "physical id" /proc/cpuinfo | wc -l)

# CPU VIRTUAL
cpuvirt=$(grep "processor" /proc/cpuinfo | wc -l)

# Memory
total_ram=$(free --mega | awk '$1 == "Mem:" {print $2}')
used_ram=$(free --mega | awk '$1 == "Mem:" {print $3}')
percent_ram=$(free --mega | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

# Disk
hdd_total=$(df -m | grep "/dev" | grep -v "/boot" | awk '{disk_t += $2} END {printf ("%.1fGb\n"), disk_t/1024}')
hdd_used=$(df -m | grep "/dev" | grep -v "/boot" | awk '{disk_u += $3} END {print disk_u/1000}')
hdd_percent=$(df -m | grep "/dev" | grep -v "/boot" | awk '{disk_u += $3} {disk_t += $2} END {printf("%d"), disk_u/di>

# CPU Load
cpu_load=$(vmstat 1 2 | tail -1 | awk '{printf $15}')
cpu_op=$(expr 100 - $cpu_load)
cpu_result=$(printf "%.1f" $cpu_op)

wall " Architecture: $arch
CPUs (Physical): $cpureal
CPUs (Virtual): $cpuvirt
Memory Usage: $used_ram/${total_ram} ($percent_ram%)
HDD Usage: $hdd_used/${hdd_total} ($hdd_percent%)
CPU Load: $cpu_result%"
