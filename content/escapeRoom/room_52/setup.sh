#!/bin/bash
mkdir -p vault

# Create files (they'll be owned by root initially, then permissions will be wrong)
echo "access_level=high" > vault/access.key
echo "config_version=2" > vault/config.cfg
echo "vault_encoded_data" > vault/secret.dat

# The initEscapeRoom.sh runs as root - files owned by root by default
# Students must chown to escape:escape
chmod 644 vault/access.key vault/config.cfg vault/secret.dat
