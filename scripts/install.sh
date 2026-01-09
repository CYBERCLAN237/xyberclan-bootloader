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

# UI Helper Functions
show_progress() {
    local percent=$1
    local width=40
    local filled=$((percent * width / 100))
    local empty=$((width - filled))
    
    printf "\r${CYAN}Progress: [${GREEN}"
    printf "%${filled}s" | tr ' ' '#'
    printf "${NC}"
    printf "%${empty}s" | tr ' ' ' '
    printf "${CYAN}] %d%%${NC}" "$percent"
    
    if [ "$percent" -eq 100 ]; then
        echo -e "\n"
    fi
}

show_spinner() {
    local pid=$1
    local message="$2"
    local spin='-\|/'
    local i=0
    
    echo -n -e "${BLUE}$message... ${NC}"
    while kill -0 "$pid" 2>/dev/null; do
        i=$(((i + 1) % 4))
        printf "\r${BLUE}%s... ${CYAN}%s${NC}" "$message" "${spin:$i:1}"
        sleep 0.1
    done
    
    wait "$pid"
    local status=$?
    
    if [ $status -eq 0 ]; then
        printf "\r${BLUE}%s... ${GREEN}Done!${NC}\n" "$message"
    else
        printf "\r${BLUE}%s... ${RED}Failed! (Exit code: $status)${NC}\n" "$message"
    fi
    return $status
}

run_with_spinner() {
    local message="$1"
    shift
    "$@" &
    show_spinner "$!" "$message"
}

echo -e "${CYAN}"
cat << "EOF"
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      █████╗ ███╗   ██╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔══██╗████╗  ██║
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ███████║██╔██╗ ██║
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     ██╔══██║██║╚██╗██║
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗██║  ██║██║ ╚████║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
    
                               Boot Loader Installer

                     Open Source Community Project by XYBERCLAN
                          Developed by: psycho237-prog & almight
                     
                     Join us: https://xyber-clan.vercel.app/
                     GitHub:  https://github.com/CYBERCLAN237
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
    show_progress 5
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
        VERSION=$VERSION_ID
    else
        echo -e "${RED}Cannot detect Linux distribution${NC}"
        exit 1
    fi
    echo -e "${BLUE}Detected: $PRETTY_NAME${NC}"
    show_progress 10
}

