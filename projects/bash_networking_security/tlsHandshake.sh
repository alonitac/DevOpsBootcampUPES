#!/bin/bash

# Step 1 - Send Client Hello request and parse Server Hello response
client_hello='{
  "version": "1.3",
  "ciphersSuites": [
    "TLS_AES_128_GCM_SHA256",
    "TLS_CHACHA20_POLY1305_SHA256"
  ],
  "message": "Client Hello"
}'

server_hello=$(curl -X POST -H "Content-Type: application/json" -d "$client_hello" http://server.example.com/clienthello)
version=$(echo "$server_hello" | jq -r '.version')
cipher_suite=$(echo "$server_hello" | jq -r '.cipherSuite')
session_id=$(echo "$server_hello" | jq -r '.sessionID')
server_cert=$(echo "$server_hello" | jq -r '.serverCert')

# Step 2 - Verify the server certificate

wget -O cert-ca-aws.pem https://devops-feb23.s3.eu-north-1.amazonaws.com/cert-ca-aws.pem
openssl verify -CAfile cert-ca-aws.pem cert.pem
if [[ $? -ne 0 ]]; then
  echo "Server Certificate is invalid."
  exit 5
fi

# Step 3 - Generate master key and encrypt it with the server certificate

master_key=$(openssl rand -base64 32)
echo "$master_key" > master_key.txt
encrypted_master_key=$(openssl smime -encrypt -aes-256-cbc -in master_key.txt -outform DER "$server_cert" | base64 -w 0)

# Step 4 - Send encrypted master key to server

key_exchange='{
  "sessionID": "'"$session_id"'",
  "masterKey": "'"$encrypted_master_key"'",
  "sampleMessage": "Hi server, please encrypt me and send to client!"
}'

key_exchange_response=$(curl -X POST -H "Content-Type: application/json" -d "$key_exchange" http://server.example.com/keyexchange)
encrypted_sample_message=$(echo "$key_exchange_response" | jq -r '.encryptedSampleMessage')

# Step 5 - Decrypt and verify the sample message

echo "$encrypted_sample_message" | base64 -d > encSampleMsgReady.txt
decrypted_sample_message=$(openssl enc -d -aes-256-cbc -in encSampleMsgReady.txt -pass file:master_key.txt)
if [[ "$decrypted_sample_message" != "Hi server, please encrypt me and send to client!" ]]; then
  echo "Server symmetric encryption using the exchanged master-key has failed."
  exit 6
fi

# Step 6 - Handshake completed successfully

echo "Client-Server TLS handshake has been completed successfully"
