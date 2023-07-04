#!/bin/bash

# Tolga Erok    My personal debian 12 installer
# 28/6/2023

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
    echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
    exit 1
fi

username=$(id -u -n 1000)

# Update packages list and update system
apt update
apt upgrade -y

sudo apt-get install gdebi flatpak firmware-realtek bluez bluez-tools libavcodec-extra vlc samba synaptic cifs-utils gnome-software-plugin-flatpak -y
sudo apt install plocate sntp ntpdate software-properties-common terminator htop neofetch -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.sindresorhus.Caprine

# Download teamviewer
download_url="https://dl.teamviewer.com/download/linux/version_15x/teamviewer_15.43.6_amd64.deb?utm_source=google&utm_medium=cpc&utm_campaign=au%7Cb%7Cpr%7C22%7Cjun%7Ctv-core-brand-only-exact-sn%7Cfree%7Ct0%7C0&utm_content=Exact&utm_term=teamviewer&ref=https%3A%2F%2Fwww.teamviewer.com%2Fen-au%2Fdownload%2Flinux%2F%3Futm_source%3Dgoogle%26utm_medium%3Dcpc%26utm_campaign%3Dau%257Cb%257Cpr%257C22%257Cjun%257Ctv-core-brand-only-exact-sn%257Cfree%257Ct0%257C0%26utm_content%3DExact%26utm_term%3Dteamviewer"
download_location="/tmp/teamviewer_15.43.6_amd64.deb"

echo "Downloading teamviewer..."
wget -O "$download_location" "$download_url"

# Install Visual Studio Code
echo "Installing teamviwer..."
sudo dpkg -i "$download_location"
sudo apt-get install -f -y

# Cleanup
echo "Cleaning up..."
rm "$download_location"

# Download Visual Studio Code
download_url="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
download_location="/tmp/vscode.deb"

echo "Downloading Visual Studio Code..."
wget -O "$download_location" "$download_url"

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
sudo dpkg -i "$download_location"
sudo apt-get install -f -y

# Cleanup
echo "Cleaning up..."
rm "$download_location"

echo "Installation completed."

# Install system components for powershell
sudo apt update && sudo apt install -y curl gnupg apt-transport-https

# Save the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --yes --dearmor --output /usr/share/keyrings/microsoft.gpg

# Register the Microsoft Product feed
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list'

# Install PowerShell
sudo apt update && sudo apt install -y powershell

# Start PowerShell
# pwsh

echo "$USER"
sudo sh -c 'echo "deb https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb https://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb https://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
" > /etc/apt/sources.list'

sudo apt update && apt list --upgradable && sudo apt upgrade -y

# Check GPU information
gpu_info=$(lspci | grep -i 'VGA\|3D')
if [[ -z $gpu_info ]]; then
    echo "No GPU found."
    exit 1
fi

# Check if NVIDIA GPU is present
if [[ $gpu_info =~ "NVIDIA" ]]; then
    # Check if NVIDIA drivers are already installed
    if nvidia-smi &>/dev/null; then
        read -r -p "NVIDIA drivers are already installed" -t 2 -n 1 -s
        echo "."
    else
        # Install NVIDIA drivers
        sudo apt update
        sudo apt install nvidia-driver firmware-misc-nonfree -y
        sudo apt install -y nvidia-driver
        echo "NVIDIA drivers installed successfully."
    fi

    # Run NVIDIA settings
    sudo nvidia-settings

else
    # Install video acceleration for HD Intel i965
    sudo apt update
    sudo apt install -y i965-va-driver libva-drm2 libva-x11-2 vainfo
    echo "Video acceleration drivers installed successfully."
fi

builddir=$(dirname "$0")
cd "$builddir"

# Samba configurations files
read -r -p "Copying samba files? 
" -t 2 -n 1 -s

# Define the backup folder path
backup_folder="/etc/samba/backup"

# Create the backup folder if it doesn't exist
sudo mkdir -p "$backup_folder"

# Define the original folder path
original_folder="/etc/samba/ORIGINAL"

# Create the original folder if it doesn't exist
sudo mkdir -p "$original_folder"

# Enable extglob option
shopt -s extglob

# Move contents of /etc/samba (excluding ORIGINAL folder) to original folder
sudo mv /etc/samba/!(ORIGINAL) "$original_folder"