# Check and Install dependencies
check_dependencies() {
    if command -v plymouth &> /dev/null; then
        echo -e "${GREEN}✓ Plymouth found${NC}"
        HAS_PLYMOUTH=true
    else
        echo -e "${YELLOW}! Plymouth not found${NC}"
        HAS_PLYMOUTH=false
        
        echo -ne "${CYAN}Would you like to install Plymouth? (y/N): ${NC}"
        read -r install_dep
        if [[ "$install_dep" =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}Installing Plymouth...${NC}"
            case $DISTRO in
                arch|manjaro)
                    pacman -S --noconfirm plymouth
                    ;;
                debian|ubuntu|kali|parrot|raspbian)
                    apt-get update && apt-get install -y plymouth
                    ;;
                fedora|rhel|centos)
                    dnf install -y plymouth
                    ;;
                *)
                    echo -e "${RED}Manual installation of 'plymouth' required for your distribution.${NC}"
                    return
                    ;;
            esac
            if command -v plymouth &> /dev/null; then
                echo -e "${GREEN}✓ Plymouth installed successfully${NC}"
                HAS_PLYMOUTH=true
            fi
        fi
    fi

    # Check for Plymouth Script Plugin (Required for the animations to work)
    local script_plugin="/usr/lib/plymouth/script.so"
    [ ! -f "$script_plugin" ] && script_plugin="/usr/lib64/plymouth/script.so"
    [ ! -f "$script_plugin" ] && script_plugin="/usr/lib/x86_64-linux-gnu/plymouth/script.so"

    if [ -f "$script_plugin" ]; then
        echo -e "${GREEN}✓ Plymouth Script plugin found${NC}"
    else
        echo -e "${YELLOW}! Plymouth Script plugin not found (Critical for animations)${NC}"
        echo -ne "${CYAN}Would you like to install the script plugin? (y/N): ${NC}"
        read -r install_plugin
        if [[ "$install_plugin" =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}Installing Plymouth Script plugin...${NC}"
            case $DISTRO in
                arch|manjaro)
                    # Often included in plymouth package in Arch
                    echo -e "${YELLOW}On Arch, ensure 'plymouth' is fully installed.${NC}"
                    ;;
                debian|ubuntu|kali|parrot|raspbian)
                    apt-get update && apt-get install -y plymouth-label
                    # Some versions need plymouth-themes or similar for scripts
                    apt-get install -y plymouth-themes || true
                    ;;
                fedora|rhel|centos)
                    dnf install -y plymouth-plugin-script
                    ;;
                *)
                    echo -e "${RED}Manual installation of 'plymouth-plugin-script' required.${NC}"
                    ;;
            esac
        fi
    fi

    # Check and Install Python PIL (Required for theme generation)
    if python3 -c "import PIL" &> /dev/null; then
        echo -e "${GREEN}✓ Python PIL (Pillow) found${NC}"
    else
        echo -e "${YELLOW}! Python PIL (Pillow) not found (Required for theme generation)${NC}"
        echo -ne "${CYAN}Would you like to install it? (y/N): ${NC}"
        read -r install_pil
        if [[ "$install_pil" =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}Installing Python PIL...${NC}"
            case $DISTRO in
                arch|manjaro)
                    pacman -S --noconfirm python-pillow
                    ;;
                debian|ubuntu|kali|parrot|raspbian)
                    apt-get update && apt-get install -y python3-pil
                    ;;
                fedora|rhel|centos)
                    dnf install -y python3-pillow
                    ;;
                opensuse*)
                    zypper install -y python3-Pillow
                    ;;
                *)
                    echo -e "${RED}Manual installation of 'python3-pil' or 'python-pillow' required.${NC}"
                    ;;
            esac
            if python3 -c "import PIL" &> /dev/null; then
                echo -e "${GREEN}✓ Python PIL installed successfully${NC}"
            else
                echo -e "${RED}Error: Failed to install Python PIL. Plymouth theme generation will fail.${NC}"
            fi
        fi
    fi
}

# Create backup
create_backup() {
    echo -e "\n${YELLOW}Creating backup...${NC}"
    show_progress 15
    mkdir -p "$BACKUP_DIR"
    
    if [ -d "/usr/share/plymouth/themes" ]; then
        cp -r /usr/share/plymouth/themes "$BACKUP_DIR/plymouth-themes-$(date +%Y%m%d-%H%M%S)" 2>/dev/null || true
    fi
    
    if [ -f "/etc/default/grub" ]; then
        cp /etc/default/grub "$BACKUP_DIR/grub-$(date +%Y%m%d-%H%M%S)" 2>/dev/null || true
    fi
    
    echo -e "${GREEN}✓ Backup created at $BACKUP_DIR${NC}"
    show_progress 20
}

