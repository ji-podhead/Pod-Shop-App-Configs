#!/bin/bash

# Überprüfen, ob genau 2 Argumente übergeben wurden
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <device_name> <api_key>"
    exit 1
fi

export VAULT_ADDR="http://127.0.0.1:8200"
device_name="$1"
api_key="$2"

# Abrufen der Geräteliste
devices=$(curl -H "Authorization: Bearer ${api_key}" https://api.tailscale.com/api/v2/tailnet/ji-podhead.github/devices)

# Verwenden von jq, um die Geräteliste zu parsen und die Adresse zu finden, die dem angegebenen device_name entspricht
matching_address=$(echo $devices | jq -c '.devices[] | select(.hostname == "'$device_name'") | .addresses[0]')

# Überprüfen, ob eine passende Adresse gefunden wurde
if [[ -z "$matching_address" ]]; then
    echo "No matching device found for name '$device_name'."
    exit 1
else
    # Drucken der gefundenen Adresse
    echo $matching_address
fi
