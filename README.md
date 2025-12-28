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

## 📋 Requirements

Before installing, ensure your system meets these basic requirements:
- **Operating System**: Linux (Parrot, Debian, Ubuntu, Kali, Arch, Fedora, etc.)
- **Permissions**: Root/sudo access
- **Dependencies**: 
  - `plymouth`: For the boot animation.
  - `python3-pil`: Required to generate the high-quality animation frames.
    - *On Debian/Ubuntu/Parrot:* `sudo apt install python3-pil`

### 1. Professional PPA Installation (Ubuntu/Parrot / RECOMMENDED)
Stay up to date automatically with our official PPA:

```bash
sudo add-apt-repository ppa:psycho237-prog/ppa
sudo apt update
sudo apt install xyberclan-bootloader
```

### 2. Manual Download (.deb)
You can download pre-built packages from our **[Releases](https://github.com/CYBERCLAN237/xyberclan-bootloader/releases)** page.

1.  Download the `.deb` file.
2.  Install it using:
    ```bash
    sudo apt install ./xyberclan-bootloader_*.deb
    ```

### 2. Easy Installation (Automation Script)
If you prefer running a script directly:

```bash
# 1. Download the code
git clone https://github.com/CYBERCLAN237/xyberclan-bootloader.git
cd xyberclan-bootloader

# 2. Run the installer
sudo ./scripts/install.sh
```
*Follow the on-screen prompts. We recommend selecting **Option 4** for the full experience.*

## 📦 Professional Installation (Debian Package)

If you are on Parrot OS, Debian, or Ubuntu, you can build a professional `.deb` package. This is safer and easier to manage.

```bash
# 1. Install build tools
sudo apt install devscripts debhelper python3-pil

# 2. Build the package
debuild -us -uc -b

# 3. Install the resulting package
sudo apt install ../xyberclan-bootloader_1.0.0_all.deb
```

## 🎯 Supported Distributions

- ✅ **Parrot Security OS** (Fully tested)
- ✅ **Debian / Ubuntu / Kali / Pop!_OS**
- ✅ **Arch Linux / Manjaro**
- ✅ **Fedora / RHEL / CentOS**
- ✅ **Most other Linux distros**

## 📚 Documentation

- [Detailed Installation Guide](docs/INSTALLATION.md) — Step-by-step for beginners.
- [Distribution Guide](docs/DISTRIBUTION.md) — **NEW**: How to add this to PPA, AUR, and other package managers.
- [Customization Options](docs/CUSTOMIZATION.md) — Change colors and styles.
- [Troubleshooting](docs/TROUBLESHOOTING.md) — If things don't look right.

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
