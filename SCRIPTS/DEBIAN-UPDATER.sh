#!/bin/bash

#  Tolga Erok  4/7/2023  Common debian commands used in menu format

# Run from remote location:
# sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/tolgaerok/Debian-tolga/main/SCRIPTS/DEBIAN-UPDATER.sh)"
# bash -c "$(wget -qLO - https://raw.githubusercontent.com/tolgaerok/Debian-tolga/main/SCRIPTS/DEBIAN-UPDATER.sh)"


# Function to display the main menu
function display_menu() {
    clear
    echo -e "\e[34m===============================================\e[0m"
    echo -e "\e[1m\e[34m Debian Update Script     \e[0m"
    echo -e "\e[34m===============================================\e[0m"
    echo
    echo -e " \e[1m\e[93m1.     \e[0m\e[1mUpdate package lists\e[0m"
    echo -e " \e[1m\e[93m2.     \e[0m\e[1mUpgrade installed packages\e[0m"
    echo -e " \e[1m\e[93m3.     \e[0m\e[1mRemove unnecessary packages\e[0m"
    echo -e " \e[1m\e[93m4.     \e[0m\e[1mClean package cache\e[0m"
    echo -e " \e[1m\e[93m5.     \e[0m\e[1mRemove residual configuration files\e[0m"
    echo -e " \e[1m\e[93m6.     \e[0m\e[1mClean up unused dependencies\e[0m"
    echo -e " \e[1m\e[93m7.     \e[0m\e[1mClear thumbnail cache\e[0m"
    echo -e " \e[1m\e[93m8.     \e[0m\e[1mClear browser caches\e[0m"
    echo -e " \e[1m\e[93m9.     \e[0m\e[1mClear systemd journal logs\e[0m"
    echo -e " \e[1m\e[93m10.    \e[0m\e[1mCheck distribution upgrade availability\e[0m"
    echo -e " \e[1m\e[93m11.    \e[0m\e[1mList upgradable packages\e[0m"
    echo
    echo -e "\e[34m 0.     \e[0m\e[34mExit\e[0m"
    echo
    echo -e "\e[34m===============================================\e[0m"
    echo -e "\e[33mPlease enter your choice (0-11):\e[0m"
}

# Function to update package lists
function update_package_lists() {
    sudo apt-get update
    echo "Package lists updated."
}

# Function to upgrade installed packages
function upgrade_packages() {
    sudo apt-get upgrade -y
    echo "Packages upgraded."
}

# Function to remove unnecessary packages
function autoremove_packages() {
    sudo apt-get autoremove -y
    echo "Unnecessary packages removed."
}

# Function to clean package cache
function clean_package_cache() {
    sudo apt-get clean
    echo "Package cache cleaned."
}

# Function to remove residual configuration files
function remove_residual_config_files() {
    packages=$(dpkg -l | awk '/^rc/ { print $2 }')
    if [ -n "$packages" ]; then
        sudo dpkg -P $packages
        echo "Residual configuration files removed."
    else
        echo "No residual configuration files found."
    fi
}

# Function to clean up unused dependencies
function cleanup_unused_dependencies() {
    sudo apt-get autoclean -y
    echo "Unused dependencies cleaned up."
}

# Function to clear thumbnail cache
function clear_thumbnail_cache() {
    user_home="$HOME"
    thumbnail_cache_dir="$user_home/.cache/thumbnails"

    if [ -d "$thumbnail_cache_dir" ]; then
        rm -rf "$thumbnail_cache_dir"/*
        echo "Thumbnail cache cleared."
    else
        echo "Thumbnail cache is already cleared."
    fi
}

# Function to clear browser caches
function clear_browser_caches() {
    user_home="$HOME"
    chrome_cache_dir="$user_home/.cache/google-chrome"
    firefox_cache_dir="$user_home/.cache/mozilla/firefox"

    if [ -d "$chrome_cache_dir" ]; then
        rm -rf "$chrome_cache_dir"/*
    else
        echo "Chrome cache is already cleared."
    fi

    if [ -d "$firefox_cache_dir" ]; then
        rm -rf "$firefox_cache_dir"/*
    else
        echo "Firefox cache is already cleared."
    fi

    echo "Browser caches cleared."
}


# Function to clear systemd journal logs
function clear_journal_logs() {
    sudo journalctl --vacuum-time=7d
    echo "Systemd journal logs cleared."
}

# Function to check distribution upgrade availability
function check_distribution_upgrade() {
    sudo apt-get dist-upgrade --simulate
    echo "Distribution upgrade availability checked."
}

# Function to list upgradable packages
function list_upgradable_packages() {
    sudo apt list --upgradable
    echo "Upgradable packages listed."
}

# Main script
while true; do
    display_menu
    read -r choice

    case $choice in
    1) update_package_lists ;;
    2) upgrade_packages ;;
    3) autoremove_packages ;;
    4) clean_package_cache ;;
    5) remove_residual_config_files ;;
    6) cleanup_unused_dependencies ;;
    7) clear_thumbnail_cache ;;
    8) clear_browser_caches ;;
    9) clear_journal_logs ;;
    10) check_distribution_upgrade ;;
    11) list_upgradable_packages ;;
    0)
        echo "Exiting script..."
        exit
        ;;
    *) echo "Invalid option. Please try again." ;;
    esac

    echo "Press Enter to continue...."
    read -r
done
