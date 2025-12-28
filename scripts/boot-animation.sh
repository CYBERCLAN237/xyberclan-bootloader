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
    
    # Check for Python 3 and PIL
    if ! python3 -c "import PIL" 2>/dev/null; then
        echo -e "${RED}Error: Python 3 PIL (Pillow) library not found.${NC}"
        echo -e "${YELLOW}Please install it: sudo apt install python3-pil${NC}"
        return 1
    fi

    # Find a suitable font
    FONT_PATH="/usr/share/fonts/truetype/liberation2/LiberationMono-Regular.ttf"
    if [ ! -f "$FONT_PATH" ]; then
        # Try to find another mono font
        FONT_PATH=$(find /usr/share/fonts -name "LiberationMono-Regular.ttf" -o -name "DejaVuSansMono.ttf" -o -name "FreeMono.ttf" 2>/dev/null | head -n 1)
    fi
    
    if [ -z "$FONT_PATH" ] || [ ! -f "$FONT_PATH" ]; then
        echo -e "${RED}Error: Could not find a suitable monospaced font.${NC}"
        return 1
    fi
    
    echo -e "${BLUE}Generating high-quality frame images using Python...${NC}"
    echo -e "${GRAY}Using font: $FONT_PATH${NC}"

    cat > "$theme_dir/xyberclan.plymouth" <<'EOF'
[Plymouth Theme]
Name=XYBERCLAN
Description=XYBERCLAN boot animation - for open minded
ModuleName=script

[script]
ImageDir=/usr/share/plymouth/themes/xyberclan
ScriptFile=/usr/share/plymouth/themes/xyberclan/xyberclan.script
EOF

    # Python script to generate image
    # We will write a small python helper
    cat > "$theme_dir/gen_image.py" <<EOF
import sys
from PIL import Image, ImageDraw, ImageFont

def generate_image(text, color, output_path, font_path, size=24):
    # Dummy image to calculate text size
    # We use a large canvas to ensure it fits
    canvas_width = 1920
    canvas_height = 1080
    img = Image.new('RGBA', (canvas_width, canvas_height), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    try:
        font = ImageFont.truetype(font_path, size)
    except Exception as e:
        print(f"Error loading font: {e}")
        sys.exit(1)
    
    # Get text bounding box
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    # Add some padding
    padding = 20
    width = int(text_width + padding * 2)
    height = int(text_height + padding * 2)
    
    # Create final image
    # Ensure it's not zero size
    if width <= 0: width = 100
    if height <= 0: height = 100
    
    img = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Draw text
    draw.text((padding, padding), text, font=font, fill=color)
    
    img.save(output_path)

if __name__ == "__main__":
    # Args: text_file color output_file font_path
    text_file = sys.argv[1]
    color = sys.argv[2]
    output_file = sys.argv[3]
    font_path = sys.argv[4]
    
    with open(text_file, 'r') as f:
        text = f.read()
        
    generate_image(text, color, output_file, font_path)
EOF

    # Generate PNGs for each frame
    for i in {1..9}; do
        varname="FRAME$i"
        content="${!varname}"
        
        echo "$content" > "/tmp/xyber_frame_$i.txt"
        
        # Color: #33ff33 (Bright Green)
        python3 "$theme_dir/gen_image.py" "/tmp/xyber_frame_$i.txt" "#33ff33" "$theme_dir/frame$i.png" "$FONT_PATH"
        
        if [ $i -eq 9 ]; then
             # Glitch red: #ff3333
             python3 "$theme_dir/gen_image.py" "/tmp/xyber_frame_$i.txt" "#ff3333" "$theme_dir/frame${i}_glitch.png" "$FONT_PATH"
        fi
        
        rm "/tmp/xyber_frame_$i.txt"
    done
    
    # Generate Slogan Image
    echo "for open minded" > "/tmp/xyber_slogan.txt"
    # Color: #33ccff (Cyan)
    python3 "$theme_dir/gen_image.py" "/tmp/xyber_slogan.txt" "#33ccff" "$theme_dir/slogan.png" "$FONT_PATH"
    rm "/tmp/xyber_slogan.txt"
    
    # Cleanup python script
    rm "$theme_dir/gen_image.py"

    # Write the Plymouth script
    cat > "$theme_dir/xyberclan.script" <<'EOF'
# XYBERCLAN Plymouth Boot Animation Script

Window.SetBackgroundTopColor(0.0, 0.0, 0.0);
Window.SetBackgroundBottomColor(0.0, 0.0, 0.0);

# Load images
frame_images = [];
for (i = 1; i <= 9; i++) {
    frame_images[i] = Image("frame" + i + ".png");
}
frame9_glitch = Image("frame9_glitch.png");
slogan_image = Image("slogan.png");

# Create Sprite
logo_sprite = Sprite();
slogan_sprite = Sprite(slogan_image);
slogan_sprite.SetOpacity(0);

# Center Calculation Function
fun center_sprite(spr, img) {
    spr.SetImage(img);
    spr.SetX(Window.GetWidth() / 2 - img.GetWidth() / 2);
    spr.SetY(Window.GetHeight() / 2 - img.GetHeight() / 2);
}

# Initial State
center_sprite(logo_sprite, frame_images[1]);

# Position slogan below logo
# We need to calculate position based on the final logo size essentially
# But logo grows. We want slogan fixed relative to center.
# Let's say 150 pixels below center.
slogan_sprite.SetX(Window.GetWidth() / 2 - slogan_image.GetWidth() / 2);
slogan_sprite.SetY(Window.GetHeight() / 2 + 120);

progress = 0;
current_frame = 1;

fun refresh_callback() {
    progress++;
    
    # Animate frames every 8 ticks
    if (progress % 8 == 0 && current_frame < 9) {
        current_frame++;
        center_sprite(logo_sprite, frame_images[current_frame]);
    }
    
    # Reveal slogan after logo finishes
    if (current_frame == 9 && progress > 80) {
        op = slogan_sprite.GetOpacity();
        if (op < 1.0) slogan_sprite.SetOpacity(op + 0.05);
    }
    
    # Glitch effect on final frame
    if (current_frame == 9 && progress % 20 == 0) {
        r = Math.Random();
        if (r > 0.8) {
            # Show glitch red version
            center_sprite(logo_sprite, frame9_glitch);
        } else {
            # Restore green
            center_sprite(logo_sprite, frame_images[9]);
        }
    }
}

Plymouth.SetRefreshFunction(refresh_callback);
EOF

    echo -e "${GREEN}Theme generation complete.${NC}"
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
