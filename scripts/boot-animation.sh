#!/bin/bash

###############################################################################
# XYBERCLAN Boot Animation Script - Hacker Style
# Generates animated boot sequence with XYBERCLAN branding
###############################################################################

set -e

# Colors
if [ -t 1 ]; then
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
else
    # No colors if not a TTY (basic console fallback)
    RED='' GREEN='' YELLOW='' BLUE='' MAGENTA='' CYAN='' WHITE='' GRAY='' BRIGHT_GREEN='' NC=''
fi

# Animation frames for XYBERCLAN (9 frames for better visibility)
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
    ██╗  ██╗██╗   ██╗██████╗ 
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗
     ╚███╔╝  ╚████╔╝ ██████╔╝
     ██╔██╗   ╚██╔╝  ██╔══██╗
    ██╔╝ ██╗   ██║   ██████╔╝
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ 
"

FRAME4="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  
    ██╔╝ ██╗   ██║   ██████╔╝███████╗
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝
"

FRAME5="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗ 
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝
"

FRAME6="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝
"

FRAME7="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗     
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝
"

FRAME8="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      █████╗ 
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔══██╗
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ███████║
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     ██╔══██║
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗██║  ██║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝
"

FRAME9="
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
    # Fallback if 'clear' command is missing or fails
    if command -v clear &> /dev/null; then
        clear || echo -e "\033[H\033[2J"
    else
        echo -e "\033[H\033[2J"
    fi
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
    local delay="${1:-0.4}"
    
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
    
    # Frame 1 - X with glitch
    display_frame_glitch "$FRAME1" "$MAGENTA"
    sleep "$delay"
    
    # Frame 2 - XY with glitch
    clear_screen
    display_frame_glitch "$FRAME2" "$BLUE"
    sleep "$delay"
    
    # Frame 3 - XYB with glitch
    clear_screen
    display_frame_glitch "$FRAME3" "$CYAN"
    sleep "$delay"
    
    # Frame 4 - XYBE with glitch
    clear_screen
    display_frame_glitch "$FRAME4" "$GREEN"
    sleep "$delay"
    
    # Frame 5 - XYBER with glitch
    clear_screen
    display_frame_glitch "$FRAME5" "$BRIGHT_GREEN"
    sleep "$delay"
    
    # Frame 6 - XYBERC with glitch
    clear_screen
    display_frame_glitch "$FRAME6" "$CYAN"
    sleep "$delay"
    
    # Frame 7 - XYBERCL with glitch
    clear_screen
    display_frame_glitch "$FRAME7" "$BLUE"
    sleep "$delay"
    
    # Frame 8 - XYBERCLA with glitch
    clear_screen
    display_frame_glitch "$FRAME8" "$GREEN"
    sleep "$delay"
    
    # Frame 9 - XYBERCLAN (full) - final reveal
    clear_screen
    echo ""
    display_frame "$FRAME9" "$BRIGHT_GREEN"
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

    # Generate the Plymouth script with the logo
    # Note: Plymouth scripts use a custom language. 
    # We'll use the logo file we copy in install.sh
    cat > "$theme_dir/xyberclan.script" <<'EOF'
# XYBERCLAN Plymouth Boot Animation Script

Window.SetBackgroundTopColor(0.0, 0.0, 0.0);
Window.SetBackgroundBottomColor(0.0, 0.0, 0.0);

# Load logo text from file (since Plymouth doesn't easily render multi-line ASCII)
# But we can try to render the text with a hacker-like font if available
# For now, we simulate the progressive reveal

logo_text = "XYBERCLAN";
slogan_text = "for open minded";

# Create sprites
logo.image = Image.Text(logo_text, 0.2, 0.8, 0.2, 1.0, "Monospace 30");
logo.sprite = Sprite(logo.image);
logo.sprite.SetX(Window.GetWidth() / 2 - logo.image.GetWidth() / 2);
logo.sprite.SetY(Window.GetHeight() / 2 - 50);

slogan.image = Image.Text(slogan_text, 0.0, 0.8, 0.8, 1.0, "Monospace 16");
slogan.sprite = Sprite(slogan.image);
slogan.sprite.SetX(Window.GetWidth() / 2 - slogan.image.GetWidth() / 2);
slogan.sprite.SetY(Window.GetHeight() / 2 + 50);
slogan.sprite.SetOpacity(0);

progress = 0;
frame_counter = 0;

fun refresh_callback() {
    progress += 1;
    
    # Simulate the typing/glitch effect
    if (progress % 10 == 0 && frame_counter < 9) {
        frame_counter++;
        current_text = "";
        for (i = 0; i < frame_counter; i++) {
            current_text += logo_text.CharAt(i);
        }
        logo.image = Image.Text(current_text, 0.2, 0.8, 0.2, 1.0, "Monospace 30");
        logo.sprite.SetImage(logo.image);
    }
    
    # Reveal slogan after logo
    if (frame_counter >= 9 && progress > 150) {
        slogan_opacity = slogan.sprite.GetOpacity();
        if (slogan_opacity < 1.0) {
            slogan.sprite.SetOpacity(slogan_opacity + 0.05);
        }
    }

    # Pulse effect for full logo
    if (frame_counter >= 9) {
        pulse = Math.Sin(progress / 20) * 0.2 + 0.8;
        logo.sprite.SetOpacity(pulse);
    }
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
