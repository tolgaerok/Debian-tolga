#!/bin/bash

# Function to display the menu
function show_menu() {
    clear
    echo -e "\e[34m===============================================\e[0m"
    echo -e "\e[1m\e[34m Tolga's Personal Debian Installer Menu \e[0m"
    echo -e "\e[34m===============================================\e[0m"
    echo
    echo -e " \e[1m\e[93m1.     \e[0m\e[1mRun Debian updater script\e[0m"
    echo -e " \e[1m\e[93m2.     \e[0m\e[1mRun Check systemd script\e[0m"
    echo -e " \e[1m\e[93m3.     \e[0m\e[1mAdd user to sudoers\e[0m"
    echo -e " \e[1m\e[93m4.     \e[0m\e[1mRun Mount all\e[0m"
    echo -e " \e[1m\e[93m5.     \e[0m\e[1mRun Un-mount all\e[0m"
    echo -e " \e[1m\e[93m6.     \e[0m\e[1mInstall Additional file systems\e[0m"
    echo -e " \e[1m\e[93m7.     \e[0m\e[1m script   \e[0m"
    echo -e " \e[1m\e[93m8.     \e[0m\e[1m script   \e[0m"
    echo -e " \e[1m\e[93m9.     \e[0m\e[1m  script   \e[0m"
    echo -e " \e[1m\e[93m10.     \e[0m\e[1m script  \e[0m"
    echo -e " \e[1m\e[93m11.     \e[0m\e[1m script  \e[0m"
    echo -e " \e[1m\e[93m12.     \e[0m\e[1m script  \e[0m"
    echo
    echo -e "\e[34m 0.     \e[0m\e[34mExit\e[0m"

    echo
    echo -e "\e[34m===============================================\e[0m"
}

# Function to run a script based on its name
function run_script() {
    script_name="$1"
    script_url="https://raw.githubusercontent.com/tolgaerok/Debian-tolga/main/SCRIPTS/$script_name"
    echo -e "\nDownloading $script_name script..."
    TEMP_DIR=$(mktemp -d)

    cleanup() {
        echo -e "\nCleaning up..."
        rm -rf "$TEMP_DIR"
        echo "$script_name script execution completed."
    }

    (
        trap cleanup EXIT

        curl -sSL "$script_url" -o "$TEMP_DIR/script.sh"
        chmod u+x "$TEMP_DIR/script.sh"

        echo -e "\nRunning $script_name script..."
        sudo bash "$TEMP_DIR/script.sh"

        # Check if script execution was successful
        if [ $? -eq 0 ]; then
            echo -e "\n$script_name script execution completed successfully."
        else
            echo -e "\nFailed to execute $script_name script."
        fi
    )
}

# Function to add user to sudoers
function add_user_to_sudoers() {
    # Check if the script is being run as root
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root."
        sleep 3
        return
    fi

    # Get the username of the current user
    current_user=$(logname)

    # Check if the current user is already in sudoers
    if grep -q "^$current_user" /etc/sudoers; then
        echo -e "\n\e[1m\e[34mUser $current_user is already in the sudoers file.\e[0m"
        sleep 3
        return
    fi

    # Run visudo to safely edit the sudoers file
    if ! visudo -f /etc/sudoers.d/add_user_sudoers; then
        echo -e "\n\e[1m\e[33mFailed to edit the sudoers file.\e[0m"
        sleep 2
        return
    fi

    # Create a sudoers file for adding the current user
    sudoers_file="/etc/sudoers.d/add_user_sudoers"
    echo "$current_user ALL=(ALL:ALL) ALL" >"$sudoers_file"

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
}

# Main script logic
while true; do
    show_menu
    read -rp "Enter your choice (0-6): " choice
    case $choice in
    0)
        echo "Exiting..."
        break
        ;;
    1)
        run_script "DEBIAN-UPDATER.sh"
        ;;
    2)
        run_script "CHECK-SYSTEMD-REMOTE-FS.sh"
        ;;
    3)
        add_user_to_sudoers
        ;;
    4)
        run_script "1-MOUNT-ALL.sh"
        ;;
    5)
        run_script "2-UMOUNT-ALL.sh"
        ;;
    6)
        run_script "ADDITIONAL-FILE-SYSTEMS.sh"
        ;;
    *)
        echo "Invalid choice. Please try again."
        ;;
    esac
    echo
done
