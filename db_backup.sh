#!/bin/bash

# ****************************************************************

# Name : backup.sh
# Author : Laxman Patel
# Version : 0.0.1
# Description : a script to backup a database and compress the backup file.

# ****************************************************************

db_user="username"
db_pass="password"
db_name="database_name"
backup_dir="/path/to/backup"
timestamp=$(date +"%Y%m%d%H%M%S")
mysqldump -u "$db_user" -p"$db_pass" "$db_name"| gzip > "$backup_dir/db_backup_$timestamp.sql.gz"