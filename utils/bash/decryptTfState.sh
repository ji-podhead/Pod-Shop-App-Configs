#!/bin/bash

# Überprüfen, ob der Vault-Token als Argument übergeben wurde
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <VaultToken>"
    exit 1
fi

export VAULT_ADDR="http://127.0.0.1:8200"
VAULT_TOKEN="$1"
KEYFILE="key.pem"
STATE_FILE="terraform.tfstate"
echo "Encrypting state file using AES-256..."
vault login "$VAULT_TOKEN"
PEM_PASSPHRASE=$(vault kv get -format=json -mount=keyvalue "terraform/github" | jq -r '.data.data.github_token')
openssl aes-256-cbc -salt -a -e -in terraform.tfstate -out terraform.tfstate.enc -pass pass:"$PEM_PASSPHRASE" -iter 4096
openssl aes-256-cbc -salt -a -e -in terraform.tfstate.backup -out terraform.tfstate.backup.enc -pass pass:"$PEM_PASSPHRASE" -iter 4096


#openssl genrsa -aes256 -out priv.key  -passout pass:"$PEM_PASSPHRASE" 2048 
#openssl pkeyutl -encrypt -pubin -inkey priv.key -in terraform.tfstate -out terraform.tfstate.enc

#openssl rsa -in private.key -pubout -out public.key
#openssl rsautl -encrypt -pubin -inkey public.key -in terraform.tfstate -out terraform.tfstate.enc

#openssl aes-256-cbc -a -salt -pbkdf2 -in ./secrets.text -out terraform.tfstate.enc -pass pass:$ENCRYPTION_PASSWORD
#ls
#vault login "$VAULT_TOKEN"
#echo "Saving public key to Vault..."
#vault kv put secret/terraform/public-key $(cat $KEYFILE.pub) --token="$VAULT_TOKEN"
#vault kv put -mount=keyvalue secret/terraform/public-key token= "$(cat key.pem)"
#echo "Encryption complete. Encrypted state file uploaded to Vault."

# Optional: Löschen des temporären Schlüsselpaares
#rm $KEYFILE
rm "$STATE_FILE"
rm "$STATE_FILE.backup"