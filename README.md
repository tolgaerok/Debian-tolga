

# *`My debian environment`*
```sh
Tolga Erok
2/7/2023
```
<div align="left">
  <table style="border-collapse: collapse; width: 100%; border: none;">
    <td align="center" style="border: none;">
        <a href="https://www.debian.org">
          <img src="https://flathub.org/img/distro/debian.svg" alt="Debian" style="width: 100%;">
          <br>Debian
        </a>
      </td>
    </tr>
  </table>
</div>

The provided script is a Bash script intended to be used as a Debian 12 installer. It automates various tasks related to system setup and configuration. Here is a breakdown of the script:

- The script starts by checking if it is `run` with root privileges. If not, it displays an error message and exits.
- It defines some variables for storing file paths and directories.
- The script updates the package list and upgrades the system using the `apt` package manager.
- It installs several software packages and dependencies using `apt`. These packages include various utilities and applications such as:
   ```sh
   Nala, GDebi, Flatpak, firmware drivers, media codecs, Samba, Synaptic, and more.
   ```
- The script sets up Flatpak and installs a specific application called "Caprine" from Flathub.
- It downloads the TeamViewer package from a specified URL and installs it using `dpkg`.
- The script cleans up by removing the downloaded TeamViewer package.
- Next, it downloads and installs Visual Studio Code using similar steps as above.
- The script installs PowerShell by adding the Microsoft repository GPG keys and registering the Microsoft product feed. It then updates the package list and installs PowerShell.
- The script adds Debian Bookworm repositories to the system's `/etc/apt/sources.list` file.
- It performs an update and upgrade again to ensure all packages are up to date.
- The script checks the GPU information and installs the necessary drivers accordingly. If an NVIDIA GPU is detected, it installs `NVIDIA` drivers; otherwise, it installs video acceleration drivers for `Intel i965`.
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
sudo apt-get install git -y
```

2. Open Terminal, type:

```sh
git clone https://github.com/tolgaerok/Debian-tolga.git
cd ./Debian-tolga
```

3. Run it:

```sh
chmod u+x ./install.sh
./install.sh

or run my online debian updater:
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tolgaerok/Debian-tolga/main/SCRIPTS/DEBIAN-UPDATER.sh)"

```

## *Other repositories in my git hub:*

<div align="center">
  <table style="border-collapse: collapse; width: 100%; border: none;">
    <tr>
     <td align="center" style="border: none;">
        <a href="https://github.com/tolgaerok/fedora-tolga">
          <img src="https://flathub.org/img/distro/fedora.svg" alt="Fedora" style="width: 100%;">
          <br>Fedora
        </a>
      </td>
      <td align="center" style="border: none;">
        <a href="https://github.com/tolgaerok/NixOS-tolga">
          <img src="https://flathub.org/img/distro/nixos.svg" alt="NixOs" style="width: 100%;">
          <br>NixOs 23.05
        </a>
      </td>
    </tr>
  </table>
</div>

## *My Stats:*

<div align="center">

<div style="text-align: center;">
  <a href="https://git.io/streak-stats" target="_blank">
    <img src="http://github-readme-streak-stats.herokuapp.com?user=tolgaerok&theme=dark&background=000000" alt="GitHub Streak" style="display: block; margin: 0 auto;">
  </a>
  <div style="text-align: center;">
    <a href="https://github.com/anuraghazra/github-readme-stats" target="_blank">
      <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=tolgaerok&layout=compact&theme=vision-friendly-dark" alt="Top Languages" style="display: block; margin: 0 auto;">
    </a>
  </div>
</div>
</div>
