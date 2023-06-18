#!/bin/bash
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

# If both public and private instance IPs are provided, connect to the private instance via the public instance
if [ -n "$2" ]; then
  if ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no -i "$KEY_PATH" ubuntu@"$1" stat new_key \> /dev/null 2\>\&1; then
    PRIVATE_KEY_FILE="new_key"
  else
    PRIVATE_KEY_FILE="$KEY_PATH"
  fi

  ssh -ti "$KEY_PATH" ubuntu@"$1" ssh -i "$PRIVATE_KEY_FILE" ubuntu@"$2" "$3"

# Otherwise, connect to the public instance
else
  ssh -i "$KEY_PATH" ubuntu@"$1"
fi
