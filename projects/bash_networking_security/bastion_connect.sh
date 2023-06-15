#!/bin/bash
if [ -z "$private_instance_ip" ]; then
   	ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip"
elif [ -z "$command" ]; then
    	ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" ssh -t -t -i "$KEY_PATH" ubuntu@"$private_instance_ip"
    ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" ssh -t -t -i "~/new_key" ubuntu@"$private_instance_ip"
else 
	ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" ssh -t -t -i "$KEY_PATH" ubuntu@"$private_instance_ip" "$command"
	ssh -i "$KEY_PATH" ubuntu@"$public_instance_ip" ssh -t -t -i "~/new_key" ubuntu@"$private_instance_ip" "$command"
fi