#!/bin/bash

# My personal debian 12 installer, KDE PLASMA
# Tolga Erok
# 28/6/2023

clear

# Install Linux Firmware and base packages:
sudo apt install -y firmware-linux firmware-linux-nonfree firmware-misc-nonfree linux-headers-$(uname -r) dkms && clear

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
echo -e "\e[34m===============================================\e[0m"
echo -e "\e[1m\e[34m Support for additional file systems     \e[0m"
echo -e "\e[34m===============================================\e[0m"
echo

echo "The following packages will be installed:"
for ((i = 0; i < ${#filesystem_packages[@]}; i++)); do
   echo -e "\e[0m\e[1m- ${filesystem_explanations[i]}\e[0m"
done

echo
read -p "Do you want to proceed with the installation? (y/n): " choice

if [[ $choice =~ ^[Yy]$ ]]; then
    echo "Installing the packages..."
    sudo apt install -y "${filesystem_packages[@]}"
    echo "Package installation completed."
    sleep 2
    exit 0
else
    echo "Package installation skipped."
    sleep 2
    exit 0
fi
