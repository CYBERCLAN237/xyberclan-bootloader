#!/bin/bash

###############################################################################
# XYBERCLAN Power-Off Animation Script - Hacker Style
# Shutdown sequence with glitchy XYBERCLAN reveal
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
DARK_RED='\033[0;91m'
NC='\033[0m' # No Color

# Animation frames for XYBERCLAN (reverse order for shutdown - 9 frames)
FRAME9="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      █████╗ ███╗   ██╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔══██╗████╗  ██║
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ███████║██╔██╗ ██║
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     ██╔══██║██║╚██╗██║
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗██║  ██║██║ ╚████║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
"

FRAME8="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      █████╗ 
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔══██╗
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ███████║
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     ██╔══██║
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗██║  ██║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝
"

FRAME7="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗     
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝
"

FRAME6="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝
"

FRAME5="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗ 
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗
    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝
"

FRAME4="
    ██╗  ██╗██╗   ██╗██████╗ ███████╗
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝
     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  
     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  
    ██╔╝ ██╗   ██║   ██████╔╝███████╗
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝
"

FRAME3="
    ██╗  ██╗██╗   ██╗██████╗ 
    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗
     ╚███╔╝  ╚████╔╝ ██████╔╝
     ██╔██╗   ╚██╔╝  ██╔══██╗
    ██╔╝ ██╗   ██║   ██████╔╝
    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ 
"

FRAME2="
    ██╗  ██╗██╗   ██╗
    ╚██╗██╔╝╚██╗ ██╔╝
     ╚███╔╝  ╚████╔╝ 
     ██╔██╗   ╚██╔╝  
    ██╔╝ ██╗   ██║   
    ╚═╝  ╚═╝   ╚═╝   
"

FRAME1="
    ██╗  ██╗
    ╚██╗██╔╝
     ╚███╔╝ 
     ██╔██╗ 
    ██╔╝ ██╗
    ╚═╝  ╚═╝
"

SLOGAN="for open minded"

# Function to clear screen
clear_screen() {
    clear
}

# Function to display frame with intense glitch effect
display_frame_glitch_shutdown() {
    local frame="$1"
    local color="$2"
    local glitch_count="${3:-3}"
    
    for ((i=0; i<glitch_count; i++)); do
        # Random glitch colors
        local glitch_colors=("$RED" "$DARK_RED" "$MAGENTA" "$YELLOW")
        local random_color=${glitch_colors[$RANDOM % ${#glitch_colors[@]}]}
        
        # Show glitchy version
        echo -e "${random_color}${frame}${NC}"
        sleep 0.04
        clear_screen
        
        # Show correct color briefly
        echo -e "${color}${frame}${NC}"
        sleep 0.03
        clear_screen
    done
    
    # Final display
    echo -e "${color}${frame}${NC}"
}

# Function to type text character by character (shutdown message)
type_text() {
    local text="$1"
    local color="$2"
    local delay="${3:-0.02}"
    
    echo -n -e "${color}"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep "$delay"
    done
    echo -e "${NC}"
}

# Function to display slogan with fade effect
display_slogan_fade() {
    local spaces=$(( (80 - ${#SLOGAN}) / 2 ))
    printf "%${spaces}s" ""
    
    # Show slogan
    echo -e "${CYAN}${SLOGAN}${NC}"
    sleep 0.3
    
    # Fade effect (glitch out)
    for ((i=0; i<3; i++)); do
        clear_screen
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        printf "%${spaces}s" ""
        echo -e "${GRAY}${SLOGAN}${NC}"
        sleep 0.05
        clear_screen
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        printf "%${spaces}s" ""
        echo -e "${RED}${SLOGAN}${NC}"
        sleep 0.05
    done
}

# Main shutdown animation function
animate_shutdown() {
    local delay="${1:-0.3}"
    
    clear_screen
    
    # Shutdown header
    echo -e "${DARK_RED}╔════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${DARK_RED}║                     XYBERCLAN SHUTDOWN SEQUENCE                            ║${NC}"
    echo -e "${DARK_RED}╚════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    sleep 0.5
    
    # Shutdown messages
    type_text ">>> Terminating user sessions..." "$YELLOW" 0.015
    sleep 0.2
    type_text ">>> Stopping system services..." "$YELLOW" 0.015
    sleep 0.2
    type_text ">>> Unmounting filesystems..." "$YELLOW" 0.015
    sleep 0.2
    type_text ">>> Clearing memory..." "$YELLOW" 0.015
    sleep 0.3
    
    echo ""
    type_text ">>> Initiating XYBERCLAN shutdown protocol..." "$DARK_RED" 0.02
    sleep 0.5
    
    clear_screen
    
    # Frame 9 - Full XYBERCLAN with intense glitch
    echo ""
    display_frame_glitch_shutdown "$FRAME9" "$BRIGHT_GREEN" 4
    sleep "$delay"
    
    # Frame 8 - XYBERCLA glitching away
    clear_screen
    echo ""
    display_frame_glitch_shutdown "$FRAME8" "$GREEN" 3
    sleep "$delay"
    
    # Frame 7 - XYBERCL glitching
    clear_screen
    echo ""
    display_frame_glitch_shutdown "$FRAME7" "$CYAN" 3
    sleep "$delay"
    
    # Frame 6 - XYBERC glitching
    clear_screen
    echo ""
    display_frame_glitch_shutdown "$FRAME6" "$BLUE" 3
    sleep "$delay"
    
    # Frame 5 - XYBER glitching
    clear_screen
    echo ""
    display_frame_glitch_shutdown "$FRAME5" "$CYAN" 3
    sleep "$delay"
    
    # Frame 4 - XYBE glitching
    clear_screen
    echo ""
    display_frame_glitch_shutdown "$FRAME4" "$GREEN" 3
    sleep "$delay"
    
    # Frame 3 - XYB glitching
    clear_screen
    echo ""
    display_frame_glitch_shutdown "$FRAME3" "$CYAN" 3
    sleep "$delay"
    
    # Frame 2 - XY glitching
    clear_screen
    echo ""
    display_frame_glitch_shutdown "$FRAME2" "$BLUE" 4
    sleep "$delay"
    
    # Frame 1 - X final glitch
    clear_screen
    echo ""
    display_frame_glitch_shutdown "$FRAME1" "$MAGENTA" 4
    sleep "$delay"
    
    # Slogan fade out
    clear_screen
    echo ""
    echo ""
    echo ""
    echo ""
    echo ""
    display_slogan_fade
    
    # Final shutdown message
    clear_screen
    echo ""
    echo ""
    echo ""
    echo ""
    type_text ">>> XYBERCLAN system halted" "$DARK_RED" 0.03
    echo ""
    type_text ">>> Power off" "$GRAY" 0.05
    echo ""
    sleep 0.5
    
    # Screen fade to black
    for ((i=0; i<3; i++)); do
        clear_screen
        sleep 0.1
    done
}

# Export functions for use in other scripts
export -f animate_shutdown
export -f display_frame_glitch_shutdown

# If script is run directly, show animation
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo -e "${YELLOW}XYBERCLAN Power-Off Animation Demo${NC}"
    echo ""
    sleep 1
    animate_shutdown 0.3
    echo ""
    echo -e "${GRAY}System powered off${NC}"
fi
