# ****************************************************************

# Name : backup.sh
# Author : Laxman Patel
# Version : 0.0.1
# Description :  a script to automate the deployment of applications or configurations to multiple servers.

# ****************************************************************

servers=("server1" "server2" "server3")
for server in "${servers[@]}"; do
    scp "app.tar.gz" "user@$server:/path/to/destination/"
    ssh "user@$server" "tar -xzvf /path/to/destination/app.tar.gz -C /path/to/app"
    # Additional deployment steps here
done

