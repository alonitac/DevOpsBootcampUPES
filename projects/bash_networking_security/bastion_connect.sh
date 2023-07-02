#! /usr/bin/bash
# author: hwisdom/amank

# Check if KEY_PATH environment variable is set
if [ -z "$KEY_PATH" ]; then
  echo "KEY_PATH env var is expected"
  exit 5
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
PRIVATE_SERVER_KEY_PATH="/home/ubuntu/.ssh/hwisdom-private-server-main-key.pem"

# Connect to the public instance if no private instance IP is provided
if [ -z "$PRIVATE_IP" ]; then
  ssh -i "$_PATH" ubuntu@"$BASTION_IP"
else
  # Connect to the private instance through the public instance
  if [ -z "$COMMAND" ]; then
    ssh -i "$KEY_PATH" ubuntu@"$BASTION_IP" ssh -tt -i "$PRIVATE_SERVER_KEY_PATH" ubuntu@"$PRIVATE_IP"
  else
    # Run a command on the private instance through the public instance
    ssh -i "$KEY_PATH" ubuntu@"$BASTION_IP" ssh -tt -i "$PRIVATE_SERVER_KEY_PATH" ubuntu@"$PRIVATE_IP" "$COMMAND"
  fi
fi

