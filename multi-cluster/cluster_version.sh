#!/bin/bash
#

# Print table header with aligned columns
printf "%-30s | %-20s | %-30s\n" "CLUSTER_NAME" "STATUS" "CLUSTER_VERSION"
# Print a separator line to maintain structure in output
printf -- "-------------------------------|---------------------|----------------------------\n"

# Iterate over each context in the list of available Kubernetes contexts
for context in $(kubectx); do
    # Switch to the current context, suppress any output or error messages
    kubectx $context >/dev/null 2>&1

    # Check if context switching was successful ( $? returns the exit status of the last command )
    if [ $? -ne 0 ]; then
        # If switching failed, print the error message with the context name
        printf "%-30s | %-20s | %-30s\n" "$context" "ERROR" "Failed to switch"
        continue  # Skip to the next cluster context
    fi

    # Retrieve the Kubernetes server version using `kubectl version` command,
    # suppress error output and extract only the server version using grep and awk.
    server_version=$(kubectl version 2>/dev/null | grep -i server | awk -F": " '{print $2}')

    # Check if server version is empty (which means the cluster is unreachable)
    if [ -z "$server_version" ]; then
        # If version is empty, mark it as 'UNREACHABLE' and set version as 'NA'
        version="NA"
        status="UNREACHABLE"
    else
        # Otherwise, store the retrieved server version and mark the status as 'ACTIVE'
        version=$server_version
        status="ACTIVE"
    fi

    # Check if the context name length is greater than 30 characters
    if [ ${#context} -gt 30 ]; then
        # Truncate the context name to the first 30 characters for display
        context="${context:0:30}"
    fi

    # Print the cluster information in a table-like format with aligned columns
    printf "%-30s | %-20s | %-30s\n" "$context" "$status" "$version"
done

