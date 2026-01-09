#!/bin/bash

###############################################################################
# XYBERCLAN Plymouth Preview Tool
# Safely simulate boot animations in your terminal without affecting your OS.
###############################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_header() {
    clear
    echo -e "${CYAN}"
    echo "    ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  ██████╗██╗      █████╗ ███╗   ██╗"
    echo "    ╚██╗██╔╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██║     ██╔══██╗████╗  ██║"
    echo "     ╚███╔╝  ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║     ██║     ███████║██╔██╗ ██║"
    echo "     ██╔██╗   ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██║     ██║     ██╔══██║██║╚██╗██║"
    echo "    ██╔╝ ██╗   ██║   ██████╔╝███████╗██║  ██║╚██████╗███████╗██║  ██║██║ ╚████║"
    echo "    ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝"
    echo -e "${NC}"
    echo -e "                       ${WHITE}Plymouth Theme Preview Tool${NC}"
    echo -e "        ${YELLOW}Safe Terminal Simulation - No System Changes Required${NC}"
    echo ""
}

show_menu() {
    echo -e "${WHITE}Select a theme style to preview:${NC}"
    echo -e "1) ${GREEN}Hacker Style${NC} (Logo centered, matrix decryption sequence)"
    echo -e "2) ${BLUE}Classic Style${NC} (Logo on top, rotating loading spinner below)"
    echo -e "3) ${RED}Exit${NC}"
    echo ""
    read -p "Choice [1-3]: " choice
}

main() {
    while true; do
        show_header
        show_menu
        
        case $choice in
            1)
                echo -e "${YELLOW}Launching Hacker Style preview...${NC}"
                sleep 1
                bash "$SCRIPT_DIR/boot-animation.sh"
                echo -e "\n${GREEN}Preview complete.${NC} Press Enter to return to menu."
                read -r
                ;;
            2)
                echo -e "${YELLOW}Launching Classic Style preview...${NC}"
                sleep 1
                bash "$SCRIPT_DIR/boot-animation-classic.sh"
                echo -e "\n${GREEN}Preview complete.${NC} Press Enter to return to menu."
                read -r
                ;;
            3)
                echo -e "${CYAN}Stay open minded! Goodbye.${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid choice. Try again.${NC}"
                sleep 1
                ;;
        esac
    done
}

main
