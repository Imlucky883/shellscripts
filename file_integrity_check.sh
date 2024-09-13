#!/bin/bash

# ****************************************************************

# Name : backup.sh
# Author : Laxman Patel
# Version : 0.0.1
# Description : a script to check the integrity of files using checksums

# ****************************************************************

file="/path/to/file"
checksum=$(md5sum "$file" | awk '{print $1}')
if [ "$checksum" == "expected_checksum" ]; then
    echo "File integrity verified"
else
    echo "File integrity compromised"
fi
