#!/bin/bash

# Step 1: Client Hello
client_hello='{"version": "1.3", "ciphersSuites": ["TLS_AES_128_GCM_SHA256", "TLS_CHACHA20_POLY1305_SHA256"], "message": "Client Hello"}'
response=$(curl -s -X POST -d "$client_hello" http://<public-ec2-instance-ip>:8080/clienthello)
session_id=$(echo "$response" | jq -r '.sessionID')
server_cert=$(echo "$response" | jq -r '.serverCert')

# Step 2: Server Hello
echo "Server Hello response: $response"
echo "Session ID: $session_id"
echo "$server_cert" > cert.pem

# Step 3: Server Certificate Verification
wget -q https://devops-feb23.s3.eu-north-1.amazonaws.com/cert-ca-aws.pem
openssl verify -CAfile cert-ca-aws.pem cert.pem
verification_result=$?
rm cert-ca-aws.pem

if [ $verification_result -ne 0 ]; then
  echo "Server Certificate is invalid."
  exit 5
fi

# Step 4: Client-Server master-key exchange
master_key=$(openssl rand -base64 32)
encrypted_master_key=$(echo "$master_key" | openssl smime -encrypt -aes-256-cbc -outform DER cert.pem | base64 -w 0)

# Step 5: Server verification message
key_exchange='{"sessionID": "'$session_id'", "masterKey": "'$encrypted_master_key'", "sampleMessage": "Hi server, please encrypt me and send to client!"}'
response=$(curl -s -X POST -d "$key_exchange" http://<public-ec2-instance-ip>:8080/keyexchange)
encrypted_sample_message=$(echo "$response" | jq -r '.encryptedSampleMessage')

# Step 6: Client verification message
echo "$encrypted_sample_message" | base64 -d > encSampleMsgReady.txt
decrypted_sample_message=$(openssl enc -d -aes-256-cbc -in encSampleMsgReady.txt -base64 -K "$master_key" -iv 0 -nosalt 2>/dev/null)

if [ "$decrypted_sample_message" != "Hi server, please encrypt me and send to client!" ]; then
  echo "Server symmetric encryption using the exchanged master-key has failed."
  exit 6
fi

echo "Client-Server TLS handshake has been completed successfully"
