#!/bin/bash

###############################################################################
# XYBERCLAN GRUB Theme Preview Script
# Safely preview the GRUB theme without modifying your system
# Targeted for ALL major Linux distributions (Arch, Debian, Fedora, SUSE)
###############################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Add common local bin paths to PATH
export PATH="$PATH:$HOME/.local/bin:/root/.local/bin:/usr/local/bin"

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
THEME_DIR="$PROJECT_ROOT/grub/themes/xyberclan"

# Branding Header
echo -e "${CYAN}"
cat << "BANNER_EOF"
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      █████╗ ███╗   ██╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔══██╗████╗  ██║
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ███████║██╔██╗ ██║
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     ██╔══██║██║╚██╗██║
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗██║  ██║██║ ╚████║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
    
                           GRUB Theme Preview Tool
BANNER_EOF
echo -e "${NC}"
echo -e "${YELLOW}           Developed by: psycho237-prog & almight${NC}\n"

# Detect distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    DISTRO="unknown"
fi

# Multi-distro package installer
install_package() {
    echo -e "${BLUE}Installing dependency: ${CYAN}$*${BLUE} for ${CYAN}$PRETTY_NAME${NC}"
    
    if command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm "$@"
    elif command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y "$@"
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y "$@"
    elif command -v zypper &> /dev/null; then
        sudo zypper install -y "$@"
    else
        echo -e "${RED}Error: Supported package manager not found. Please install $* manually.${NC}"
        return 1
    fi
}

install_preview_dependencies() {
    echo -e "${CYAN}Checking/Installing missing dependencies...${NC}"

    # 1. Install QEMU
    if ! command -v qemu-system-x86_64 &> /dev/null; then
        case $DISTRO in
            arch|manjaro) install_package qemu-full ;;
            debian|ubuntu|pop|kali) install_package qemu-system-x86 ;;
            fedora|rhel|centos) install_package qemu-system-x86 ;;
            *) install_package qemu-system-x86 ;;
        esac
    fi

    # 2. Install mtools and libisoburn
    if ! command -v mtools &> /dev/null; then
        case $DISTRO in
            arch|manjaro) install_package mtools libisoburn ;;
            debian|ubuntu|pop|kali) install_package mtools libisoburn-tool ;;
            *) install_package mtools ;;
        esac
    fi

    # 3. Install grub2-theme-preview and pipx
    if ! command -v grub2-theme-preview &> /dev/null; then
        if ! command -v pipx &> /dev/null; then
            case $DISTRO in
                arch|manjaro) install_package python-pipx ;;
                debian|ubuntu|pop|kali) install_package pipx ;;
                *) install_package pipx 2>/dev/null || true ;;
            esac
        fi
        
        if command -v pipx &> /dev/null; then
            echo -e "${BLUE}Installing grub2-theme-preview via pipx...${NC}"
            pipx install grub2-theme-preview --include-deps || pipx upgrade grub2-theme-preview
        else
            echo -e "${BLUE}Installing grub2-theme-preview via pip3...${NC}"
            pip3 install --user grub2-theme-preview || sudo pip3 install grub2-theme-preview --break-system-packages
        fi
    fi
}

main() {
    # Automatically setup dependencies
    install_preview_dependencies

    # Find the binary
    PREVIEW_BIN="grub2-theme-preview"
    if [ -f "$HOME/.local/bin/grub2-theme-preview" ]; then
        PREVIEW_BIN="$HOME/.local/bin/grub2-theme-preview"
    elif [ -f "/root/.local/bin/grub2-theme-preview" ]; then
        PREVIEW_BIN="/root/.local/bin/grub2-theme-preview"
    fi

    if ! command -v "$PREVIEW_BIN" &> /dev/null && [ ! -f "$PREVIEW_BIN" ]; then
        echo -e "${RED}Error: grub2-theme-preview could not be started.${NC}"
        exit 1
    fi

    # Background Selection
    BG_FILE=""
    if [ -n "$1" ]; then
        if [ -f "$THEME_DIR/$1" ]; then
            BG_FILE="$1"
        else
            echo -e "${RED}Warning: Background '$1' not found in $THEME_DIR. Using selector.${NC}"
        fi
    fi

    if [ -z "$BG_FILE" ]; then
        echo -e "${YELLOW}Select a background to preview:${NC}"
        options=($(ls "$THEME_DIR" | grep -E '\.(png|jpg|jpeg)$' | grep -v 'logo' | grep -v 'select' | grep -v 'menu' | grep -v 'info'))
        
        if [ ${#options[@]} -eq 0 ]; then
            echo -e "${RED}No backgrounds found in $THEME_DIR${NC}"
            exit 1
        fi

        for i in "${!options[@]}"; do
            echo -e "  $((i+1))) ${options[$i]}"
        done
        
        echo -n -e "\nEnter choice [1-${#options[@]}]: "
        read -r choice
        
        if [[ "$choice" -gt 0 && "$choice" -le "${#options[@]}" ]]; then
            BG_FILE="${options[$((choice-1))]}"
        else
            BG_FILE="${options[0]}"
            echo -e "${BLUE}Defaulting to: $BG_FILE${NC}"
        fi
    fi

    # Update theme.txt temporarily with the selected background
    # We use a backup to restore it afterwards
    THEME_TXT="$THEME_DIR/theme.txt"
    cp "$THEME_TXT" "$THEME_TXT.bak"
    sed -i "s/^desktop-image: .*/desktop-image: \"$BG_FILE\"/" "$THEME_TXT"

    echo -e "\n${GREEN}Starting 4K preview with background: $BG_FILE...${NC}"
    
    # Run the preview in 4K
    if ! "$PREVIEW_BIN" --resolution 3840x2160 "$THEME_DIR"; then
        echo -e "\n${RED}ERROR: The preview failed to start.${NC}"
        echo -e "${YELLOW}Common reasons:${NC}"
        echo -e "1. You are running as 'root' and QEMU cannot access your display."
        echo -e "2. Your system display manager (X11/Wayland) is not reachable."
        echo -e "3. KVM or virtualization is disabled in your BIOS."
        echo -e "\n${CYAN}Try running this command as a normal user (not sudo):${NC}"
        echo -e "  ./scripts/preview-grub-theme.sh"
        mv "$THEME_TXT.bak" "$THEME_TXT"
        exit 1
    fi

    # Restore theme.txt
    mv "$THEME_TXT.bak" "$THEME_TXT"
}

main "$@"
