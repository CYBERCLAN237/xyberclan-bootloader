# XYBERCLAN Distribution Guide

This document explains how to distribute the `xyberclan-bootloader` via common Linux package managers.

## 🐧 1. Debian / Ubuntu (PPA)

Personal Package Archives (PPAs) are the best way to distribute `.deb` packages for Debian-based systems.

### Launchpad PPA
1.  **Register**: Create an account on [Launchpad](https://launchpad.net/).
2.  **Create a PPA**: Go to your profile and click "Create a new PPA".
3.  **Follow the Detailed Guide**: See [docs/PPA_PUBLISHING.md](PPA_PUBLISHING.md) for step-by-step commands to generate keys and upload.
4.  **How to Install**:
    
    For **Ubuntu**, users can run:
    ```bash
    sudo add-apt-repository ppa:psycho237-prog/ppa
    sudo apt update
    sudo apt install xyberclan-bootloader
    ```

    For **Debian/Parrot/Kali**, use the **Manual Method** to avoid template errors:
    ```bash
    # 1. GPG Key
    gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 907A43D9264119F4
    
    # 2. Keyring
    gpg --export 907A43D9264119F4 | sudo tee /etc/apt/keyrings/xyberclan.gpg > /dev/null
    
    # 3. Source
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/xyberclan.gpg] http://ppa.launchpad.net/psycho237-prog/ppa/ubuntu noble main" | sudo tee /etc/apt/sources.list.d/xyberclan.list
    
    # 4. Action
    sudo apt update && sudo apt install xyberclan-bootloader
    ```

## 📦 2. Arch Linux (AUR)

The Arch User Repository is the standard for Arch-based distros (Manjaro, EndeavourOS).

1.  **Create Account**: Register on the [AUR website](https://aur.archlinux.org/).
2.  **Create PKGBUILD**: Create a `PKGBUILD` that clones this repo and runs the install script or installs files manually.
3.  **Submit**: Follow the [AUR submission guide](https://wiki.archlinux.org/title/AUR_submission_guidelines).

## 🏢 3. Fedora (Copr)

Copr is Fedora's equivalent to PPA.

1.  **Register**: Account on [Fedora Copr](https://copr.fedorainfracloud.org/).
2.  **Create Project**: Start a new project.
3.  **Build from Repo**: Point it to this GitHub repository. It will automatically build `.rpm` packages for Fedora users.
