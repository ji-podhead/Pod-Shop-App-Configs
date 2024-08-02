#!/bin/bash

# Überprüfen, ob die ISO-Datei bereits vorhanden ist
if [ ! -f "./proxmox-ve_8.2-1.iso" ]; then
    echo "ISO-Datei nicht gefunden. Lade ich herunter..."
    wget https://enterprise.proxmox.com/iso/proxmox-ve_8.2-1.iso
else
    echo "ISO-Datei bereits heruntergeladen."
fi