# Copy contents of /etc/samba to backup folder
sudo cp -R "$original_folder"/* "$backup_folder"

# Specify the source folder path
source_folder="$builddir/SAMBA"

# Check if the source folder exists
if [ -d "$source_folder" ]; then
    # Copy contents of script's samba folder to /etc/samba
    sudo cp -R "$source_folder"/* /etc/samba
else
    echo "Source folder not found: $source_folder"
fi

# Refresh /etc/samba
sudo systemctl restart smb.service

read -r -p "Continuing...
" -t 1 -n 1 -s

# Create samba user/group
read -r -p "Install samba and create user/group
" -t 2 -n 1 -s

sudo groupadd samba
sudo useradd -m tolga
sudo smbpasswd -a tolga
sudo usermod -aG samba tolga

read -r -p "
Continuing..." -t 1 -n 1 -s

# Configure custom samba folder
read -r -p "Create and configure custom samba folder
" -t 2 -n 1 -s

sudo mkdir /home/Deb12
sudo chgrp samba /home/Deb12
sudo chmod 770 /home/Deb12

read -r -p "
Continuing..." -t 1 -n 1 -s

# Configure user shares
read -r -p "Create and configure user shares
" -t 2 -n 1 -s

sudo mkdir /var/lib/samba/usershares
sudo groupadd -r sambashare
sudo chown root:sambashare /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares
sudo gpasswd sambashare -a tolga
sudo usermod -aG sambashare tolga

read -r -p "
Continuing..." -t 1 -n 1 -s

# Configure fstab
read -r -p "Configure fstab
" -t 2 -n 1 -s

# Backup the original /etc/fstab file
sudo cp /etc/fstab /etc/fstab.backup

# Define the mount entries
mount_entries=(
    "# Custom mount points"
    "//192.168.0.20/LinuxData /mnt/linux-data cifs credentials=/etc/samba/credentials,uid=tolga,gid=samba,file_mode=0777,dir_mode=0777,x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s 0 0"
    "//192.168.0.20/LinuxData/HOME/PROFILES /mnt/home-profiles cifs credentials=/etc/samba/credentials,uid=tolga,gid=samba,file_mode=0777,dir_mode=0777,x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s 0 0"
    "//192.168.0.20/LinuxData/BUDGET-ARCHIVE/ /mnt/Budget-Archives cifs credentials=/etc/samba/credentials,uid=tolga,gid=samba,file_mode=0777,dir_mode=0777,x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s 0 0"
    "//192.168.0.20/WINDOWSDATA /mnt/windows-data cifs credentials=/etc/samba/credentials,uid=tolga,gid=samba,file_mode=0777,dir_mode=0777,x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s 0 0"
)

# Append the mount entries to /etc/fstab
for entry in "${mount_entries[@]}"; do
    echo "$entry" | sudo tee -a /etc/fstab >/dev/null
done

echo "Mount entries added to /etc/fstab.
"

sudo systemctl daemon-reload

read -r -p "
Continuing..." -t 1 -n 1 -s

# Create mount points and set permissions
read -r -p "Create mount points and set permissions
" -t 2 -n 1 -s

sudo mkdir -p /mnt/Budget-Archives
sudo mkdir -p /mnt/home-profiles
sudo mkdir -p /mnt/linux-data
sudo mkdir -p /mnt/smb
sudo mkdir -p /mnt/smb-budget
sudo mkdir -p /mnt/smb-rsync
sudo mkdir -p /mnt/windows-data
sudo chmod 777 /mnt/Budget-Archives
sudo chmod 777 /mnt/home-profiles
sudo chmod 777 /mnt/linux-data
sudo chmod 777 /mnt/smb
sudo chmod 777 /mnt/smb-budget
sudo chmod 777 /mnt/smb-rsync
sudo chmod 777 /mnt/windows-data

read -r -p "
Continuing..." -t 1 -n 1 -s

# Mount the shares and start services
read -r -p "Mount the shares and start services
" -t 2 -n 1 -s && echo ""

sudo mount -a || {
    echo "Mount failed"
    exit 1
}
sudo systemctl enable smb nmb || {
    echo "Failed to enable services"
    exit 1
}
sudo systemctl restart smb.service nmb.service || {
    echo "Failed to restart services"
    exit 1
}
sudo systemctl daemon-reload

read -r -p "
Continuing..." -t 1 -n 1 -s

# Test the fstab entries
read -r -p "Test the fstab entries" -t 2 -n 1 -s

sudo ls /mnt/home-profiles || {
    echo "Failed to list Linux data"
    exit 1
}
sudo ls /mnt/linux-data || {
    echo "Failed to list Linux data"
    exit 1
}
sudo ls /mnt/smb || {
    echo "Failed to list SMB share"
    exit 1
}
sudo ls /mnt/windows-data || {
    echo "Failed to list Windows data"
    exit 1
}
sudo ls /mnt/Budget-Archives || {
    echo "Failed to list Windows data"
    exit 1
}
sudo ls /mnt/smb-budget || {
    echo "Failed to list Windows data"
    exit 1
}
sudo ls /mnt/smb-rsync || {
    echo "Failed to list Windows data"
    exit 1
}

read -r -p "
Continuing..." -t 1 -n 1 -s

read -r -p "Copy WALLPAPER to user home
" -t 2 -n 1 -s

folder_path="/home/$username/Pictures/CustomWallpapers"

if [ ! -d "$folder_path" ]; then
    echo "Creating folder 'CustomWallpapers'..."
    sudo mkdir -p "$folder_path"
    sudo chmod -R 700 "$folder_path"
    sudo chown -R "$username:$username" "$folder_path"
fi

echo "Copying WALLPAPER to $folder_path..."
sudo cp -r "$builddir/WALLPAPERS"/* "$folder_path"
sudo chmod -R 700 "$folder_path"
sudo chown -R "$username:$username" "$folder_path"

echo "Continuing..."
sleep 1

echo "Done. Time to defrag or fstrim."
sudo fstrim -av
echo "Operation completed."

exit 0
