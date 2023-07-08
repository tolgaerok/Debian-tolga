#!/bin/bash

# Tolga Erok
# 8/7/2023
# Run this under normal user to backup APT, source list and repo into the users /home directory	

SCRIPT_URL="https://github.com/tolgaerok/Debian-tolga/raw/main/SCRIPTS/BACKUP-RESTORE-APT-PACKAGES.sh"
TEMP_DIR=$(mktemp -d)

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "This script should not be run as root. Switching to a regular user..."
    USER_NAME="$(logname)"

    # Switch to a non-root user
    su -c "curl -sSL \"$SCRIPT_URL\" -o \"$TEMP_DIR/script.sh\" && chmod u+x \"$TEMP_DIR\"/* && bash \"$TEMP_DIR/script.sh\"; rm -r \"$TEMP_DIR\"" "$USER_NAME"
else
    echo "Downloading the remote script..."
    curl -sSL "$SCRIPT_URL" -o "$TEMP_DIR/script.sh"
    chmod u+x "$TEMP_DIR"/*

    echo "Running the script..."
    bash "$TEMP_DIR/script.sh"

    echo "Cleaning up..."
    rm -r "$TEMP_DIR"

    echo "Script execution completed."
fi
