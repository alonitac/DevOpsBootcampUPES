#!/bin/bash

# Check if KEY_PATH environment variable exists
if [ -z "$KEY_PATH" ]; then
  echo "KEY_PATH environment variable is expected"
  exit 5
fi

# Check if public instance IP address is provided
if [ -z "$1" ]; then
  echo "Please provide bastion IP address"
  exit 5
fi

# Connect to the private instance via the public instance using the provided key path
if [ -z "$2" ]; then
  ssh -i "$KEY_PATH" "ubuntu@$1"
else
  ssh -i "$KEY_PATH" "ubuntu@$1" ssh "ubuntu@$2" "${@:3}"
fi
