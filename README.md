# XYBERCLAN Boot Loader

> **Custom Linux boot animation featuring XYBERCLAN branding**  
> *"for open minded"*

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Linux-green.svg)
![Status](https://img.shields.io/badge/status-active-success.svg)

## 🚀 Overview

XYBERCLAN Boot Loader is a collection of scripts and tools that create a custom boot animation for Linux systems, featuring the XYBERCLAN brand with animated text and the community slogan "for open minded".

Perfect for XYBERCLAN community members who want to personalize their Linux boot experience!

## ✨ Features

- 🎨 **Animated XYBERCLAN logo** during boot with hacker-style effects
- 🔴 **Power-off animation** with glitchy shutdown sequence
- 💬 **Custom slogan display**: "for open minded"
- 🔧 **Multiple boot loader support**: Plymouth, GRUB, systemd-boot
- 🐧 **Cross-distro compatibility**: Ubuntu, Fedora, Arch, Debian, and more
- 📦 **Easy installation**: One-command setup
- 🔄 **Safe uninstallation**: Restores original boot configuration
- 🎭 **Customizable**: Adjust colors, timing, and animation style
- 🖥️ **Hacker aesthetic**: Matrix effects, glitch transitions, system messages

## 📸 Preview

```
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      █████╗ ███╗   ██╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔══██╗████╗  ██║
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ███████║██╔██╗ ██║
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     ██╔══██║██║╚██╗██║
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗██║  ██║██║ ╚████║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
    
                              for open minded
```

## 🔧 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/CYBERCLAN237/xyberclan-bootloader.git
cd xyberclan-bootloader

# Run the installation script
sudo ./scripts/install.sh
```

### Uninstallation

```bash
# Restore original boot configuration
sudo ./scripts/uninstall.sh
```

## 📋 Requirements

- Linux operating system
- Root/sudo access
- One of the following boot loaders:
  - Plymouth (recommended for modern systems)
  - GRUB 2
  - systemd-boot

## 🎯 Supported Distributions

- ✅ Ubuntu / Linux Mint
- ✅ Fedora / RHEL / CentOS
- ✅ Arch Linux / Manjaro
- ✅ Debian
- ✅ openSUSE
- ✅ Pop!_OS
- ✅ Most other systemd-based distributions

## 📚 Documentation

- [Installation Guide](docs/INSTALLATION.md)
- [Customization Options](docs/CUSTOMIZATION.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

## 🛠️ Project Structure

```
xyberclan-bootloader/
├── scripts/
│   ├── install.sh            # Main installation script
│   ├── uninstall.sh          # Removal script
│   ├── boot-animation.sh     # Boot animation generator
│   └── poweroff-animation.sh # Power-off animation
├── assets/
│   ├── xyberclan-logo.txt    # ASCII art logo
│   └── animation-frames/     # Animation frame files
├── config/
│   ├── plymouth/             # Plymouth theme files
│   └── grub/                 # GRUB customization files
└── docs/                     # Documentation
```

## 🤝 Contributing

We welcome contributions from the XYBERCLAN community! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🌐 Community

- **Organization**: [CYBERCLAN237](https://github.com/CYBERCLAN237)
- **Website**: [XYBERCLAN](https://xyber-clan.vercel.app/)

## ⚠️ Disclaimer

This tool modifies your system's boot configuration. While we've implemented safety measures and backup functionality, please ensure you understand the changes being made. Always test in a virtual machine first if you're unsure.

---

<div align="center">
  <strong>Made with ❤️ by the XYBERCLAN community</strong><br>
  <em>for open minded</em>
</div>
