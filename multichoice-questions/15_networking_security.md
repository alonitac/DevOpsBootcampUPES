# Networking - security - multichoice questions

### Question 1

Consider the following handshake process:

1. Server sends a certificate to the client.
2. Client generates public-private key pair.
3. Client encrypts the master-key with the generated public key.
4. Client sends the encrypted master-key to the server.

What is wrong with the described handshake?

1. [ ] The sent data is not encrypted
2. [ ] Server can not decrypt the encrypted master-key
3. [ ] The client should use an HTTPS to send the data to the server
4. [ ] Client should verify the server certificate
5. [ ] Data integrity was broken

### Question 2

Self-signed certificate are useful for:

1. [ ] Issue certificates for organization’s local domain (e.g. testing.testenv.cooperation)
2. [ ] Using for the unsecured HTTP protocol
3. [ ] Using when the server asks for a certificate from the client
4. [ ] Creating a CSR for Certificate Authority

### Question 3

Choose the correct sentences:

1. [ ] In public key encryption, the same key is used for encrypt and decrypt
2. [ ] In public key encryption, the message is encrypted using sender private key
3. [ ] In public key encryption, the message is encrypted using sender public key
4. [ ] In public key encryption, the message is encrypted using the recipient’s public key
5. [ ] In public key encryption, the message is encrypted using the recipient’s private key
6. [ ] In public key encryption, the message is decrypted using the recipient’s private key
7. [ ] In public key encryption, the message is decrypted using the recipient’s public key
8. [ ] In public key encryption, the message is decrypted using sender private key
9. [ ] In public key encryption, the message is decrypted using sender public key
10. [ ] It is impossible to encrypt using the public key and decrypt using the private key
11. [ ] It is impossible to encrypt using the private key and decrypt using the public key

### Question 4

Which of the following properties of hash function is violated for the below hash function?

```text
f(x) = x + 5

E.g.
f(4) = 9
f(7) = 12
```

1. [ ] Deterministic
2. [ ] One-way function
3. [ ] Uniform distribution
4. [ ] Small input changes, significant hash changes

### Question 5

When data is encrypted using a private key:

1. [ ] Everyone can decrypt  it
2. [ ] No one can decrypt it
3. [ ] Only the public key owner can decrypt it
4. [ ] Only certificate authority can decrypt it

### Question 6

In typical client-server communication (choose all the correct sentences):

1. [ ] CA signs on the client’s public-key
2. [ ] CA signs on the server’s public-key
3. [ ] The public key of CA should reside in the client’s machine
4. [ ] The private key of CA should reside in the client’s machine

### Question 7

Consider the below encryption scheme, which make Certificate authority redundant:

1. Alice encrypts her public key using her own private key
2. Alice sends the encrypted content to Bob
3. Bob decrypt Alice’s message using her public key
4. Bob generates a random symmetric key, decrypt it using Alice’s public key, and sends to Alice

What is the first step that can be intruded by Eve:

1. [ ] 1
2. [ ] 2
3. [ ] 3
4. [ ] 4
5. [ ] None of the above, the scheme is ok!

### Question 8

In order to verify the authenticity of messages from Alice, Bob basically needs:

1. [ ] Alice’s private key
2. [ ] Alice’s public key
3. [ ] Both public and private keys of Alice
4. [ ] Bob’s own public key

### Question 9

Consider the below **authenticity** scheme:

1. Alice creates a plaintext file
2. Alice signs the plaintext file using her own public key
3. Alice sends the signature along with the original plaintext
4. Bob verify the message sent by Alice using Alice’s public key

What is wrong in the above scheme?

1. [ ] Alice should send only the signature, not the original plaintext
2. [ ] Bob needs Alice’s public key in order to decrypt the signature, which should be kept privately in Alice’s machine.
3. [ ] Alice should sign using her own private key
4. [ ] Alice should sign using Bob’s public key

### Question 10

Assume message.txt is a file containing plaintext message from Alice, and signature.txt is a valid signature of messages.txt, signed by Alice’s private key.

What is wrong in the below command, ran in Bob’s machine:

```bash
openssl dgst -sha256 -verify private.key -signature signature.txt message.txt
```

1. [ ] The sha256 cannot be used to verify message authenticity
2. [ ] The verification should be done using Alice’s public key
3. [ ] The command encrypts the message in message.txt
4. [ ] Bob doesn’t have Alice’s private  key on her own machine. Thus Alice should send it to him using an encrypted channel. 


