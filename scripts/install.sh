#!/bin/bash

###############################################################################
# XYBERCLAN Boot Loader Installation Script
# Installs custom boot animation for XYBERCLAN community members
###############################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Backup directory
BACKUP_DIR="/var/backups/xyberclan-bootloader"

echo -e "${CYAN}"
cat << "EOF"
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      █████╗ ███╗   ██╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔══██╗████╗  ██║
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ███████║██╔██╗ ██║
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     ██╔══██║██║╚██╗██║
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗██║  ██║██║ ╚████║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
    
                              Boot Loader Installer
EOF
echo -e "${NC}"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: This script must be run as root (use sudo)${NC}" 
   exit 1
fi

echo -e "${YELLOW}Installing XYBERCLAN Boot Loader...${NC}\n"

# Detect distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        VERSION=$VERSION_ID
    else
        echo -e "${RED}Cannot detect Linux distribution${NC}"
        exit 1
    fi
    echo -e "${BLUE}Detected: $PRETTY_NAME${NC}"
}

# Check for Plymouth
check_plymouth() {
    if command -v plymouth &> /dev/null; then
        echo -e "${GREEN}✓ Plymouth found${NC}"
        HAS_PLYMOUTH=true
    else
        echo -e "${YELLOW}! Plymouth not found${NC}"
        HAS_PLYMOUTH=false
    fi
}

# Create backup
create_backup() {
    echo -e "\n${YELLOW}Creating backup...${NC}"
    mkdir -p "$BACKUP_DIR"
    
    if [ -d "/usr/share/plymouth/themes" ]; then
        cp -r /usr/share/plymouth/themes "$BACKUP_DIR/plymouth-themes-$(date +%Y%m%d-%H%M%S)" 2>/dev/null || true
    fi
    
    if [ -f "/etc/default/grub" ]; then
        cp /etc/default/grub "$BACKUP_DIR/grub-$(date +%Y%m%d-%H%M%S)" 2>/dev/null || true
    fi
    
    echo -e "${GREEN}✓ Backup created at $BACKUP_DIR${NC}"
}

# Install Plymouth theme
install_plymouth_theme() {
    if [ "$HAS_PLYMOUTH" = false ]; then
        echo -e "${YELLOW}Skipping Plymouth installation (not available)${NC}"
        return
    fi
    
    echo -e "\n${YELLOW}Installing Plymouth theme...${NC}"
    
    THEME_DIR="/usr/share/plymouth/themes/xyberclan"
    mkdir -p "$THEME_DIR"
    
    # Generate Plymouth theme files
    source "$SCRIPT_DIR/boot-animation.sh"
    generate_plymouth_theme "$THEME_DIR"
    
    # Copy logo
    cp "$PROJECT_ROOT/assets/xyberclan-logo.txt" "$THEME_DIR/"
    
    # Set as default theme
    plymouth-set-default-theme xyberclan
    
    # Update initramfs
    if command -v update-initramfs &> /dev/null; then
        echo -e "${BLUE}Updating initramfs...${NC}"
        update-initramfs -u
    elif command -v dracut &> /dev/null; then
        echo -e "${BLUE}Updating dracut...${NC}"
        dracut -f
    fi
    
    echo -e "${GREEN}✓ Plymouth theme installed${NC}"
}

# Customize GRUB
customize_grub() {
    if [ ! -f "/etc/default/grub" ]; then
        echo -e "${YELLOW}GRUB not found, skipping...${NC}"
        return
    fi
    
    echo -e "\n${YELLOW}Customizing GRUB...${NC}"
    
    # Add XYBERCLAN branding to GRUB
    if ! grep -q "GRUB_DISTRIBUTOR.*XYBERCLAN" /etc/default/grub; then
        sed -i 's/^GRUB_DISTRIBUTOR=.*/GRUB_DISTRIBUTOR="XYBERCLAN - for open minded"/' /etc/default/grub
    fi
    
    # Update GRUB
    if command -v update-grub &> /dev/null; then
        update-grub
    elif command -v grub2-mkconfig &> /dev/null; then
        grub2-mkconfig -o /boot/grub2/grub.cfg
    elif command -v grub-mkconfig &> /dev/null; then
        grub-mkconfig -o /boot/grub/grub.cfg
    fi
    
    echo -e "${GREEN}✓ GRUB customized${NC}"
}

# Add systemd boot message
add_systemd_message() {
    echo -e "\n${YELLOW}Adding systemd boot message...${NC}"
    
    # Create a service that displays the XYBERCLAN logo
    cat > /etc/systemd/system/xyberclan-boot.service <<EOF
[Unit]
Description=XYBERCLAN Boot Animation
DefaultDependencies=no
Before=display-manager.service

[Service]
Type=oneshot
ExecStart=$SCRIPT_DIR/boot-animation.sh
StandardOutput=journal+console
StandardError=journal+console

[Install]
WantedBy=multi-user.target
EOF
    
    systemctl daemon-reload
    systemctl enable xyberclan-boot.service
    
    echo -e "${GREEN}✓ Systemd boot message added${NC}"
}

# Test animation after installation
test_animation() {
    echo -e "\n${CYAN}Would you like to test the animations now? (No reboot required)${NC}"
    echo "1) Test Boot Animation"
    echo "2) Test Power-Off Animation"
    echo "3) Skip testing"
    read -p "Choice [1-3]: " test_choice
    
    case $test_choice in
        1)
            bash "$SCRIPT_DIR/boot-animation.sh"
            ;;
        2)
            bash "$SCRIPT_DIR/poweroff-animation.sh"
            ;;
        3)
            return
            ;;
        *)
            echo -e "${YELLOW}Skipping test...${NC}"
            ;;
    esac
}

# Main installation
main() {
    detect_distro
    check_plymouth
    create_backup
    
    echo -e "\n${CYAN}Select installation method:${NC}"
    echo "1) Plymouth theme (recommended for modern systems)"
    echo "2) GRUB customization only"
    echo "3) Systemd boot message"
    echo "4) All of the above"
    read -p "Choice [1-4]: " choice
    
    case $choice in
        1)
            install_plymouth_theme
            ;;
        2)
            customize_grub
            ;;
        3)
            add_systemd_message
            ;;
        4)
            install_plymouth_theme
            customize_grub
            add_systemd_message
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            exit 1
            ;;
    esac
    
    echo -e "\n${GREEN}╔════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  Installation Complete!                    ║${NC}"
    echo -e "${GREEN}║  The files are now in place.               ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
    
    test_animation
    
    echo -e "\n${CYAN}for open minded${NC}\n"
    echo -e "${YELLOW}Note: Changes to GRUB and Plymouth require a reboot to take full effect.${NC}"
}

main
