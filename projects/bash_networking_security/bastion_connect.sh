#!/bin/bash
PUBLIC_IP=$1

PRIVATE_IP=$2

COMMAND=$3


# if the keyexists - a. if public but not private exist connect to public b. if both exist then public->private. else exit ffor bad input

if [[ -n "$KEY_PATH" ]]; then

  if [[ -n "$PUBLIC_IP" ]] && [[ ! "$PRIVATE_IP" ]]; then

    ssh -i "$KEY_PATH" "ubuntu@$PUBLIC_IP"

  fi



  if [[ -n "$PUBLIC_IP" ]] && [[ -n "$PRIVATE_IP" ]]; then

    ssh -ti "$KEY_PATH" "ubuntu@$PUBLIC_IP" "ssh -i "$KEY_PATH" 'ubuntu@$PRIVATE_IP'" "$COMMAND"

  fi

else

  echo "KEY_PATH env var is expected and must point to an existing file. try: export KEY_PATH='~/pampampam.pem' "

  exit 5

fi
 
 if [ $# -lt 1 ]; then
  echo "Please provide bastion IP address"
  exit 5
fi
