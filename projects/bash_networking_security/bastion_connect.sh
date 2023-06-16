#!/bin/bash

# Check if KEY_PATH environment variable is set
if [ -z "$KEY_PATH" ]; then
  echo "KEY_PATH env var is expected"
fi

# Check if the public instance IP is provided
if [ -z "$1" ]; then
  echo "Please provide bastion IP address"
  exit 5
fi

# Set variables
BASTION_IP=$1
PRIVATE_IP=$2
COMMAND=$3

# Connect to the public instance
if [ -z "$PRIVATE_IP" ]; then
  ssh -i "$KEY_PATH" ubuntu@"$BASTION_IP"
else
  # Connect to the private instance through the public instance
  if [ -z "$COMMAND" ]; then
    ssh -i "$KEY_PATH" ubuntu@"$BASTION_IP" ssh -tt -i awsKeyPair.pem ubuntu@"$PRIVATE_IP"
  else
    # Run a command on the private instance
    ssh -i "$KEY_PATH" ubuntu@"$BASTION_IP" ssh -tt -i awsKeyPair.pem ubuntu@"$PRIVATE_IP" "$COMMAND"
  fi
fi