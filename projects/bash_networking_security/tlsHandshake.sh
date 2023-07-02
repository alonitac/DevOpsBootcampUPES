#!/bin/bash
# author: hwisdom/amank

PUBLIC_INSTANCE_IP=16.171.41.57
CERT_CA_AWS_URL=https://devops-feb23.s3.eu-north-1.amazonaws.com/cert-ca-aws.pem

# Send a Client Hello message to port 8080 on the server
# Store the Server Hello (cURL response) for effective use
SERVER_HELLO=$(curl -X POST -H "Content-Type: application/json" -d '{
   "version": "1.3",
   "ciphersSuites": [
      "TLS_AES_128_GCM_SHA256",
      "TLS_CHACHA20_POLY1305_SHA256"
   ], 
   "message": "Client Hello"
 }' "$PUBLIC_INSTANCE_IP":8080/clienthello)

# Store the Session ID
SESSION_ID=$(echo "$SERVER_HELLO" | jq -r '.sessionID')

# Store the certificate file
echo "$SERVER_HELLO" | jq -r '.serverCert' > ./cert.pem

# Verify the certificate 
wget "$CERT_CA_AWS_URL" -O cert-ca-aws.pem
OUTPUT=$(openssl verify -CAfile cert-ca-aws.pem cert.pem)

# Check if the certificate was verified successfully
if [[ $OUTPUT == *"OK"* ]]; then
  echo "$OUTPUT"
else
  echo "Server Certificate is invalid."
  exit 5
fi

# Generate a  32-byte random string encoded in Base64 
openssl rand -base64 32 > master_key 

# Store the master key
MASTER_KEY=$(cat master_key)

# Encrypt the master key with server certificate
ENCRYPTED_MASTER_KEY=$(openssl smime -encrypt -aes-256-cbc -in master_key -outform DER cert.pem | base64 -w 0)

# Send the encrypted master key to the server
SERVER_RESPONSE=$(curl -X POST -H "Content-Type: application/json" -d '{
    "sessionID": "'"$SESSION_ID"'",
    "masterKey": "'"$ENCRYPTED_MASTER_KEY"'",
    "sampleMessage": "Hi server, please encrypt me and send to client!"
}' "$PUBLIC_INSTANCE_IP:8080/keyexchange")

# Store the encrypted message returned by the server
ENCRYPTED_SAMPLE_MESSAGE=$(echo "$SERVER_RESPONSE" | jq -r '.encryptedSampleMessage')

# Encode the encrypted sample message to binary
echo "$ENCRYPTED_SAMPLE_MESSAGE" | base64 -d > encryptedMessage.txt

# Decrypt the message
DECRYPTED_SAMPLE_MESSAGE=$(openssl enc -d -aes-256-cbc -pbkdf2 -in encryptedMessage.txt -k "$MASTER_KEY")

# Check if the decryption was successful
# Compare decrypted message with the original sample message
if [ "$DECRYPTED_SAMPLE_MESSAGE" != "Hi server, please encrypt me and send to client!" ]; then
  echo "Server symmetric encryption using the exchanged master-key has failed."
  exit 6
fi

echo "Decrypted Message: $DECRYPTED_SAMPLE_MESSAGE"
echo "Client-Server TLS handshake has been completed successfully."
