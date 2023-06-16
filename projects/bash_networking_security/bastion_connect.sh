#!/bin/bash

if [[ -z "$KEY_PATH" ]]; then
  echo "KEY_PATH environment variable is not set!"
  exit 5
fi

if [[ $# -lt 1 ]]; then
  echo "KEY_PATH env var is expected"
  echo "Please provide Public Instance (Bastion) IP address"
  exit 5
fi

public_ip=$1
private_ip=$2
command="${@:3}"

if [[ -n "$private_ip" ]]; then
  ssh -t -i "$KEY_PATH" ubuntu@"$public_ip" ssh -i "new_key" ubuntu@"$private_ip" "$command"
else
  ssh -i "$KEY_PATH" ubuntu@"$public_ip" "$command"
fi