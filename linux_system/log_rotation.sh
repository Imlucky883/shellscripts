#!/bin/bash

# ****************************************************************

# Name : backup.sh
# Author : Laxman Patel
# Version : 0.0.1
# Description : a script to rotate log files to prevent them from growing too large.

# ****************************************************************

log_file="/path/to/logfile.log"
max_size=1000000 # 1MB
if [ $(wc -c < "$log_file") -gt $max_size ];
then
    mv "$log_file" "$log_file.old"
    touch "$log_file"
fi