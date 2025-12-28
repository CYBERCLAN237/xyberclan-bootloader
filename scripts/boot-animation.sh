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

    # Start creating the script
    cat > "$theme_dir/xyberclan.script" <<'EOF'
# XYBERCLAN Plymouth Boot Animation Script

Window.SetBackgroundTopColor(0.0, 0.0, 0.0);
Window.SetBackgroundBottomColor(0.0, 0.0, 0.0);

# Define the logo frames (multi-line ASCII art)
# Plymouth doesn't support arrays of string arrays well, so we define lines flat
EOF

    # Generate variable definitions for all 9 frames
    # We will export the bash variables into the Plymouth script
    # Each frame has ~6 lines. We will name them frameX_lineY
    
    for i in {1..9}; do
        varname="FRAME$i"
        content="${!varname}"
        
        # Split content into lines, removing empty first/last if perfectly formatted
        line_idx=0
        while IFS= read -r line; do
            # Skip empty lines if they are just the wrapper newlines
            if [[ -z "${line// }" ]] && [[ $line_idx -eq 0 ]]; then continue; fi
            
            # Escape double quotes and backslashes
            safe_line="${line//\\/\\\\}"
            safe_line="${safe_line//\"/\\\"}"
            
            # Write to script
            echo "frame${i}_line${line_idx} = \"$safe_line\";" >> "$theme_dir/xyberclan.script"
            line_idx=$((line_idx+1))
        done <<< "$content"
        echo "frame${i}_lines = $line_idx;" >> "$theme_dir/xyberclan.script"
    done

    # Append the logic part of the script
    cat >> "$theme_dir/xyberclan.script" <<'EOF'

slogan_text = "for open minded";

# Create sprites for the frames
# We will create 6 sprite objects (max lines) that we update
lines = 6;
sprites = [];
images = [];

# Initialize sprites in center
term_font = "Monospace 12";
line_height = 20;
start_y = Window.GetHeight() / 2 - (lines * line_height) / 2;

for (i = 0; i < lines; i++) {
   sprites[i] = Sprite();
   sprites[i].SetX(Window.GetWidth() / 2 - 300); # Approximate centering for left-aligned ASCII
   sprites[i].SetY(start_y + (i * line_height));
}

# Slogan
slogan.image = Image.Text(slogan_text, 1.0, 1.0, 1.0, 1.0, "Monospace 16");
slogan.sprite = Sprite(slogan.image);
slogan.sprite.SetX(Window.GetWidth() / 2 - slogan.image.GetWidth() / 2);
slogan.sprite.SetY(start_y + (lines * line_height) + 40);
slogan.sprite.SetOpacity(0);

progress = 0;
frame_counter = 1;

