#!/bin/bash
# this is no longer needed because we use our own github server and using hook that fire before anything gets deployed



# Überprüfen, ob der Vault-Token als Argument übergeben wurde
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <VaultToken>"
    exit 1
fi

export VAULT_ADDR="http://127.0.0.1:8200"
VAULT_TOKEN="$1"
KEYFILE="key.pem"
STATE_FILE="terraform.tfstate"

echo "Decrypting state file using AES-256..."

# Login bei Vault
if ! vault login "$VAULT_TOKEN"; then
    echo "Login to Vault failed."
    exit 1
fi

# Holen des GitHub-Tokens aus Vault
PEM_PASSPHRASE=$(vault kv get -format=json -mount=keyvalue "terraform/github" | jq -r '.data.data.github_token' || { echo "Failed to retrieve GitHub token."; exit 1; })

# Dekodieren des verschlüsselten Terraform State-Files
if ! openssl aes-256-cbc -salt -a -d -in "$STATE_FILE.enc" -out "$STATE_FILE" -pass pass:"$PEM_PASSPHRASE" -iter 4096; then
    echo "Decryption of state file failed."
    exit 1
fi
if ! openssl aes-256-cbc -salt -a -d -in "$STATE_FILE.backup.enc" -out "$STATE_FILE".backup -pass pass:"$PEM_PASSPHRASE" -iter 4096; then
    echo "Decryption of state file failed."
    exit 1
fi
echo "State file successfully decrypted."

# Optional: Ausgabe des entschlüsselten Terraform State-Files
cat "$STATE_FILE"

# Optional: Bereinigung
# rm "$ENCRYPTED_STATE_FILE" # Kommentieren Sie diese Zeile aus, wenn Sie die Datei behalten möchten
