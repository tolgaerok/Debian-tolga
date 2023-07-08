#!/bin/bash

# My personal Debian and Ubuntu backup / restore APT packages
# Tolga Erok
# 7/7/2023
# NOTE: DO not run as sudo as it will save into root home folder. Run as normal i.e: ./BACKUP-RESTORE-APT-PACKAGES.sh
# CRITICAL: Any packages installed using a .DEB file or other source not
# included in your repositories/sources.list, must be removed from Package.list before restoring to avoid errors. These packages will need to be reinstalled manually.

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "This script should not be run as root. Please run it as a regular user."
    exit 1
fi

backup_packages() {
    echo -e "\nBacking up your package list to your home directory"
    dpkg --get-selections > ~/Package.list

    echo -e "\nBacking up the list of repositories to your home directory"
    cp /etc/apt/sources.list ~/sources.list

    echo -e "\nExporting repo keys to your home directory"
    temp_dir=$(mktemp -d)
    cp -R /etc/apt/trusted.gpg.d "$temp_dir"
    chown -R "$USER:$USER" "$temp_dir"
    rm -rf ~/Repo.keys
    mv "$temp_dir" ~/Repo.keys

    echo -e "\nBackup completed successfully."
    read -n 1 -s -r -p "Press any key to continue..."
    clear
}

# Function to restore packages from backup
restore_packages() {
    echo -e "\nRestoring repo keys from backup"
    sudo cp -R ~/Repo.keys/* /etc/apt/trusted.gpg.d/

    echo -e "\nRestoring the list of repositories from backup"
    sudo cp ~/sources.list /etc/apt/sources.list

    echo -e "\nUpdating repositories"
    sudo apt-get update

    echo -e "\nInstalling dselect (required for package restoration)"
    sudo apt-get install dselect -y

    echo -e "\nRestoring packages from the backup"
    sudo dpkg --set-selections < ~/Package.list
    sudo apt-get dselect-upgrade -y

    echo -e "\nPackage restoration completed successfully."
    read -n 1 -s -r -p "Press any key to continue..."
    clear
}

# Menu
while true; do
    clear
    echo -e "\n======================================"
    echo " Debian and Ubuntu APT Backup/Restore "
    echo "======================================"
    echo " 1. Backup installed APT packages"
    echo " 2. Restore APT packages from backup"
    echo " 3. Exit"
    echo "======================================"
    read -p "Enter your choice (1-3): " choice

    case $choice in
        1) backup_packages ;;
        2) restore_packages ;;
        3) break ;;
        *) echo "Invalid choice. Please enter a valid option (1-3)."
           read -n 1 -s -r -p "Press any key to continue..."
           clear ;;
    esac
done
