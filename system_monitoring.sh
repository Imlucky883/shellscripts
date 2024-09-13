#!/bin/bash

# ****************************************************************

# Name : backup.sh
# Author : Laxman Patel
# Version : 0.0.1
# Description : a script to monitor system resource usage and send alerts if thresholds are exceeded.

# ****************************************************************

cpu_threshold=90
mem_threshold=90
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed"s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
mem_usage=$(free | grep Mem | awk '{print $3/$2* 100.0}')

echo "Current System Time: $(date)"
echo "----------------------------------------"
echo "Resource Usage:"
echo "----------------------------------------"
echo "CPU Usage: $cpu_usage%"
echo "Memory Usage: $mem_usage%"

if (( $(echo "$cpu_usage > $cpu_threshold" | bc-l) )) || (( $(echo "$mem_usage >$mem_threshold" | bc -l) )); then
    echo "High CPU or memory usage detected!"   
fi