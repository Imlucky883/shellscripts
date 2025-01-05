#!/bin/bash
#

printf "%-30s | %-20s | %-30s\n" "CLUSTER_NAME" "STATUS" "CLUSTER_VERSION"
printf -- "-------------------------------|---------------------|----------------------------\n"

for context in $(kubectx); do
	kubectx $context >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		printf "%-30s | %-20s | %-30s $context "ERROR" : Failed to swtich"
		continue
	fi

	server_version=$(kubectl version 2>/dev/null | grep -i server | awk -F":" {'print $2'})	
	if [ -z "$server_version" ]; then
		version="NA"
		status="UNREACHABLE"
	else
		version=$server_version
		status="Active"
	fi

	if [ ${#context} -gt 30 ]; then
		context="${context:0:30}"
		# continue
	fi

	printf "%-30s | %-20s | %-30s\n" "$context" "$status" "$version"
done
