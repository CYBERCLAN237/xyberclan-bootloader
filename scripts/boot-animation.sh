#!/bin/bash

###############################################################################
# XYBERCLAN Boot Animation Script
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

# Function to clear screen
clear_screen() {
    clear
}

# Function to display frame
display_frame() {
    local frame="$1"
    local color="$2"
    echo -e "${color}${frame}${NC}"
}

# Function to display slogan
display_slogan() {
    local spaces=$(( (80 - ${#SLOGAN}) / 2 ))
    printf "%${spaces}s" ""
    echo -e "${CYAN}${SLOGAN}${NC}"
}

# Main animation function
animate_boot() {
    local delay="${1:-0.3}"
    
    # Frame 1
    clear_screen
    display_frame "$FRAME1" "$MAGENTA"
    sleep "$delay"
    
    # Frame 2
    clear_screen
    display_frame "$FRAME2" "$BLUE"
    sleep "$delay"
    
    # Frame 3
    clear_screen
    display_frame "$FRAME3" "$CYAN"
    sleep "$delay"
    
    # Frame 4 with slogan
    clear_screen
    display_frame "$FRAME4" "$GREEN"
    echo ""
    display_slogan
    sleep 1
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
    progress += 0.01;
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
    animate_boot 0.4
    echo ""
    echo -e "${GREEN}Animation complete!${NC}"
fi
