#!/bin/bash

IPADDRESS=54.160.100.250
# Step 1: Client Hello
client_hello=$(curl -s -X POST -H "Content-Type: application/json" -d '{
   "version": "1.3",
   "ciphersSuites": [
      "TLS_AES_128_GCM_SHA256",
      "TLS_CHACHA20_POLY1305_SHA256"
   ],
   "message": "Client Hello"
}' http://$IPADDRESS:8080/clienthello)

# Step 2: Server Hello
version=$(echo "$client_hello" | jq -r '.version')
cipher_suite=$(echo "$client_hello" | jq -r '.cipherSuite')
session_id=$(echo "$client_hello" | jq -r '.sessionID')
server_cert=$(echo "$client_hello" | jq -r '.serverCert')

# Step 3: Server Certificate Verification
wget -q https://devops-feb23.s3.eu-north-1.amazonaws.com/cert-ca-aws.pem
openssl verify -CAfile cert-ca-aws.pem <<< "$server_cert"
verification_result=$?

if [ $verification_result -ne 0 ]; then
  echo "Server Certificate is invalid."
  exit 5
fi

# Step 4: Client-Server master-key exchange
master_key=$(openssl rand -base64 32)
encrypted_master_key=$(echo "$master_key" | openssl smime -encrypt -aes-256-cbc -binary -outform DER cert.pem | base64 -w 0)

# Step 5: Server verification message
server_verification_msg=$(curl -s -X POST -H "Content-Type: application/json" -d '{
  "sessionID": "'"$session_id"'",
  "masterKey": "'"$encrypted_master_key"'",
  "sampleMessage": "Hi server, please encrypt me and send to client!"
}' http://$IPADDRESS:8080/keyexchange)

encrypted_sample_msg=$(echo "$server_verification_msg" | jq -r '.encryptedSampleMessage')

# Step 6: Client verification message
decrypted_sample_msg=$(echo "$encrypted_sample_msg" | base64 -d | openssl enc -d -aes-256-cbc -pbkdf2 -pass pass:"$master_key" -md sha256)

if [ "$decrypted_sample_msg" != "Hi server, please encrypt me and send to client!" ]; then
  echo "Server symmetric encryption using the exchanged master-key has failed."
  exit 6
fi

echo "Client-Server TLS handshake has been completed successfully"
