#!/bin/bash

COMMAND=$3


# Check if the KEY_PATH environment variable is set 
if [ -z "$KEY_PATH" ]; then
  echo "KEY_PATH env var is expected"
  exit 5
fi 

# Check if the public instance IP is provided 
if [ -z "$1" ]; then 
  echo "Please provide bastion IP address"
  exit 5
fi 

# If both public and private instance IPs are provided, connect to the
private instance via the public instance 
if [ -n $2" ]; then 
  ssh -i "$KEY_PATH" ubuntu@"$1" ssh -i "curr_key.pem" ubuntu@"$2" "$COMMAND"

# Otherwise, connect to the public instance 
else 
  ssh -i "$KEY_PATH" ubuntu@"$1"
fi
