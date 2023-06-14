#!/bin/bash -x

# Step 1 - Client Hello (Client -> Server)
RESPONSE=$(curl -X POST -H "Content-Type: application/json" -d '{
   "version": "1.3",
   "ciphersSuites": ["TLS_AES_128_GCM_SHA256", "TLS_CHACHA20_POLY1305_SHA256"],
   "message": "Client Hello"
}' http://16.170.234.56:8080/clienthello)

# Step 2 - Server Hello (Server -> Client)
SESSION_ID=$(echo "$RESPONSE" | jq -r '.sessionID')
SERVER_CERT=$(echo "$RESPONSE" | jq -r '.serverCert')

# Step 3 - Server Certificate Verification
CERT_CA_AWS=$(wget -qO- https://devops-feb23.s3.eu-north-1.amazonaws.com/cert-ca-aws.pem)

VERIFICATION=$(echo "$SERVER_CERT" | openssl verify -CAfile <(echo "$CERT_CA_AWS") -verbose)
if [[ $VERIFICATION != *": OK"* ]]; then
  echo "Server Certificate is Invalid"
  exit 5
fi

# Step 4 - Client-Server master-key exchange
openssl rand -out masterKey.txt -base64 32
MASTER_KEY=$(cat masterKey.txt)
ENCRYPTED_MASTER_KEY=$(echo "$MASTER_KEY" | openssl smime -encrypt -aes-256-cbc -outform DER <(echo "$SERVER_CERT") | base64 -w 0)

# Step 5 - Server verification message
RESPONSE=$(curl -X POST -H "Content-Type: application/json" -d '{
  "sessionID": "'"$SESSION_ID"'",
  "masterKey": "'"$ENCRYPTED_MASTER_KEY"'",
  "sampleMessage": "Hi server, please encrypt me and send to client!"
}' http://16.170.234.56:8080/keyexchange)

# Step 6 - Client verification message
echo "$RESPONSE" | jq -r '.encryptedSampleMessage' > encSampleMsg.txt
cat encSampleMsg.txt | base64 -d > encSampleMsgReady.txt

decrypted_sample_msg=$(openssl enc -d -aes-256-cbc -pbkdf2 -kfile masterKey.txt -in encSampleMsgReady.txt)

if [ "$decrypted_sample_msg" != "Hi server, please encrypt me and send to client!" ]; then
  echo "Server symmetric encryption using the exchanged master-key has failed."
  exit 6
else
  echo "Client-Server TLS handshake has been completed successfully"
fi
