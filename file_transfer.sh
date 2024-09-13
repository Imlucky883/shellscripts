#!/bin/bash

# ****************************************************************

# Name : backup.sh
# Author : Laxman Patel
# Version : 0.0.1
# Description : a script to transfer files securely between servers using SCP or SFTP.

# ****************************************************************

source_file="/path/to/source/file"
destination_server="user@hostname:/path/to/destination/"
scp "$source_file" "$destination_server"