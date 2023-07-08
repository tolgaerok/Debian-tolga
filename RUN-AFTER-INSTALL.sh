#!/bin/bash

# Tolga Erok
# 8/7/2023
# Run this under normal user to backup APT, source list and repo into the users /home directory	

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "This script should not be run as root. Please run it as a regular user."
    exit 1
fi

SCRIPT_URL="https://github.com/tolgaerok/Debian-tolga/raw/main/SCRIPTS/BACKUP-RESTORE-APT-PACKAGES.sh"
TEMP_FILE=$(mktemp)

echo "Downloading the remote script..."
curl -sSL "$SCRIPT_URL" -o "$TEMP_FILE"

echo "Running the script..."
bash "$TEMP_FILE"

echo "Cleaning up..."
rm "$TEMP_FILE"

