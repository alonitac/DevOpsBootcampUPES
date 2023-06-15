#!/bin/bash

echo "connecting to the bastion host"

# scp -i swatip-key.pem test.txt ubuntu@52.53.237.83:~

eval $(ssh-agent -s)
ssh-add private_server_pair.pem
ssh-add swatip-key.pem

# ssh -i swatip-key.pem ubuntu@52.53.237.83 -A ubuntu@52.53.237.83 ssh ubuntu@10.0.2.178

ssh -tt -A -i swatip-key.pem ubuntu@52.53.237.83 ssh -i private_server_pair.pem ubuntu@10.0.2.178


