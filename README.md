# *`My debian environment`*
```sh
Tolga Erok
2/7/2023
```

The provided script is a Bash script intended to be used as a Debian 12 installer. It automates various tasks related to system setup and configuration. Here is a breakdown of the script:

- The script starts by checking if it is run with root privileges. If not, it displays an error message and exits.

- It defines some variables for storing file paths and directories.

- The script updates the package list and upgrades the system using the `apt` package manager.

- It installs several software packages and dependencies using `apt`. These packages include various utilities and applications such as Nala, GDebi, Flatpak, firmware drivers, media codecs, Samba, Synaptic, and more.

- The script sets up Flatpak and installs a specific application called "Caprine" from Flathub.
- It downloads the TeamViewer package from a specified URL and installs it using `dpkg`.
- The script cleans up by removing the downloaded TeamViewer package.
- Next, it downloads and installs Visual Studio Code using similar steps as above.
- The script installs PowerShell by adding the Microsoft repository GPG keys and registering the Microsoft product feed. It then updates the package list and installs PowerShell.
- The script adds Debian Bookworm repositories to the system's `/etc/apt/sources.list` file.
- It performs an update and upgrade again to ensure all packages are up to date.
- The script checks the GPU information and installs the necessary drivers accordingly. If an NVIDIA GPU is detected, it installs NVIDIA drivers; otherwise, it installs video acceleration drivers for Intel i965.
- The script handles Samba configuration by copying files and directories. It prompts the user to confirm the copying process.
- It creates samba user and group, sets up custom samba folders, and configures user shares.
- The script modifies the `/etc/fstab` file to add mount entries for network shares.
- It creates mount points and sets permissions for various directories.
- The script mounts the shares and starts the SMB and NMB services.
- It performs a test to ensure the mount entries are working correctly.
- The script copies wallpaper files to the user's home directory.
- Finally, it displays messages indicating the completion of different tasks.

# *Summary*
Overall, the script automates the installation of various software packages, configuration of Samba shares, and setting up system components, providing a streamlined process for setting up a Debian 12 system.

## *`How to run?`*

1. Make sure `git` is usable. If not, *install it:*

```sh
sudo dnf install git -y
```

2. Open Terminal, type:

```sh
git clone tolgaerok/Debian-tolga
cd ./Debian-tolga
```

3. Run it:

```sh
chmod u+x ./install.sh
./install.sh
```

