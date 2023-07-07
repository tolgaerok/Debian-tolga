#!/bin/bash
#  Tolga Erok
#  7/7/2023
#  Troubleshoot tp Install Nvidia Drivers.  ( Only use if you have Nvidia hardware.)

#Install Nvidia Drivers.  ( Only use if you have Nvidia Hardware )
sudo apt install nvidia-detect
nvidia-detect

# Install the recommended driver shown
sudo apt install linux-headers-$(uname -r) nvidia-legacy-340xx-driver 

# Create an Xorg configuration for your gpu
sudo mkdir /etc/X11/xorg.conf.d

echo "Now add the below contents to the file and save ..."
echo
echo "Section "Device""
echo "Identifier "My GPU""
echo "Driver "nvidia""
echo "EndSection"

sleep 10

sudo nano /etc/X11/xorg.conf.d/20-nvidia.conf
echo "Changes will take effect after rebooting the system ..."
