#!/bin/bash

# ****************************************************************

# Name : backup.sh
# Author : Laxman Patel
# Version : 0.0.1
# Description : Create a script to automatically backup files or directories to a specified location. 

# ****************************************************************

# To check the number of arguments


backup_dir="/path/to/backup"
source_dir="/path/to/source"
timestamp=$(date +"%Y%m%d%H%M%S")
tar -czf "$backup_dir/backup_$timestamp.tar.gz""$source_dir"
