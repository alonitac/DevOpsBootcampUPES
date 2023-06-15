#!/bin/bash

# Return -> Exit Status 5
if [ -z "$KEY_PATH" ]; then
    echo "KEY_PATH env var is expected"
    exit 5
fi

public_instance_ip="$1"
private_instance_ip="$2"
command="$3"

# Return -> Exit status 5 
if [ -z "$public_instance_ip" ]; then
    echo "Please provide bastion IP address"
    exit 5
fi

if [ -z "$private_instance_ip" ]; then
# For connecting to just public instance 
   	ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip"
elif [ -z "$command" ]; then
# For connecting to private instance(via bastion host)
    ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" ssh -t -t -i "~/new_key" ubuntu@"$private_instance_ip"
else 
# For connecting to private instance(via bastion host) and execute a command
	ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" ssh -t -t -i "~/new_key" ubuntu@"$private_instance_ip" "$command"
fi