# Install Plymouth theme
install_plymouth_theme() {
    if [ "$HAS_PLYMOUTH" = false ]; then
        echo -e "${YELLOW}Skipping Plymouth installation (not available)${NC}"
        return
    fi
    
    echo -e "\n${CYAN}Select Plymouth Theme Style:${NC}"
    echo "1) Hacker Style (Centered logo, matrix effects - Original)"
    echo "2) Classic Style (Logo on top, loading spinner below - New)"
    read -p "Choice [1-2]: " plymouth_choice
    
    local anim_script="$SCRIPT_DIR/boot-animation.sh"
    [ "$plymouth_choice" == "2" ] && anim_script="$SCRIPT_DIR/boot-animation-classic.sh"
    
    echo -e "\n${CYAN}Would you like to preview the theme before installing?${NC}"
    read -p "Preview? (y/N): " do_preview
    if [[ "$do_preview" =~ ^[Yy]$ ]]; then
        bash "$anim_script"
        echo -e "\n${YELLOW}Press Enter to continue with installation...${NC}"
        read -r
    fi

    show_progress 30
    
    THEME_DIR="/usr/share/plymouth/themes/xyberclan"
    mkdir -p "$THEME_DIR"
    
    # Generate Plymouth theme files
    source "$anim_script"
    run_with_spinner "Generating theme components" generate_plymouth_theme "$THEME_DIR"
    show_progress 50
    
    # Copy logo
    cp "$PROJECT_ROOT/assets/xyberclan-logo.txt" "$THEME_DIR/"
    
    # Set as default theme - use multiple fallback methods
    if command -v plymouth-set-default-theme &> /dev/null; then
        run_with_spinner "Setting default Plymouth theme" plymouth-set-default-theme xyberclan
    elif command -v update-alternatives &> /dev/null && [ -f /etc/alternatives/default.plymouth ]; then
        # Fallback for systems without plymouth-set-default-theme
        run_with_spinner "Setting default Plymouth theme (via alternatives)" update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth "$THEME_DIR/xyberclan.plymouth" 100
        run_with_spinner "Configuring Plymouth theme" update-alternatives --set default.plymouth "$THEME_DIR/xyberclan.plymouth"
    else
        # Manual fallback - create symlink
        echo -e "${YELLOW}Using manual theme configuration...${NC}"
        rm -f /etc/plymouth/plymouthd.conf.d/01-xyberclan.conf 2>/dev/null || true
        mkdir -p /etc/plymouth/plymouthd.conf.d
        echo "[Daemon]" > /etc/plymouth/plymouthd.conf.d/01-xyberclan.conf
        echo "Theme=xyberclan" >> /etc/plymouth/plymouthd.conf.d/01-xyberclan.conf
        
        # Also update the main config if it exists
        if [ -f /etc/plymouth/plymouthd.conf ]; then
            sed -i 's/^Theme=.*/Theme=xyberclan/' /etc/plymouth/plymouthd.conf || \
            echo -e "\n[Daemon]\nTheme=xyberclan" >> /etc/plymouth/plymouthd.conf
        fi
    fi
    
    # Update initramfs
    if command -v update-initramfs &> /dev/null; then
        run_with_spinner "Updating initramfs (this may take a minute)" update-initramfs -u
    elif command -v dracut &> /dev/null; then
        run_with_spinner "Updating dracut" dracut -f
    elif command -v mkinitcpio &> /dev/null; then
        run_with_spinner "Updating initramfs" mkinitcpio -P
    else
        echo -e "${YELLOW}⚠ Could not update initramfs - theme installed but may not show until manual update${NC}"
    fi
    
    show_progress 70
    echo -e "${GREEN}✓ Plymouth theme installed${NC}"
}

