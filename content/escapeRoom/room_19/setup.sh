#!/bin/bash
mkdir -p documents

# Create fake documents
echo "decoy_alpha" > documents/doc_1.txt
echo "decoy_beta" > documents/doc_2.txt
echo "decoy_gamma" > documents/doc_3.txt
echo "hash256" > documents/doc_4.txt
echo "decoy_delta" > documents/doc_5.txt
echo "decoy_epsilon" > documents/doc_6.txt
echo "decoy_zeta" > documents/doc_7.txt

# Write the checksum of the authentic document
sha256sum documents/doc_4.txt | awk '{print $1}' > authentic.sha256
