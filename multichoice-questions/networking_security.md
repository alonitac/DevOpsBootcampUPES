# Networking - security - multichoice questions

### Question 1

Consider the following handshake process:

- [ ] Server sends a certificate to the client.
- [ ] Client generates public-private key pair.
- [ ] Client encrypts the master-key with the generated public key.
- [ ] Client sends the encrypted master-key to the server.

What is wrong with the described handshake?

- [ ] The sent data is not encrypted
- [ ] Server can not decrypt the encrypted master-key
- [ ] The client should use an HTTPS to send the data to the server
- [ ] Client should verify the server certificate
- [ ] Data integrity was broken

### Question 2

Self-signed certificate are useful for:

- [ ] Issue certificates for organization’s local domain (e.g. testing.testenv.cooperation)
- [ ] Using for the unsecured HTTP protocol
- [ ] Using when the server asks for a certificate from the client
- [ ] Creating a CSR for Certificate Authority

### Question 3

Choose the correct sentences:

- [ ] In public key encryption, the same key is used for encrypt and decrypt
- [ ] In public key encryption, the message is encrypted using sender private key
- [ ] In public key encryption, the message is encrypted using sender public key
- [ ] In public key encryption, the message is encrypted using the recipient’s public key
- [ ] In public key encryption, the message is encrypted using the recipient’s private key
- [ ] In public key encryption, the message is decrypted using the recipient’s private key
- [ ] In public key encryption, the message is decrypted using the recipient’s public key
- [ ] In public key encryption, the message is decrypted using sender private key
- [ ] In public key encryption, the message is decrypted using sender public key
- [ ] It is impossible to encrypt using the public key and decrypt using the private key
- [ ] It is impossible to encrypt using the private key and decrypt using the public key

### Question 4

Which of the following properties of hash function is violated for the below hash function?

```text
f(x) = x + 5

E.g.
f(4) = 9
f(7) = 12
```

- [ ] Deterministic
- [ ] One-way function
- [ ] Uniform distribution
- [ ] Small input changes, significant hash changes

### Question 5

When data is encrypted using a private key:

- [ ] Everyone can decrypt  it
- [ ] No one can decrypt it
- [ ] Only the public key owner can decrypt it
- [ ] Only certificate authority can decrypt it

### Question 6

In typical client-server communication (choose all the correct sentences):

- [ ] CA signs on the client’s public-key
- [ ] CA signs on the server’s public-key
- [ ] The public key of CA should reside in the client’s machine
- [ ] The private key of CA should reside in the client’s machine

### Question 7

Consider the below encryption scheme, which make Certificate authority redundant:

- [ ] Alice encrypts her public key using her own private key
- [ ] Alice sends the encrypted content to Bob
- [ ] Bob decrypt Alice’s message using her public key
- [ ] Bob generates a random symmetric key, decrypt it using Alice’s public key, and sends to Alice

What is the first step that can be intruded by Eve:

- [ ] 1
- [ ] 2
- [ ] 3
- [ ] 4
- [ ] None of the above, the scheme is ok!

### Question 8

In order to verify the authenticity of messages from Alice, Bob basically needs:

- [ ] Alice’s private key
- [ ] Alice’s public key
- [ ] Both public and private keys of Alice
- [ ] Bob’s own public key

### Question 9

Consider the below **authenticity** scheme:

- [ ] Alice creates a plaintext file
- [ ] Alice signs the plaintext file using her own public key
- [ ] Alice sends the signature along with the original plaintext
- [ ] Bob verify the message sent by Alice using Alice’s public key

What is wrong in the above scheme?

- [ ] Alice should send only the signature, not the original plaintext
- [ ] Bob needs Alice’s public key in order to decrypt the signature, which should be kept privately in Alice’s machine.
- [ ] Alice should sign using her own private key
- [ ] Alice should sign using Bob’s public key

### Question 10

Assume message.txt is a file containing plaintext message from Alice, and signature.txt is a valid signature of messages.txt, signed by Alice’s private key.

What is wrong in the below command, ran in Bob’s machine:

```bash
openssl dgst -sha256 -verify private.key -signature signature.txt message.txt
```

- [ ] The sha256 cannot be used to verify message authenticity
- [ ] The verification should be done using Alice’s public key
- [ ] The command encrypts the message in message.txt
- [ ] Bob doesn’t have Alice’s private  key on her own machine. Thus Alice should send it to him using an encrypted channel. 


