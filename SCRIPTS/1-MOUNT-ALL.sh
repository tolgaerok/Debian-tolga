#!/bin/bash
#####################################################################################################################################
#   Mount > All                                                                                                                     #
#   Tolga Erok
#   May 29, 2023
#
#   This script mounts all mount points located under the /mnt directories.
#   It uses a function called "mount_directory" to mount each directory individually.
#   The script provides feedback on the success or failure of each mount operation.
#   At the end, it displays a summary indicating if all directories were successfully mounted or not.
#   It waits for 3 seconds before exiting.
#   Function to mount a directory...
#                                                                                                                                   #
#####################################################################################################################################
sudo systemctl daemon-reload

echo -e "\033[34m" # Set text color to blue
echo "Mounting all mount points"
echo -e "\033[1;37m"

# Function to mount a directory
mount_directory() {
    local dir="$1"
    
    # Mount the directory
    if sudo mount "$dir" 2>/dev/null; then
        echo -e "\033[1;32mMount of $dir successful\033[0m" # Display in bright green
        return 0
    else
        echo -e "\033[1;31mMount of $dir failed\033[0m" # Display in bright red
        return 1
    fi
}

# echo -e "\033[34mMounting all mount points\033[0m\n\n" # Display in blue

# Mount all directories under /mnt
failed_mounts=0
for dir in /mnt/*; do
    if [ -d "$dir" ]; then
        if ! mount_directory "$dir"; then
            failed_mounts=$((failed_mounts + 1))
        fi
    fi
done

sudo systemctl daemon-reload

# Check if any mounts failed
if [ "$failed_mounts" -eq 0 ]; then
    echo -e "\n\033[1;33mMounting done.\033[0m" # Display in bright yellow
else
    echo -e "\n\033[1;31mUnable to mount all directories.\033[0m" # Display in bright red
fi

sleep 3
echo -e "\n\033[1;33m...Complete.\033[0m"
exit 0
