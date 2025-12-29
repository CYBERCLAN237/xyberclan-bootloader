# Installation Guide

## Prerequisites

Before installing the XYBERCLAN boot loader, ensure you have:

- A Linux system with one of the following boot loaders:
  - Plymouth (recommended)
  - GRUB 2
  - systemd-boot
- Root/sudo access
- Git installed

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/CYBERCLAN237/xyberclan-bootloader.git
cd xyberclan-bootloader
```

### 2. Run the Installation Script

```bash
sudo ./scripts/install.sh
```

### 3. Choose Installation Method

The installer will present you with options:

1. **Plymouth theme** (recommended for modern systems)
   - Provides smooth graphical boot animation
   - Best visual experience
   - Requires Plymouth to be installed

2. **GRUB customization only**
   - Adds XYBERCLAN branding to GRUB menu
   - Lightweight option
   - Works on all systems with GRUB

3. **Systemd boot message**
   - Text-based animation during boot
   - Minimal resource usage
   - Works on systemd-based distributions

4. **All of the above**
   - Complete XYBERCLAN boot experience
   - Recommended for full branding

### 4. Reboot Your System

```bash
sudo reboot
```

## Distribution-Specific Notes

### Ubuntu / Debian / Linux Mint

Plymouth is usually pre-installed. The installation should work out of the box.

```bash
# If Plymouth is not installed:
sudo apt install plymouth plymouth-themes
```

### Fedora / RHEL / CentOS

```bash
# Install Plymouth if needed:
sudo dnf install plymouth plymouth-scripts
```

### Arch Linux / Manjaro

```bash
# Install Plymouth if needed:
sudo pacman -S plymouth
```

## Troubleshooting

### Plymouth theme not showing

1. Ensure Plymouth is installed and enabled
2. Check that the theme was set correctly:
   ```bash
   sudo plymouth-set-default-theme --list
   ```
3. Rebuild initramfs:
   ```bash
   sudo update-initramfs -u  # Debian/Ubuntu
   sudo dracut -f            # Fedora/RHEL
   ```

### GRUB changes not visible

1. Ensure GRUB was updated:
   ```bash
   sudo update-grub          # Debian/Ubuntu
   sudo grub2-mkconfig -o /boot/grub2/grub.cfg  # Fedora/RHEL
   ```

### Backup Location

All backups are stored in `/var/backups/xyberclan-bootloader/`

## Uninstallation

To remove the XYBERCLAN boot loader and restore original configuration:

```bash
sudo ./scripts/uninstall.sh
```

This will:
- Remove Plymouth theme
- Restore original GRUB configuration
- Remove systemd service
- Keep backups for safety
