# Package Distribution Guide

This document explains how to get the XYBERCLAN Bootloader into common Linux package managers to make it available to the world.

## 📦 1. Debian / Ubuntu (PPA)
To distribute this as an `apt` package for Debian-based systems:

### Launchpad PPA (Ubuntu/Parrot)
1.  **Create a Launchpad Account**: Sign up at [launchpad.net](https://launchpad.net/).
2.  **Create a PPA**: Go to your profile and click "Create a new PPA".
3.  **Follow the Detailed Guide**: See [docs/PPA_PUBLISHING.md](PPA_PUBLISHING.md) for step-by-step commands to generate keys and upload.
4.  **Result**: Users can then install it using:
    ```bash
    sudo add-apt-repository ppa:your-username/ppa-name
    sudo apt update
    sudo apt install xyberclan-bootloader
    ```

## 📦 2. Arch Linux (AUR)
To add this to the Arch User Repository (AUR):

1.  **Create a PKGBUILD**: This is a script that tells Arch how to install your software.
2.  **Registration**: Register on the [AUR website](https://aur.archlinux.org/).
3.  **Upload**: Push your `PKGBUILD` and related files to a new Git repository on the AUR servers.
4.  **Result**: Users can install it using `yay`:
    ```bash
    yay -S xyberclan-bootloader
    ```

## 📦 3. Fedora (Copr)
Copr is the Fedora equivalent of a PPA.

1.  **Create a Fedora Account**: [accounts.fedoraproject.org](https://accounts.fedoraproject.org/).
2.  **Create a New Project**: On [copr.fedorainfracloud.org](https://copr.fedorainfracloud.org/).
3.  **Upload an SRPM**: Use the `fedpkg` tool to upload your source RPM.

## 📦 4. Generic (Snap / Flatpak)
*(Note: Not recommended for bootloaders as they need high-level system access which sandboxed formats often restrict or complicate.)*

---

## 🚀 Recommendation for XYBERCLAN
Since you are a community, we recommend:
1.  **Self-hosted Repo**: Host a simple `apt` repository on your website.
2.  **Launchpad PPA**: This is the most "noob-friendly" way for Parrot/Ubuntu users.
