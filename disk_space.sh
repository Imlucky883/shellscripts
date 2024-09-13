#!/bin/bash

# ****************************************************************

# Name : backup.sh
# Author : Laxman Patel
# Version : 0.0.1
# Description : a script to monitor the disk space

# ****************************************************************

threshold=90
disk_usage=$(
    df -h | grep "/dev/sda1" | awk
    '{print $5}' | tr -d '%'
)
if [ "$disk_usage" -gt "$threshold" ]; then
    echo "Disk space usage exceeded $threshold%"
# Send alert here
fi
