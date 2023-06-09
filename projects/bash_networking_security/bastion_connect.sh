#!/bin/bash

# Check if KEY_PATH environment variable exists
if [ -z "$KEY_PATH" ]; then
  echo "Error: KEY_PATH environment variable is not set."
  exit 5
fi

# Extract the filename from the key path
key_filename=$(basename "$KEY_PATH")

# SSH command to connect through the bastion (public instance) to the private instance
ssh_command="ssh -o ProxyCommand=\"ssh -i $key_filename -W %h:%p ec2-user@<public_instance_ip>\" -i $KEY_PATH ec2-user@<private_instance_ip>"

# Execute the SSH command
eval "$ssh_command"