fun refresh_callback() {
    progress += 1;
    
    # Animate frames (simulating typwriter/growth)
    # Switch frame every 10 ticks
    
    if (progress % 8 == 0 && frame_counter <= 9) {
        
        # Construct variable name for line count
        # In simple plymouth script we can't do dynamic variable access easily like Lines = eval("frame" + frame_counter + "_lines")
        # So we use a big switch/if
        
        # We'll just define the text for the current frame
        if (frame_counter == 1) { 
            l0 = frame1_line0; l1 = frame1_line1; l2 = frame1_line2; l3 = frame1_line3; l4 = frame1_line4; l5 = frame1_line5; 
        }
        else if (frame_counter == 2) {
             l0 = frame2_line0; l1 = frame2_line1; l2 = frame2_line2; l3 = frame2_line3; l4 = frame2_line4; l5 = frame2_line5; 
        }
        else if (frame_counter == 3) {
             l0 = frame3_line0; l1 = frame3_line1; l2 = frame3_line2; l3 = frame3_line3; l4 = frame3_line4; l5 = frame3_line5; 
        }
        else if (frame_counter == 4) {
             l0 = frame4_line0; l1 = frame4_line1; l2 = frame4_line2; l3 = frame4_line3; l4 = frame4_line4; l5 = frame4_line5; 
        }
        else if (frame_counter == 5) {
             l0 = frame5_line0; l1 = frame5_line1; l2 = frame5_line2; l3 = frame5_line3; l4 = frame5_line4; l5 = frame5_line5; 
        }
        else if (frame_counter == 6) {
             l0 = frame6_line0; l1 = frame6_line1; l2 = frame6_line2; l3 = frame6_line3; l4 = frame6_line4; l5 = frame6_line5; 
        }
        else if (frame_counter == 7) {
             l0 = frame7_line0; l1 = frame7_line1; l2 = frame7_line2; l3 = frame7_line3; l4 = frame7_line4; l5 = frame7_line5; 
        }
        else if (frame_counter == 8) {
             l0 = frame8_line0; l1 = frame8_line1; l2 = frame8_line2; l3 = frame8_line3; l4 = frame8_line4; l5 = frame8_line5; 
        }
        else {
             l0 = frame9_line0; l1 = frame9_line1; l2 = frame9_line2; l3 = frame9_line3; l4 = frame9_line4; l5 = frame9_line5; 
        }

        # Render lines
        # Green color: 0.2, 0.8, 0.2
        sprites[0].SetImage(Image.Text(l0, 0.2, 0.8, 0.2, 1.0, term_font));
        sprites[1].SetImage(Image.Text(l1, 0.2, 0.8, 0.2, 1.0, term_font));
        sprites[2].SetImage(Image.Text(l2, 0.2, 0.8, 0.2, 1.0, term_font));
        sprites[3].SetImage(Image.Text(l3, 0.2, 0.8, 0.2, 1.0, term_font));
        sprites[4].SetImage(Image.Text(l4, 0.2, 0.8, 0.2, 1.0, term_font));
        sprites[5].SetImage(Image.Text(l5, 0.2, 0.8, 0.2, 1.0, term_font));
        
        # Center them
        for (i=0; i<6; i++) {
             # We center based on image width of line 0 usually, but lines vary.
             # Just set X to center minus half of typical width
             # Better: Center each line? No, ASCII must align left.
             # So we center the block.
             w = sprites[i].GetImage().GetWidth();
             if (w > 10) # Valid line
                 sprites[i].SetX(Window.GetWidth() / 2 - (w/2));
        }

        if (frame_counter < 9)
            frame_counter++;
    }
    
    # Reveal slogan after logo complete
    if (frame_counter >= 9 && progress > 80) {
        op = slogan.sprite.GetOpacity();
        if (op < 1.0) slogan.sprite.SetOpacity(op + 0.05);
    }
    
    # Glitch effect when done
    if (frame_counter >= 9 && progress % 20 == 0) {
        # Randomly tint the final frame
        r = Math.Random();
        if (r > 0.7) {
            # Glitch color
             sprites[0].SetImage(Image.Text(frame9_line0, 0.8, 0.2, 0.2, 1.0, term_font));
             sprites[1].SetImage(Image.Text(frame9_line1, 0.8, 0.2, 0.2, 1.0, term_font));
             sprites[2].SetImage(Image.Text(frame9_line2, 0.8, 0.2, 0.2, 1.0, term_font));
             sprites[3].SetImage(Image.Text(frame9_line3, 0.8, 0.2, 0.2, 1.0, term_font));
             sprites[4].SetImage(Image.Text(frame9_line4, 0.8, 0.2, 0.2, 1.0, term_font));
             sprites[5].SetImage(Image.Text(frame9_line5, 0.8, 0.2, 0.2, 1.0, term_font));
        } else {
            # Restore Green
             sprites[0].SetImage(Image.Text(frame9_line0, 0.2, 0.8, 0.2, 1.0, term_font));
             sprites[1].SetImage(Image.Text(frame9_line1, 0.2, 0.8, 0.2, 1.0, term_font));
             sprites[2].SetImage(Image.Text(frame9_line2, 0.2, 0.8, 0.2, 1.0, term_font));
             sprites[3].SetImage(Image.Text(frame9_line3, 0.2, 0.8, 0.2, 1.0, term_font));
             sprites[4].SetImage(Image.Text(frame9_line4, 0.2, 0.8, 0.2, 1.0, term_font));
             sprites[5].SetImage(Image.Text(frame9_line5, 0.2, 0.8, 0.2, 1.0, term_font));
        }
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
