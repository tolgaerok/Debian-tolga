#!/bin/bash

# My personal debian 12 backup / restore APT packages
# Tolga Erok    
# 7/7/2023
# NOTE: if SUDO is not configured, Simply use root terminal or SU. 
# CRITICAL: Any packages installed using a .DEB file or other source not
# included in your repositories/sources.list, must be removed from Package.list before restoring to avoid errors. These packages will need to be reinstalled manually. 

# Function to backup installed APT packages
backup_packages() {
    echo -e "\nBacking up your package list to your home directory"
    sudo dpkg --get-selections > ~/Package.list

    echo -e "\nBacking up the list of repositories to your home directory"
    sudo cp /etc/apt/sources.list ~/sources.list

    echo -e "\nExporting repo keys to your home directory"
    sudo apt-key exportall > ~/Repo.keys
    
    echo -e "\nBackup completed successfully."
}

# Function to restore packages from backup
restore_packages() {
    echo -e "\nRestoring repo keys from backup"
    sudo apt-key add ~/Repo.keys

    echo -e "\nRestoring the list of repositories from backup"
    sudo cp ~/sources.list /etc/apt/sources.list

    echo -e "\nUpdating repositories"
    sudo apt-get update

    echo -e "\nInstalling dselect (required for package restoration)"
    sudo apt-get install dselect -y

    echo -e "\nRestoring packages from the backup"
    sudo apt-get install $(cat ~/Package.list | awk '{print $1}')
    
    echo -e "\nPackage restoration completed successfully."
}

# Menu
while true; do
    echo -e "\n===================="
    echo " Debian 12 APT Backup/Restore "
    echo "===================="
    echo " 1. Backup installed APT packages"
    echo " 2. Restore APT packages from backup"
    echo " 3. Exit"
    read -p "Enter your choice (1-3): " choice

    case $choice in
        1) backup_packages ;;
        2) restore_packages ;;
        3) break ;;
        *) echo "Invalid choice. Please enter a valid option (1-3)." ;;
    esac
done