# Install GRUB Theme (Glassmorphism Design)
install_grub_theme() {
    if [ ! -f "/etc/default/grub" ]; then
        echo -e "${YELLOW}GRUB not found, skipping theme installation...${NC}"
        return
    fi
    
    echo -e "\n${YELLOW}Preparing to install XYBERCLAN GRUB Theme...${NC}"
    
    # Prompt for preview first
    echo -e "${CYAN}Recommended: Preview the theme before installing it on your system.${NC}"
    echo -n -e "${YELLOW}Starting SAFE preview now... (Requires QEMU)${NC}\n"
    
    # Run preview script as the original non-root user to ensure display access
    if [ -n "$SUDO_USER" ]; then
        sudo -u "$SUDO_USER" bash "$PROJECT_ROOT/scripts/preview-grub-theme.sh"
    else
        bash "$PROJECT_ROOT/scripts/preview-grub-theme.sh"
    fi

    echo -e "\n${YELLOW}Preview finished.${NC}"
    echo -n -e "${YELLOW}Proceed with actual system installation? [y/N]: ${NC}"
    if ! read -r confirm_install || [[ ! "$confirm_install" =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Installation skipped.${NC}"
        return
    fi

    show_progress 75
    
    local GRUB_THEME_SRC="$PROJECT_ROOT/grub/themes/xyberclan"
    local GRUB_THEME_DEST="/boot/grub/themes/xyberclan"
    
    # Check for grub2 path (Fedora/RHEL)
    if [ -d "/boot/grub2" ]; then
        GRUB_THEME_DEST="/boot/grub2/themes/xyberclan"
    fi
    
    # Check if theme source exists
    if [ ! -d "$GRUB_THEME_SRC" ]; then
        echo -e "${RED}Error: Theme source not found at $GRUB_THEME_SRC${NC}"
        return 1
    fi
    
    # Create themes directory if needed
    mkdir -p "$(dirname "$GRUB_THEME_DEST")"
    
    # Copy theme files
    echo -e "${BLUE}Copying theme files...${NC}"
    mkdir -p "$GRUB_THEME_DEST" && cp -rf "$GRUB_THEME_SRC"/* "$GRUB_THEME_DEST/"
    
    # Verify fonts exist in destination
    echo -e "${BLUE}Verifying font files...${NC}"
    for font in "terminus-12.pf2" "terminus-18.pf2" "unifont-16.pf2"; do
        if [ ! -f "$GRUB_THEME_DEST/$font" ]; then
            echo -e "${YELLOW}Warning: Font $font not found in destination. Retrying explicit copy...${NC}"
            cp "$GRUB_THEME_SRC/$font" "$GRUB_THEME_DEST/" || true
        fi
    done
    
    # Background Selection
    echo -e "\n${CYAN}Select the default background for your GRUB theme:${NC}"
    options=($(ls "$GRUB_THEME_SRC" | grep -E '\.(png|jpg|jpeg)$' | grep -v 'logo' | grep -v 'select' | grep -v 'menu' | grep -v 'info'))
    
    if [ ${#options[@]} -gt 0 ]; then
        for i in "${!options[@]}"; do
            echo -e "  $((i+1))) ${options[$i]}"
        done
        echo -n -e "\nEnter choice [1-${#options[@]}]: "
        read -r bg_choice
        
        if [[ "$bg_choice" -gt 0 && "$bg_choice" -le "${#options[@]}" ]]; then
            SELECTED_BG="${options[$((bg_choice-1))]}"
            echo -e "${GREEN}Default background set to: $SELECTED_BG${NC}"
            sed -i "s/^desktop-image: .*/desktop-image: \"$SELECTED_BG\"/" "$GRUB_THEME_DEST/theme.txt"
        fi
    fi
    
    show_progress 85
    
    # Update GRUB configuration
    echo -e "${BLUE}Configuring GRUB theme...${NC}"
    
    # Backup current grub config
    cp /etc/default/grub "$BACKUP_DIR/grub-theme-$(date +%Y%m%d-%H%M%S)"
    
    # Add or update GRUB_THEME
    if grep -q "^GRUB_THEME=" /etc/default/grub; then
        sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"$GRUB_THEME_DEST/theme.txt\"|" /etc/default/grub
    else
        echo "GRUB_THEME=\"$GRUB_THEME_DEST/theme.txt\"" >> /etc/default/grub
    fi
    
    # Ensure GRUB_GFXMODE is set for proper resolution
    if ! grep -q "^GRUB_GFXMODE=" /etc/default/grub; then
        echo 'GRUB_GFXMODE="1920x1080,1280x720,auto"' >> /etc/default/grub
    fi
    
    show_progress 90
    
    # Update GRUB
    echo -e "${BLUE}Regenerating GRUB configuration...${NC}"
    if command -v update-grub &> /dev/null; then
        run_with_spinner "Updating GRUB" update-grub
    elif command -v grub2-mkconfig &> /dev/null; then
        run_with_spinner "Updating GRUB" grub2-mkconfig -o /boot/grub2/grub.cfg
    elif command -v grub-mkconfig &> /dev/null; then
        run_with_spinner "Updating GRUB" grub-mkconfig -o /boot/grub/grub.cfg
    fi
    
    show_progress 95
    echo -e "${GREEN}✓ GRUB theme installed at $GRUB_THEME_DEST${NC}"
    echo -e "${CYAN}  Theme will appear on next reboot${NC}"
}

# Customize GRUB (legacy - just distributor name)
customize_grub() {
    if [ ! -f "/etc/default/grub" ]; then
        echo -e "${YELLOW}GRUB not found, skipping...${NC}"
        return
    fi
    
    echo -e "\n${YELLOW}Customizing GRUB...${NC}"
    show_progress 80
    
    # Update GRUB
    if command -v update-grub &> /dev/null; then
        run_with_spinner "Updating GRUB configuration" update-grub
    elif command -v grub2-mkconfig &> /dev/null; then
        run_with_spinner "Updating GRUB configuration" grub2-mkconfig -o /boot/grub2/grub.cfg
    elif command -v grub-mkconfig &> /dev/null; then
        run_with_spinner "Updating GRUB configuration" grub-mkconfig -o /boot/grub/grub.cfg
    fi
    
    show_progress 95
    echo -e "${GREEN}✓ GRUB customized${NC}"
}

# Add systemd boot message
add_systemd_message() {
    echo -e "\n${YELLOW}Adding systemd boot message...${NC}"
    show_progress 90
    
    # Relocate scripts to a system-wide location for early boot access
    INSTALL_DIR="/usr/share/xyberclan-bootloader"
    mkdir -p "$INSTALL_DIR"
    cp "$SCRIPT_DIR/boot-animation.sh" "$INSTALL_DIR/"
    cp "$SCRIPT_DIR/boot-animation-classic.sh" "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR"/*.sh

    # Create a service that displays the XYBERCLAN logo
    cat > /etc/systemd/system/xyberclan-boot.service <<EOF
[Unit]
Description=XYBERCLAN Boot Animation
DefaultDependencies=no
After=plymouth-start.service
Before=display-manager.service

[Service]
Type=oneshot
ExecStart=$INSTALL_DIR/boot-animation.sh
StandardOutput=journal+console
StandardError=journal+console

[Install]
WantedBy=sysinit.target
EOF
    
    systemctl daemon-reload
    systemctl enable xyberclan-boot.service
    
    show_progress 100
    echo -e "${GREEN}✓ Systemd boot message added${NC}"
}

# Test animation after installation
test_animation() {
    echo -e "\n${CYAN}Would you like to test the animations now? (No reboot required)${NC}"
    echo "1) Test Boot Animation (Hacker Style)"
    echo "2) Test Boot Animation (Classic Style)"
    echo "3) Test Power-Off Animation"
    echo "4) Skip testing"
    read -p "Choice [1-4]: " test_choice
    
    case $test_choice in
        1)
            bash "$SCRIPT_DIR/boot-animation.sh"
            ;;
        2)
            bash "$SCRIPT_DIR/boot-animation-classic.sh"
            ;;
        3)
            bash "$SCRIPT_DIR/poweroff-animation.sh"
            ;;
        4)
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
    check_dependencies
    create_backup
    
    echo -e "\n${CYAN}Select installation method:${NC}"
    echo "1) Plymouth theme (recommended for modern systems)"
    echo "2) GRUB Theme - Glassmorphism (modern visual bootloader)"
    echo "3) Reset GRUB distributor name (remove XYBERCLAN tag)"
    echo "4) Systemd boot message"
    echo "5) Full install: Plymouth + GRUB Theme + Systemd"
    read -p "Choice [1-5]: " choice
    
    case $choice in
        1)
            install_plymouth_theme
            ;;
        2)
            install_grub_theme
            ;;
        3)
            customize_grub
            ;;
        4)
            add_systemd_message
            ;;
        5)
            install_plymouth_theme
            install_grub_theme
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
