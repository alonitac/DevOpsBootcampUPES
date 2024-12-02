#!/bin/bash

if [[ -z "$KEY_PATH" ]]; then
  echo "ERROR: KEY_PATH environment variable not set"
  exit 5
fi

if [[ $# -lt 1 ]]; then
  echo "ERROR: Insufficient arguments"
  echo "Usage: ./bastion_connect.sh <public-instance-ip> [<private-instance-ip>] [command]"
  exit 1
fi

public_ip=$1
private_ip=$2
command=$3

if [[ -z "$private_ip" ]]; then
  ssh -i "$KEY_PATH" ubuntu@"$public_ip" "$command"
else
  ssh -i "$KEY_PATH" -o ProxyCommand="ssh -i $KEY_PATH -W %h:%p ubuntu@$public_ip" ubuntu@"$private_ip" "$command"
fi
