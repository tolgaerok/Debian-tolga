#!/bin/bash

# Tolga Erok
# 10/7/2023
# Check if systemd is installed, enabled and activate remote-fs for automounting their fstab

# Check if systemd is installed
if ! command -v systemctl >/dev/null 2>&1; then
    echo -e "\n\e[1m\e[34mSystemd is not installed.\e[0m"
    sleep 3

    # Check if the system is Debian-based
    if command -v apt-get >/dev/null 2>&1; then
         echo -e " \n\e[1m\e[93mInstalling ...\e[0m\e[1msystemd\e[0m\n"
        sudo apt-get update
        sudo apt-get install systemd -y
        echo -e "\e[1m\e[34mSystemd is installed.\e[0m"
        sleep 3
    else
        echo -e "\e\n[33mUnsupported distribution. Cannot install systemd."
        sleep 3
    fi
fi

# Check if remote-fs.target is installed
if ! systemctl is-active remote-fs.target >/dev/null 2>&1; then
    echo -e "\e\n[33mRemote File Systems target (remote-fs.target) is not enabled and started.\e[0m"
    # Enable and start remote-fs.target
    echo "Enabling and starting remote-fs.target..."
    sudo systemctl enable remote-fs.target
    sudo systemctl start remote-fs.target
    echo "Remote File Systems target has been enabled and started."
    sleep 3
else
    echo -e "\e\n[1m\e[34mRemote File Systems target (remote-fs.target) is already installed and active."
    sleep 4
fi
