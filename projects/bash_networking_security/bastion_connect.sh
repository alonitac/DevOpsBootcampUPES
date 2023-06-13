#!/bin/bash

# Check if KEY_PATH environment variable is set
if [[ -z "$KEY_PATH" ]]; then
  echo "KEY_PATH env var is expected"
  exit 5
fi

# Check the number of arguments
if [[ $# -eq 0 ]]; then
  echo "Please provide bastion IP address"
  exit 5
fi

# Set the SSH key path
SSH_KEY="-i $KEY_PATH"

# Check the number of arguments and build the SSH command accordingly
if [[ $# -eq 1 ]]; then
  # Connect to the public instance
  ssh $SSH_KEY ubuntu@"$1"
elif [[ $# -eq 2 ]]; then
  # Connect to the private instance using the public instance as a jump host
  ssh $SSH_KEY -J ubuntu@"$1" ubuntu@"$2"
else
  # Run a command in the private machine using the public instance as a jump host
  PUBLIC_INSTANCE_IP="$1"
  PRIVATE_INSTANCE_IP="$2"
  shift 2
  ssh $SSH_KEY -J ubuntu@"$PUBLIC_INSTANCE_IP" ubuntu@"$PRIVATE_INSTANCE_IP" "$@"
fi
