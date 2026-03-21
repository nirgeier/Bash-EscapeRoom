#!/bin/bash
# Create the keyfile with the encryption password
echo "cryptokey2024" >keyfile.txt

# Create the encrypted message file containing the password for room 46
echo "cipher99" | openssl enc -aes-256-cbc -a -pbkdf2 \
    -pass pass:cryptokey2024 >encrypted_message.enc
