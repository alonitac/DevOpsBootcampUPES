#!/bin/bash

echo "connecting to the bastion host"

# scp -i shweta-key.pem test.txt ubuntu@184.72.28.145:~

eval $(ssh-agent -s)
ssh-add private_server_pair.pem
ssh-add shweta-key.pem

# ssh -i shweta-key.pem ubuntu@184.72.28.145 -A ubuntu@184.72.28.145 ssh ubuntu@10.0.2.254

ssh -tt -A -i shweta-key.pem ubuntu@184.72.28.145 ssh -i private_server_pair.pem ubuntu@10.0.2.254
