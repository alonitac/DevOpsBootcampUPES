#!/bin/bash
# Check if KEY_PATH environment variable exists
if [[ -z "$KEY_PATH" ]]; then
    echo "KEY_PATH env var is expected"
    exit 5
fi

# Check if the public instance IP address is provided
if [[ $# -lt 1 ]]; then
    echo "Please provide bastion IP address"
    exit 1
fi

# Connect to the private instance using the public instance as a bastion host
if [[ $# -eq 2 ]]; then
    public_instance_ip=$1
    private_instance_ip=$2

    # Connect to the private instance via the bastion host
    ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" ssh -t -t -i "/home/ubuntu/flask/key.pem" ubuntu@"$private_instance_ip"
else
    public_instance_ip=$1

    # Connect to the public instance
    ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" 
fi