#!/bin/bash

# Tolga Erok
# 10/7/2023
# Check if systemd is installed, enabled and activate remote-fs for automounting their fstab

# Check if systemd is installed
if ! command -v systemctl >/dev/null 2>&1; then
    echo "Systemd is not installed."

    # Check if the system is Debian-based
    if command -v apt-get >/dev/null 2>&1; then
        echo "Installing systemd..."
        sudo apt-get update
        sudo apt-get install systemd -y
        echo "Systemd has been installed."
    else
        echo "Unsupported distribution. Cannot install systemd."
        exit 1
    fi
fi

# Check if remote-fs.target is installed
if ! systemctl is-active remote-fs.target >/dev/null 2>&1; then
    echo "Remote File Systems target (remote-fs.target) is not installed."

    # Enable and start remote-fs.target
    echo "Enabling and starting remote-fs.target..."
    sudo systemctl enable remote-fs.target
    sudo systemctl start remote-fs.target
    echo "Remote File Systems target has been enabled and started."
else
    echo "Remote File Systems target (remote-fs.target) is already installed and active."
fi
