#!/bin/bash

###############################################################################
# XYBERCLAN Boot Loader Uninstallation Script
# Removes custom boot animation and restores original configuration
###############################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Backup directory
BACKUP_DIR="/var/backups/xyberclan-bootloader"

echo -e "${YELLOW}XYBERCLAN Boot Loader Uninstaller${NC}\n"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: This script must be run as root (use sudo)${NC}" 
   exit 1
fi

echo -e "${YELLOW}Uninstalling XYBERCLAN Boot Loader...${NC}\n"

# Remove Plymouth theme
remove_plymouth() {
    if [ -d "/usr/share/plymouth/themes/xyberclan" ]; then
        echo -e "${BLUE}Removing Plymouth theme...${NC}"
        
        # Reset to default theme
        if command -v plymouth-set-default-theme &> /dev/null; then
            plymouth-set-default-theme -R
        fi
        
        # Remove theme directory
        rm -rf /usr/share/plymouth/themes/xyberclan
        
        # Update initramfs
        if command -v update-initramfs &> /dev/null; then
            update-initramfs -u
        elif command -v dracut &> /dev/null; then
            dracut -f
        fi
        
        echo -e "${GREEN}✓ Plymouth theme removed${NC}"
    fi
}

# Restore GRUB configuration
restore_grub() {
    if [ -f "/etc/default/grub" ]; then
        echo -e "${BLUE}Restoring GRUB configuration...${NC}"
        
        # Find latest backup
        LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/grub-* 2>/dev/null | head -1)
        
        if [ -n "$LATEST_BACKUP" ]; then
            cp "$LATEST_BACKUP" /etc/default/grub
            echo -e "${GREEN}✓ GRUB restored from backup${NC}"
        else
            # Remove XYBERCLAN branding
            sed -i 's/^GRUB_DISTRIBUTOR="XYBERCLAN.*"/GRUB_DISTRIBUTOR=""/' /etc/default/grub
            echo -e "${GREEN}✓ GRUB branding removed${NC}"
        fi
        
        # Update GRUB
        if command -v update-grub &> /dev/null; then
            update-grub
        elif command -v grub2-mkconfig &> /dev/null; then
            grub2-mkconfig -o /boot/grub2/grub.cfg
        elif command -v grub-mkconfig &> /dev/null; then
            grub-mkconfig -o /boot/grub/grub.cfg
        fi
    fi
}

# Remove systemd service
remove_systemd_service() {
    if [ -f "/etc/systemd/system/xyberclan-boot.service" ]; then
        echo -e "${BLUE}Removing systemd service...${NC}"
        
        systemctl disable xyberclan-boot.service 2>/dev/null || true
        rm -f /etc/systemd/system/xyberclan-boot.service
        systemctl daemon-reload
        
        echo -e "${GREEN}✓ Systemd service removed${NC}"
    fi
}

# Main uninstallation
main() {
    echo -e "${CYAN}This will remove all XYBERCLAN boot customizations.${NC}"
    read -p "Continue? (y/N): " confirm
    
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Uninstallation cancelled${NC}"
        exit 0
    fi
    
    remove_plymouth
    restore_grub
    remove_systemd_service
    
    echo -e "\n${GREEN}╔════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  Uninstallation Complete!                  ║${NC}"
    echo -e "${GREEN}║  Original boot configuration restored      ║${NC}"
    echo -e "${GREEN}║  Reboot to see changes                     ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}\n"
    
    echo -e "${BLUE}Backups are still available at: $BACKUP_DIR${NC}\n"
}

main
