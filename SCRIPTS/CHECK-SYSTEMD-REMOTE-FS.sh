#!/bin/bash

# Tolga Erok
# 10/7/2023
# Check if systemd is installed, enabled and activate remote-fs for automounting their fstab

echo -e "\n\e[1m\e[93mActivating systemd checker ...\e[0m"

# Check if systemd is installed
if ! command -v systemctl >/dev/null 2>&1; then
    echo -e "\n\e[1m\e[34mSystemd is not installed.\e[0m"
    sleep 3

    # Check if the system is Debian-based
    if command -v apt-get >/dev/null 2>&1; then
        echo -e "\n\e[1m\e[93mInstalling systemd...\e[0m"
        sudo apt-get update
        sudo apt-get install systemd -y
        echo -e "\n\e[1m\e[34mSystemd is installed.\e[0m"
        sleep 3
    else
        echo -e "\n\e[33mUnsupported distribution. Cannot install systemd.\e[0m"
        sleep 3
    fi
fi

# Check if remote-fs.target is enabled and started
if ! systemctl is-active remote-fs.target >/dev/null 2>&1; then
    echo -e "\n\e[33mRemote File Systems target (remote-fs.target) is not enabled and started.\e[0m"
    # Enable and start remote-fs.target
    echo -e "\nEnabling and starting remote-fs.target..."
    sudo systemctl enable remote-fs.target
    sudo systemctl start remote-fs.target
    echo -e "\nRemote File Systems target has been enabled and started."
    sleep 3
else
    echo -e "\n\e[1m\e[34mRemote File Systems target (remote-fs.target) is already installed and active.\e[0m"
    sleep 4
fi
