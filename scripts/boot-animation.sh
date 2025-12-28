#!/bin/bash

###############################################################################
# XYBERCLAN Boot Animation Script - Hacker Style
# Generates animated boot sequence with XYBERCLAN branding
###############################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
BRIGHT_GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Animation frames for XYBERCLAN
FRAME1="
    ██╗  ██╗
    ╚██╗██╔╝
     ╚███╔╝ 
     ██╔██╗ 
    ██╔╝ ██╗
    ╚═╝  ╚═╝
"

FRAME2="
    ██╗  ██╗██╗   ██╗
    ╚██╗██╔╝╚██╗ ██╔╝
     ╚███╔╝  ╚████╔╝ 
     ██╔██╗   ╚██╔╝  
    ██╔╝ ██╗   ██║   
    ╚═╝  ╚═╝   ╚═╝   
"

FRAME3="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗ 
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝
"

FRAME4="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      █████╗ ███╗   ██╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔══██╗████╗  ██║
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ███████║██╔██╗ ██║
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     ██╔══██║██║╚██╗██║
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗██║  ██║██║ ╚████║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
"

SLOGAN="for open minded"

# System boot messages (hacker style)
BOOT_MESSAGES=(
    "Initializing XYBERCLAN kernel modules..."
    "Loading secure boot protocols..."
    "Mounting encrypted filesystems..."
    "Starting network security daemon..."
    "Activating firewall rules..."
    "Loading custom kernel extensions..."
    "Initializing neural network interface..."
    "Establishing secure connections..."
    "Verifying system integrity..."
    "Loading XYBERCLAN environment..."
)

# Function to clear screen
clear_screen() {
    clear
}

# Function to type text character by character (hacker effect)
type_text() {
    local text="$1"
    local color="$2"
    local delay="${3:-0.01}"
    
    echo -n -e "${color}"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep "$delay"
    done
    echo -e "${NC}"
}

# Function to show matrix rain effect
matrix_rain() {
    local duration="${1:-1}"
    local chars="01"
    
    for ((i=0; i<3; i++)); do
        echo -n -e "${GREEN}"
        for ((j=0; j<80; j++)); do
            echo -n "${chars:RANDOM%${#chars}:1}"
        done
        echo -e "${NC}"
        sleep 0.03
    done
}

# Function to display boot messages
show_boot_messages() {
    for msg in "${BOOT_MESSAGES[@]}"; do
        echo -n -e "${GRAY}[${NC}"
        echo -n -e "${BRIGHT_GREEN}  OK  ${NC}"
        echo -n -e "${GRAY}]${NC} "
        type_text "$msg" "$CYAN" 0.005
        sleep 0.15
    done
}

# Function to display frame with glitch effect
display_frame_glitch() {
    local frame="$1"
    local color="$2"
    
    # Show glitchy version first
    echo -e "${RED}${frame}${NC}"
    sleep 0.05
    clear_screen
    
    # Show correct version
    echo -e "${color}${frame}${NC}"
}

# Function to display frame
display_frame() {
    local frame="$1"
    local color="$2"
    echo -e "${color}${frame}${NC}"
}

# Function to display slogan with typing effect
display_slogan_typed() {
    local spaces=$(( (80 - ${#SLOGAN}) / 2 ))
    printf "%${spaces}s" ""
    
    echo -n -e "${CYAN}"
    for ((i=0; i<${#SLOGAN}; i++)); do
        echo -n "${SLOGAN:$i:1}"
        sleep 0.05
    done
    echo -e "${NC}"
}

# Function to display slogan
display_slogan() {
    local spaces=$(( (80 - ${#SLOGAN}) / 2 ))
    printf "%${spaces}s" ""
    echo -e "${CYAN}${SLOGAN}${NC}"
}

# Main animation function (hacker style)
animate_boot() {
    local delay="${1:-0.6}"
    
    clear_screen
    
    # Initial boot sequence
    echo -e "${BRIGHT_GREEN}╔════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_GREEN}║                     XYBERCLAN SECURE BOOT SEQUENCE                         ║${NC}"
    echo -e "${BRIGHT_GREEN}╚════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    sleep 0.5
    
    # Show boot messages
    show_boot_messages
    echo ""
    sleep 0.3
    
    # Matrix rain effect
    echo -e "${GRAY}Decrypting boot loader...${NC}"
    matrix_rain 1
    sleep 0.3
    
    clear_screen
    
    # Frame 1 with glitch
    display_frame_glitch "$FRAME1" "$MAGENTA"
    sleep "$delay"
    
    # Frame 2 with glitch
    clear_screen
    display_frame_glitch "$FRAME2" "$BLUE"
    sleep "$delay"
    
    # Frame 3 with glitch
    clear_screen
    display_frame_glitch "$FRAME3" "$CYAN"
    sleep "$delay"
    
    # Frame 4 - final reveal
    clear_screen
    echo ""
    display_frame "$FRAME4" "$BRIGHT_GREEN"
    echo ""
    
    # Type slogan character by character
    display_slogan_typed
    echo ""
    
    # Final boot message
    sleep 0.3
    echo ""
    type_text ">>> System initialized successfully" "$BRIGHT_GREEN" 0.02
    type_text ">>> Welcome to XYBERCLAN" "$CYAN" 0.02
    echo ""
    
    sleep 1.0
}

# Function to generate Plymouth theme
generate_plymouth_theme() {
    local theme_dir="$1"
    
    cat > "$theme_dir/xyberclan.plymouth" <<'EOF'
[Plymouth Theme]
Name=XYBERCLAN
Description=XYBERCLAN boot animation - for open minded
ModuleName=script

[script]
ImageDir=/usr/share/plymouth/themes/xyberclan
ScriptFile=/usr/share/plymouth/themes/xyberclan/xyberclan.script
EOF

    cat > "$theme_dir/xyberclan.script" <<'EOF'
# XYBERCLAN Plymouth Boot Animation Script

Window.SetBackgroundTopColor(0.0, 0.0, 0.0);
Window.SetBackgroundBottomColor(0.0, 0.0, 0.0);

logo.image = Image.Text("XYBERCLAN", 0.2, 0.8, 1.0);
logo.sprite = Sprite(logo.image);
logo.sprite.SetX(Window.GetWidth() / 2 - logo.image.GetWidth() / 2);
logo.sprite.SetY(Window.GetHeight() / 2 - logo.image.GetHeight() / 2);

slogan.image = Image.Text("for open minded", 0.4, 0.6, 0.8);
slogan.sprite = Sprite(slogan.image);
slogan.sprite.SetX(Window.GetWidth() / 2 - slogan.image.GetWidth() / 2);
slogan.sprite.SetY(Window.GetHeight() / 2 + 50);

progress = 0;

fun refresh_callback() {
    progress += 0.005;
    if (progress > 1.0) progress = 0;
    
    logo.sprite.SetOpacity(Math.Sin(progress * 3.14159) * 0.5 + 0.5);
}

Plymouth.SetRefreshFunction(refresh_callback);
EOF
}

# Export functions for use in other scripts
export -f animate_boot
export -f display_frame
export -f display_slogan

# If script is run directly, show animation
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo -e "${YELLOW}XYBERCLAN Boot Animation Demo${NC}"
    echo ""
    sleep 1
    animate_boot 0.6
    echo ""
    echo -e "${GREEN}Animation complete!${NC}"
fi
