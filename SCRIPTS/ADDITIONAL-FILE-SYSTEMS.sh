#!/bin/bash

# My personal debian 12 installer, KDE PLASMA
# Tolga Erok 
# 28/6/2023

# Install Linux Firmware and base packages:
clear
echo -e "\n\e[34mInstall Linux Firmware and base packages\e[0m"
sudo apt install -y firmware-linux firmware-linux-nonfree firmware-misc-nonfree linux-headers-$(uname -r) dkms
sleep 3

# Support for additional file systems:
filesystem_packages=(
    btrfs-progs exfatprogs f2fs-tools hfsprogs hfsplus jfsutils lvm2 nilfs-tools
    reiserfsprogs reiser4progs udftools xfsprogs disktype
)

filesystem_explanations=(
    "btrfs-progs              : Tools for managing Btrfs file systems."
    "exfatprogs               : Utilities for exFAT file system."
    "f2fs-tools               : Utilities for Flash-Friendly File System (F2FS)."
    "hfsprogs                 : Tools for HFS and HFS+ file systems."
    "hfsplus                  : Tools for HFS+ file system."
    "jfsutils                 : Utilities for JFS (Journaled File System)."
    "lvm2                     : Logical Volume Manager 2 utilities."
    "nilfs-tools              : Tools for NILFS (New Implementation of a Log-structured File System)."
    "reiserfsprogs            : Tools for ReiserFS file system."
    "reiser4progs             : Tools for Reiser4 file system."
    "udftools                 : Tools for UDF (Universal Disk Format) file system."
    "xfsprogs                 : Tools for managing XFS file systems."
    "disktype                 : Detects the content format of a disk or disk image."
)

clear

echo -e "\e[34m===============================================\e[0m"
echo -e "\e[33m Support for additional file systems installer     \e[0m"
echo -e "\e[34m===============================================\e[0m"
echo

echo -e " \e[1m\e[93mThe following packages will be installed:\e[0m"
echo

for ((i = 0; i < ${#filesystem_packages[@]}; i++)); do
   echo -e "\e[0m\e[1m- ${filesystem_explanations[i]}\e[0m"
done

echo
read -p "Do you want to proceed with the installation? (y/n): " choice

if [[ $choice =~ ^[Yy]$ ]]; then
    echo -e "\n\e[33mInstalling the packages...\e[0m"
    sudo apt install -y "${filesystem_packages[@]}"
    echo -e "\n\e[33mPackage installation completed.\e[0m"
    sleep 2
    exit 0
else
    echo "Package installation skipped."
    sleep 2
    exit 0
fi
