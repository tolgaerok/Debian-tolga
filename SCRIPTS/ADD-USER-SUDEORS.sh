#!/bin/bash

# Tolga Erok
# 6/7/2023
# Add the current user to the list of sudoers.

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    sleep 3
   # exit 0
fi

# Get the username of the current user
current_user=$(logname)

# Check if the current user is already in sudoers 
if grep -q "^$current_user" /etc/sudoers; then
    echo -e "\n\e[1m\e[34mUser $current_user is already in the sudoers file.\e[0m"
    sleep 3
    #exit 0
fi

# Run visudo to safely edit the sudoers file
if ! visudo -f /etc/sudoers.d/add_user_sudoers; then
    echo -e "\n\e[1m\e[33mFailed to edit the sudoers file.\e[0m"
    sleep 2
    #exit 0
fi

# Create a sudoers file for adding the current user
sudoers_file="/etc/sudoers.d/add_user_sudoers"
echo "$current_user ALL=(ALL:ALL) ALL" > "$sudoers_file"

# Verify if the modification was successful
if [ $? -eq 0 ]; then
    echo -e "\n\e[1m\e[34mUser $current_user has been added to the sudoers file successfully.\e[0m"
    sleep 3
else
    echo -e "\n\e[1m\e[33mFailed to add user $current_user to the sudoers file.\e[0m"
    sleep 2
fi

# Secure the sudoers file permissions
chmod 440 "$sudoers_file"
exit 0
