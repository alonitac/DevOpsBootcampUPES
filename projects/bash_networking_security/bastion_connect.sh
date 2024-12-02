#!/bin/bash
#i
if [[ -z "$KEY_PATH" ]]; then
  echo "Error: KEY_PATH environment variable is not set."
  exit 5
fi

if [[ $# -lt 1 ]]; then
  echo "KEY_PATH env var is expected"
  echo "Please provide bastion IP address"
  exit 5
fi

bastion_ip=$1
private_ip=$2
command_to_run="${@:3}"

if [[ -n "$private_ip" ]]; then
  ssh -t -i "$KEY_PATH" ubuntu@"$bastion_ip" ssh -i "vidpri-key.pem" ubuntu@"$private_ip" "$command_to_run"
else
  ssh -i "$KEY_PATH" ubuntu@"$bastion_ip" "$command_to_run"
fi
